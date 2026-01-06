#!/usr/bin/perl
#
# read VHDL type definitions from 
# make a human-readable summary of the types
#
use strict;
use lib '.';
use Data::Dumper;
use ReadTypes;

my $na = $#ARGV+1;
die "usage: $0 types.vhd ... entity.vhd" if( $na < 2);
my $f_entity = $ARGV[$na-1];

open VHC, "< $f_entity" or die "Opening $f_entity: $!";

# process all files as types for except last one
my $types;
for( my $i=0; $i<$na-1; $i++) {
    my $f_types = $ARGV[$i];
    print "Reading $f_types\n";
    open VHI, "< $f_types" or die "Opening $f_types: $!";
    if( $i == 0) {
	$types = ReadTypes( CleanHDL( \*VHI));
    } else {
	$types = ReadTypes( CleanHDL( \*VHI), $types);
    }
}

if( $ReadTypes::errors) {
    print "Errors reading VHDL types:\n$ReadTypes::errors";
    exit;
}

my $const;
my ($generics, $ports, $namelist)  = ReadEntity( CleanHDL( \*VHC));


print "---------- types -------------\n";
print Dumper( $types);
print "------------------------------\n";

print "---------- entity ------------\n";
print "GENERICS:\n", Dumper( $generics);
print "PORTS:\n", Dumper( $ports);
print "NAMELIST:\n", Dumper( $namelist);
print "------------------------------\n";

foreach my $name ( @{$namelist}) {
    my $type = $ports->{$name}->{"type"};
    print "PORT: $name  TYPE: $type\n";

    my $base_type = $type;
    my $range;

    if( IsRange( $type)) {
	($base_type, $range) = GetRange( $type);
    }
    
    if( $types->{$base_type}) {
	print "  known type:  $base_type\n";
    } else {
	print "  unknown type: \"$base_type\"\n";
    }
}
