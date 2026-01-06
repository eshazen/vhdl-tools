#!/usr/bin/perl
#
# read a UUT and create a testbench
#
# can automatically handle many cases by parsing a top-level
# VHDL file and parsing the entity declaration
#
# expects the following port (types) on the top level:
#   l0mdt_control_rt           clock, reset, BX strobe
#   l0mdt_ttc_rt               TTC signals
#   any from mdttp_types_pkg   any L0MDT defined types [1]
#
# Notes:
# [1] - ports used for the testbench must contain a data valid
# signal named 'dv' in the top-level record -or- a configuration
# file must be used to specify the signal name
#
#
use strict;
use lib '.';
use ReadTypes;
use Config::File;
use Data::Dumper;
use TestBench;
use Getopt::Std;

$Getopt::Std::STANDARD_HELP_VERSION = 1;
$main::VERSION = "0.1";
sub main::HELP_MESSAGE {
    print "usage: $0 -f <config_file> -t <types_file>  -p <pkgs_file> -c <const_file>\n";
    print "          <top_entity> <output_file>\n";
};

# strip any leading/trailing quotes
sub dquot {
    my ($str) = @_;
    $str =~ s/^"//;
    $str =~ s/"$//g;
    return $str;
}

my $debug = 1;

# list of valid configuration file modifiers
my @confvar = ( "DV", "TIME", "SIGNALS", "IGNORE" );

#------------------------------------------------------------------------
# parse arguments and open files
#------------------------------------------------------------------------
my %opts;
getopts('f:t:p:c:y', \%opts);
my $opt = \%opts;

print Dumper($opt) if( $debug);

# define all the defaults
my $f_types = "l0mdt_buses_types_pkg.vhd";
my $f_pkgs = "my_types_pkg.vhd";
my $f_const = "l0mdt_buses_constants_pkg.vhd";
my $f_conf = "make_tb_config.txt";
my $yes = 0;

$f_conf = $opt->{'c'} if( $opt->{'c'});
#--- read the config file
my $conf;
if( $f_conf) {
    $conf = Config::File::read_config_file($f_conf);

    if( $debug > 1) {
	print "-----> Config:\n";
	print Dumper($conf);
    }
}

# check for file names in config file
$f_types = dquot($conf->{'files'}->{'TYPES'}) if( $conf->{'files'}->{'TYPES'});
$f_pkgs = dquot($conf->{'files'}->{'PKGS'}) if( $conf->{'files'}->{'PKGS'});
$f_const = dquot($conf->{'files'}->{'CONST'}) if( $conf->{'files'}->{'CONST'});

# override with arguments
$f_types = $opt->{'t'} if( $opt->{'t'});
$f_pkgs = $opt->{'p'} if( $opt->{'p'});
$f_const = $opt->{'c'} if( $opt->{'c'});
$yes = 1 if( $opt->{'y'});

my $f_uut = 0;
my $f_output = 0;

my $na = $#ARGV+1;
if( $na < 2) {
    print "need input and output files\n";
    exit;
}

$f_uut = $ARGV[0];
$f_output = $ARGV[1];

# get entity names for the UUT and testbench
my $uut = 0;
my $tbe = 0;

if( $f_output !~ /\.vhd[l]?$/) {
    print "Output should be a .vhd or .vhdl file\n";
    exit;
} else {
    ($tbe) = $f_output =~ /(\w+)\.vhd[l]?$/;
    print "Test bench entity name: $tbe\n";
}


if( $f_uut !~ /\.vhd[l]?$/) {
    print "Input should be a .vhd or .vhdl file\n";
    exit;
} else {
    ($uut) = $f_uut =~ /(\w+)\.vhd[l]?$/;
    print "UUT entity name: $uut\n";
}

# check for over-write
if ( -e $f_output && !$yes) {
    print qq{File $f_output exists.  I'm about to over-write it
with the generated testbench.  Is this OK (y/n)?};
    my $yesno = <STDIN>;
    die "Aborted" if( $yesno !~ /^[yY]/);
}

open VHT, "< $f_types" or die "Opening types \"$f_types\": $!";
print "Reading $f_types\n";
open VHU, "< $f_uut" or die "Opening UUT $f_uut: $!";
print "Reading $f_uut\n";
open VHP, "< $f_pkgs" or die "Opening packages $f_pkgs: $!";
print "Reading $f_pkgs\n";
open VHO, "> $f_output" or die "Opening output $f_output: $!";
print "Writing $f_output\n";

#------------------------------------------------------------------------
# Read the l0mdt_buses_types file to get a catalogue of MDT record types
#------------------------------------------------------------------------

# use external module to read and process the VHDL types
my $types = ReadTypes( \*VHT);

if( $ReadTypes::errors) {
    print "Errors reading input files:\n$ReadTypes::errors";
    exit;
}

print "$ReadTypes::ntypes user types found\n" if( $debug);
print Dumper($types) if( $debug);

#------------------------------------------------------------------------
# Read the UUT to get ports and generics from the entity declaration
#------------------------------------------------------------------------

my $generics;
my $ports;
my $namelist;
($generics, $ports, $namelist) = ReadEntity( \*VHU);

#--- dump results
if( $debug > 1) {
    print "-----> Entity:\n";
    print Dumper($generics) if( $generics);
    print Dumper($ports) if( $ports);
}

#-----------------------------------------------------------------
# loop over the ports and build signal lists, clock options, etc
#-----------------------------------------------------------------
print "Missing ctrl port" if( !$ports->{"ctrl"});
print "Missing TTC port" if( !$ports->{"ttc"});

foreach my $portkey ( keys %{$ports}) { # loop over ports
    print "\nPORT: $portkey\n" if( $debug > 1);
    my $port = $ports->{$portkey};
    # ignore ctrl and ttc ports on this pass
    if( $portkey ne "ctrl" && $portkey ne "ttc" && !$conf->{$portkey}->{"IGNORE"}) {
	# check if this is an MDT custom type
	my $type = $port->{"type"};
	print "Checking TYPE $type\n" if( $debug);
	my $base_type = $type;
	my $range;

	# check for array on the port
	if( $ports->{$portkey}->{"range"}) {
	    $base_type = $ports->{$portkey}->{"base_type"};
	}

	if( $types->{$base_type}) {
	    #----- legit MDT type port -----
	    print "  Found MDT type $type\n" if( $debug > 1);
	    # check direction, set testbench boolean
	    my $dir = $port->{"dir"};
	    if( $dir eq "in") {
		$port->{"TB"} = "READER";
	    } elsif( $dir eq "out") {
		$port->{"TB"} = "WRITER";
	    } else {
		die "Unknown direction $dir on port $portkey\n";
	    }
	    #----- fill in default info
	    $port->{"SIGNALS"} = "default";
	    $port->{"DV"} = "dv";
	    $port->{"TIME"} = "orn,bcn";
	    # check for config data
	    if( $conf->{$portkey}) {
		print "  There is config data\n" if( $debug > 1);
		my $cfg = $conf->{$portkey};
		print "cfg = ", Dumper( $cfg) if( $debug > 1);
		foreach my $var ( @confvar ) {
		    print "  copying $var\n" if( $debug > 1);
		    $port->{$var} = $cfg->{$var} if( $cfg->{$var});
		}
	    }
	    #-------------------------------
	} else {
	    print "  WARNING:  I don't know what to do with a $type port, so skipping it\n";
	}
    } else {
	print "  (ignored)\n" if( $debug > 1);;
    }
}

print "----- port summary -----\n" if( $debug);
foreach my $portkey ( keys %{$ports}) {
    print "\nPORT: $portkey\n" if( $debug);
    my $port = $ports->{$portkey};
    print Dumper( $port) if( $debug);
}


#------------------------------------------------------------
# start generating the testbench
#------------------------------------------------------------
my $date = `date`;
chomp $date;
print VHO qq{----------------------------------------------------------------------
-- Automatically generated $date from:
-- $f_types-
-- $f_uut
-- $f_conf
-- Testbench entity: $tbe   UUT: $uut
----------------------------------------------------------------------
};

print VHO $TestBench::Libs;	# libraries

# entity start
print VHO qq{
entity $tbe is
end entity $tbe;

architecture arch of $tbe is
};

print VHO $TestBench::Header;

# signals for arch header
my $sigs = "";

# we have to make multiple passes through the ports.  First one, we collect
# signal names which must go in the arch header.  Second one, we
# generate the processes

#------------------------------------------------------------
# Pass 1
#------------------------------------------------------------
foreach my $portkey ( keys %{$ports}) {
    my $port = $ports->{$portkey};
    my $type = $port->{"type"};
    if( $port->{"TB"}) {
	my $tb = $port->{"TB"};
	print "Custom signal list not yet implemented\n" if( $port->{"SIGNALS"});
	#--- variables, for this process alone ---
	$port->{"vars"} = "    variable v_$portkey : $type;\n";
	#--- signals, for arch header ---
	if( $tb eq "READER") {
	    print "Generating TB reader for $portkey\n";
	    $sigs .= "  signal p_$portkey : $type;\n";
	    $sigs .= "  signal s_$portkey : $type;\n";
	    $sigs .= "  signal $portkey" . "_dav : std_logic := '0';\n";
	} elsif( $tb eq "WRITER") {
	    print "Generating TB writer for $portkey\n";
	    $sigs .= qq"  signal p_$portkey : $type;\n";
	}

    }
}

print VHO $sigs;

print VHO qq{
begin   -- architecture arch
  clock_1 : entity work.clock
    generic map (
      freq => freq)
    port map (
      ctrl => p_ctrl,
      ttc  => p_ttc);
};

# now we map the UUT
print VHO qq{

  uut : entity work.$uut
  generic map( clk_per_bx => 8)
  port map (};
# loop over ports in entity and connect them

for my $name ( @{$namelist}) {
    print VHO "\n    $name => p_$name";
    print VHO "," if( $name ne @{$namelist}[$#$namelist]);
}
print VHO "\n);\n";

# generate the process for orbit/bunch count
print VHO $TestBench::ClockProcess;

#------------------------------------------------------------
# Pass 2
#------------------------------------------------------------
foreach my $portkey ( keys %{$ports}) {
    my $port = $ports->{$portkey};
    my $type = $port->{"type"};
    if( $port->{"TB"}) {
	my $tb = $port->{"TB"};
	my $dv = $port->{"DV"};
	if( $tb eq "READER") {
	    print VHO "--------------- BEGIN $portkey (READER) ---------------\n";

	    foreach my $sig ( @{$types->{$type}->{"NAMELIST"}}) {
		print "WIRE: $sig\n" if( $debug);
		if( $sig eq $dv) {
		    print VHO "  p_$portkey.$dv <= $portkey" . "_dav;\n";
		} else {
		    print VHO "  p_$portkey.$sig <= s_$portkey.$sig;\n";
		}
	    }

	    # open the file and start the process
	    printf VHO $TestBench::ReaderProcessFormat, 
	               $portkey, $portkey, $type, $portkey, 
	    $portkey, $portkey, $portkey, $portkey, $portkey;

	    print VHO "--------------- END $portkey (READER) ---------------\n";
	} else {
	    print VHO "--------------- BEGIN $portkey (WRITER) ---------------\n";

	    printf VHO $TestBench::WriterProcessFormat,
	    $portkey, $portkey, $type, $portkey, $portkey, $dv, $portkey, $portkey, $portkey;
	    
	    print VHO "--------------- END $portkey (WRITER) ---------------\n";
	}
    }
}




print VHO "end architecture arch;\n";
