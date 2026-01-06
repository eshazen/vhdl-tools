#!/usr/bin/perl
#------------------------------------------------------------
# this package provides:
#   CleanHDL to read a file into an array, stripping out
#     blank lines and comments
#   ReadConstants to read VHDL constants
#   ReadTypes to read VHDL types as records
#   ReadTypeDefs to read VHDL packages with 'type' definitions
#   ReadEntity to read VHDL entity and parse generics, ports
#   IsRange looks for " to " or " downto " in a string
#   GetRange returns base type and range for arrays
# See functions below for details
#------------------------------------------------------------
package ReadTypes;

use Data::Dumper;

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(ReadTypes ReadConstants ReadEntity ReadTypeDefs CleanHDL GetRange IsRange);

# variable to hold possible errors
$errors = '';

# variable to count user types found
$ntypes = 0;

# variable to count constants found
$nconstants = 0;

# variable indicating this is valid VHDL
$valid = 0;

# debug control
$debug = 0;


#------------------------------------------------------------
# IsRange( $str)
# Return boolean if a range (start to/downto end) is found
#------------------------------------------------------------
sub IsRange {
    my $str = shift;
    return( $str =~ / to / or $str =~ / downto /);
}


#------------------------------------------------------------
# ($name, $range) = GetRange( $str)
#
# parse a VHDL array type
#    like "<name> ( <start> [down]to <end>)"
#      or "<name> range <start> [down]to <end"
#------------------------------------------------------------
sub GetRange {

    my $debug = 1;

    my $str = shift;
    my $name;
    my $range;

    print ">> GetRange( $str)\n" if( $debug);

    if( $str =~ /range/) {
	( $name, $range) = $str =~ /^\s*(.*)\s+range\s+(.*)\s*$/
    } else {
	( $name, $range) = $str =~ /\s*(.*)\(\s*(.*)\)/;
    }
    $name =~ s/ //g;		# strip any whitespace
    print ">> GetRange -> name=\"$name\" range=\"$range\"\n" if( $debug);
    return( $name, $range);
}


#------------------------------------------------------------
# CleanHDL( FH)
#
# read VHDL and strip blank lines and comments
# return a reference to an array with a list of lines
#------------------------------------------------------------
sub CleanHDL {
    my $fh = shift;
    my $stuff = [ ];		# empty array

    while( my $line = <$fh>) {
	chomp $line;
	print "CLEAN LINE: $line\n" if( $debug);

	# strip comments
	my $temp = $line;
	if( $line =~ /--/) {
	    print "  has comment\n" if( $debug);
	    ($temp) = $line =~ /^(.*)--/;
	}
	$line = $temp;
	print "  Comment strip: $line\n" if( $debug);

	# ignore blank lines
	if( $line !~ /^\s*$/) {
	    print "  (non-blank)\n" if( $debug);
	    push @$stuff, $line;
	} else {
	    print "  (blank)\n" if( $debug);
	}
    }

    return $stuff;
}


#------------------------------------------------------------
# ReadTypeDefs( FH)
#
# read a file with 'type' statements defining arrays of other types
# expect 'type <name> is array (range) of <othertype>;
# return a reference to a hash:
#
# key:  new type name
# value: reference to another hash
#   key "type"   -> type e.g. tdcpolmux_rt
#   key "range"  -> range e.g. "integer range <>"
#------------------------------------------------------------
sub ReadTypeDefs {
    my $fh = shift;
    my %types;

    while( my $line = <$fh>) {
	chomp $line;
	# check for valid VHDL, look for "library ieee;"
	$valid = 1 if( $line =~ /^\s*library ieee\;/);

	if( $line =~ /^\s*type/) {
	    print "TYPE def\n" if( $debug);
	    my( $name, $range, $type) =
		$line =~ /^\s*type\s+(\w+)\s+is\s+array\s+\(([^)]+)\)\s+of\s+([^;]+);$/;	    
	    $types{$name}->{"type"} = $type;
	    $types{$name}->{"range"} = $range;
	}
    }
    return \%types;
}



#------------------------------------------------------------
# ReadConstants( FH)
#
# read a VHDL file of constant definitions
# extract the type and initialized value of each
# return a reference to a hash:
#
# key:   constant name
# value: reference to another hash
#   key "type"  -> type e.g. "natural"
#   key "init"  -> initialzer e.g. "20";
#------------------------------------------------------------

sub ReadConstants {
    my $stuff = shift;
    my %const;

    foreach my $line ( @$stuff) {
#    while( my $line = <$fh>) {
	chomp $line;
	# check for valid VHDL, look for "library ieee;"
	$valid = 1 if( $line =~ /^\s*library ieee\;/);

	# look for constant def
	if( $line =~ /^\s*constant\s+/) {
	    my( $name, $type, $init) = $line =~ /constant\s+(\w+)\s*:\s*(\w+)\s*:=\s*(\w+);/;
	    $const{$name}->{"type"} = $type;
	    $const{$name}->{"init"} = $init;
	}
    }

    if( !$valid) {
	$errors .= "Not a valid VHDL file?\n";
    }

    $nconstants = keys %const;
    if( $nconstants < 5) {
	$errors .= "No valid constants found\n";
    }

    return \%const;
}    


#------------------------------------------------------------
# ReadTypes( @input [, $hashref])
#
# Parse VHDL (cleaned with CleanHDL) lines
# return a reference to a hash (optionally merged with supplied one):
#
# key:   "NAMELIST" -> reference to array of types in input order
#        use this instead of "keys" so names are in correct order
#
# key:   VHDL record types as in "type <name> is record"
#                             or "type <name> is array"
#                             or "subtype <name> is <othertype>"
#
# value: reference to another hash
#
#   key:    "NAMELIST" -> reference to array of names in declared order
#                         (only used for "record" type)
#   key:    "CLASS" -> "record", "array", "subtype"
#
# for records, there is a collection of one or more keys corresponding
# to elements in the record:
#
#   key:    element name in the record
#   value:  reference to third-level hash
#
#      key "user" -> TRUE if user-defined type (record), FALSE if standard type
#      key "type" -> type "std_logic", "std_logic_vector(...)" or user defined type
#      key "size" -> size of std_logic_vector
#
# Arrays:  "array <def_type> range (<range>) of <base_type>"
#
#   key:    <def_type>
#   value:  reference to third-level hash
#
#      key "type"    ->  <base_type>
#      key "range"   ->  array range
#
# 

#------------------------------------------------------------

# states while parsing
use constant {
    mIDLE => 0,
    mINREC => 1,
};
#
# read from supplied filehandle or list of VHDL lines,
#   return hash reference
# optional second arg is has reference to add to
#
sub ReadTypes {
    my $debug = 1;

    my $nar = scalar(@_);
    my $types;

    if( $nar > 1) {
	$types = $_[1];
	print "ReadTypes( adding to hash...\n" if($debug);
    } else {
	print "ReadTypes( using empty hash...\n" if($debug);
    }
    my $input = $_[0];
    my $inputLines;

    if( ref($input) eq "GLOB") {
	$inputLines = CleanHDL( $input);
    } else {
	$inputLines = $input;
    }

    # used for array types;
    my $type;
    my $range;
    my $base;

    my $mode = mIDLE;
 
    my $namelist;

    # existing NAMELIST or new one via autovivification
    my $typelist = $types->{"NAMELIST"};

    foreach my $line ( @$inputLines) {
	chomp $line;

	print "LINE: $line\n" if($debug);

	# check for valid VHDL, look for "library ieee;"
	$valid = 1 if( $line =~ /^\s*library ieee\;/);

	# look for "subtype <name> is <othertype>
	if( $line =~ /^\s*subtype\s+/) {
	    my $othertype;
	    ($type,$othertype) = $line =~ /^\s*subtype\s+(\w+)\s+is\s+([^;]+);\s*$/;
	    print "Subtype \"$type\" is \"$othertype\"\n" if( $debug);
	    if( IsRange( $othertype)) {
		($base,$range) = GetRange( $othertype);
	    } else {
		print "UNKNOWN subtype in $line\n";
		exit;
	    }
	    $types->{$type}->{"CLASS"} = "subtype";
	    $types->{$type}->{"type"} = $base;
	    $types->{$type}->{"range"} = $range;
	}

	# look for "name.....is array"
	if( $line =~ /is\s+array/) {
	    # expect entire def on same line for now
            # e.g. "type polmux_pipe_art is array (NPOLMUX-1 downto 0) of tdcpolmux_rt;"
	    if( $line =~ /^\s*type\s+\w+\s+is\s+array\s*\([^)]+\s*\)\s+of\s+[^;]+;\s*$/ ) {
		($type, $range, $base) = 
		    $line =~ /^\s*type\s+(\w+)\s+is\s+array\s*\(([^)]+)\s*\)\s+of\s+([^;]+);\s*$/;
		print "Array \"$type\" range($range) of \"$base\"\n" if( $debug);
		$types->{$type}->{"CLASS"} = "array";
		$types->{$type}->{"type"} = $base;
		$types->{$type}->{"range"} = $range;
		push @{$typelist}, $type; # save type name on list
	    } else {
		print "malformed array type: $line\n";
		exit;
	    }
	}

	# look for "name.....is record"
	if( $line =~ /is\s+record/) {
	    ($type) = $line =~ /type (\w+) is record/ ;
	    print "Start record\n" if($debug);
	    if( $mode != mIDLE) {
		print "Error, already inside type def\n";
		exit;
	    }
	    $mode = mINREC;
	    push @{$typelist}, $type; # save type name on list
	    $namelist = [];	# create empty entity name list
	}

	# look for "end record [name]"
	if( $line =~ /end record/) {
	    my $ename;
	    if( $line =~ /end record\s+\w+;/) {
		print "End record\n" if($debug);
	        ($ename) = $line =~ /end record\s+(\w+);/;
	    } else {
		$ename = $type;
	    }
	    if( $ename ne $type or $mode != mINREC) {
		print "Error in type $type, missing end or missing start\n";
		print "end name = $ename\n";
		exit;
	    } else {
		$mode = mIDLE;
		$types->{$type}->{"NAMELIST"} = [@{$namelist}]; # copy array and take reference
		$types->{$type}->{"CLASS"} = "record";
	    }
	}
	
	# inside a type def
	if( $mode == mINREC) {
	    # check for what looks like an element def
	    print "Inside record with line: $line\n" if($debug);
	    if( $line =~ /^\s*\w+\s*:/) {
		print "Parsing a def\n" if($debug);
		my ($var,$typ) = $line =~ /^\s*(\w+)\s*:\s*([^;]*)/;
		print "var=$var typ=$typ\n" if( $debug);
		$types->{$type}->{$var}->{"type"} = $typ;
		$types->{$type}->{$var}->{"user"} = 
		    !( $typ =~ /std_logic/ ||
		       $typ =~ /signed/ ||
		       $typ =~ /unsigned/ );
		# vector, get size
		my $siz = 0;
		($siz) = $typ =~ /std_logic_vector\((\w+)-/ if( $typ =~ /std_logic_vector/);
		$types->{$type}->{$var}->{"size"} = $siz;
		# add name to list
		push @{$namelist}, $var;
	    }
	}
    }

    if( !$valid) {
	$errors .= "Not a valid VHDL file?\n";
    }

    $ntypes = keys %{$types};
    if( !$ntypes) {
	$errors .= "No valid type definitions found\n";
    }

    $types->{"NAMELIST"} = $typelist;
    return $types;
}


#---------------------------------------------------------------------------
# ReadEntity(FH)
#
# Read VHDL input lines, look for a single (or first)
# entity declaration.  Parse the generics and ports, and
# return a list of two hash references
#
# $generics->{"_name_"}->{"type"}    type
#                      ->{"init"}    optional initialization
#
# $ports->{"_name_"}->{"type"}       type (full array time for arrays)
#                   ->{"dir"}        in, out, inout, buffer
#                   ->{"range"}      range for array undef for scalar
#                   ->{"base_type"}  base type for array undef for scalar
#
#
# $namelist                          array ref ports in order
#
# the parser is pretty simple-minded and in particular would
# be confused by punctuation inside quoted strings.
#
# also the "entity ... is" and "end entity ...;" must be
# on lines by themselves
#---------------------------------------------------------------------------
sub ReadEntity {
    my $generics;
    my $ports;

    my $ename = 0;
    my $entity = "";
    my $generic_str;
    my $port_str;

    my $debug = 1;

    my $namelist = [];     # create empty port name list

    my $input = $_[0];
    my $inputLines;

    if( ref($input) eq "GLOB") {
	$inputLines = CleanHDL( $input);
    } else {
	$inputLines = $input;
    }

    foreach my $line( @$inputLines) {
	chomp $line;

	# look for end of entity, end loop if names match
	if( $line =~ /^\s*end\s+entity/) {
	    my ($name) = $line =~ /^\s*end\s+entity\s+(\w+)\s*;/;
	    print "-- end entity $name\n" if($debug);
	    die "Mismatched names ($name vs $ename)" if( $name ne $ename);
	    last;
	}

	# inside entity
	if( $ename) {
	    # strip comments
	    my $stmt = $line;
	    if( $line =~ /--/) {
		($stmt) = $line =~ /^(.*)--/;
	    }
	    # ignore blank lines
	    if( $stmt =~ /^\s*$/) {
		#	    print "-- blank line\n";
	    } else {
		$entity .= $stmt;	# append to string
	    }
	}

	# look for start of entity
	if( $line =~ /^\s*entity/) {
	    ($ename) = $line =~ /^\s*entity\s+(\w+)\s+is/;
	    print "-- start entity $ename\n" if($debug);
	}
    }

    print "Done reading entity $ename\n" if($debug);

    # collapse multiple spaces
    $entity =~ tr/ //s;

    # grab generics if any as one string
    if( $entity =~ /generic\s*\(/) {
	($generic_str) = $entity =~ /generic\s*\(([^)]+)\)\s*;/;
    }

    # grab ports if any as one string
    if( $entity =~ /port\s*\(/) {
	($port_str) = $entity =~ /port\s*\((.+)\)\s*;/;
    }

    # parse generics into a list
    # save in a hash
    my $generics;

    # print "Generics:\n$generic_str\n";
    # split by ";" with surrounding whitespace
    my @g_list = split /\s*;\s*/, $generic_str;
    foreach my $generic ( @g_list) {
	my $name;
	my $type;
	my $init = 0;
	if( $generic =~ /:=/) {
	    ($name,$type,$init) = $generic =~ /^\s*([^: ]+)\s*:\s*([^: ]+)\s*:=(.*)$/;
	} else {
	    ($name,$type) = $generic =~ /^\s*([^: ]+)\s*:\s*(.*)$/;
	}
	print "GENERIC name: $name type: $type init: $init\n" if($debug);
	$generics->{$name}->{"type"} = $type;
	$generics->{$name}->{"init"} = $init if( $init);
    }

    # parse ports into a list
    # split by ";" with surrounding whitespace
    my $ports;

    # split ports by ";"
    my @p_list = split /\s*;\s*/, $port_str;
    foreach my $port ( @p_list) {
	print "Parsing port \"$port\"\n" if($debug);
	my ($name,$dir,$type) = $port =~ /^\s*([^: ]+)\s*:\s+(\w+)\s+(.*)$/;
	$type =~ s/ $//;
	print "PORT name: \"$name\" dir: \"$dir\" type: \"$type\"\n" if($debug);
	$ports->{$name}->{"dir"} = $dir;
	$ports->{$name}->{"type"} = $type;
	if( IsRange( $type)) {
	    print "  <><>Port $type is array\n" if($debug);
	    my ($base_type, $range) = GetRange( $type);
	    $ports->{$name}->{"range"} = $range;
	    $ports->{$name}->{"base_type"} = $base_type;
	} else {
	    print "  <><>Port $type is scalar\n" if($debug);
	}
	push @{$namelist}, $name;
    }

    return ( $generics, $ports, $namelist);

} # end sub


1;
