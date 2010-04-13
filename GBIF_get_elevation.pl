#!/usr/bin/perl -w
use strict;

my $infile = "test.in";
my $outfile ="test.out";
open IN, "<", $infile;
open OUT, ">", $outfile;

while ($infile = <IN>)
{
    my $line = $infile;
    chomp $line;
    my @line = split /\t/, $line;
    my $taxon = shift @line;
    my $year = shift @line;
    my $lat = shift @line;
    my $long = shift @line;
    my $id = shift @line;


    my $return = `curl -d \"X_Value=$long&Y_Value=$lat&Elevation_Units=METERS&Source_Layer=-1&Elevation_only=1\" gisdata.usgs.gov/XMLWebServices2/Elevation_service.asmx/getElevation`;
    
    
    $return =~ m/<Elevation>(\d+)<\/Elevation>/;
    my $elevation = $1;
    print OUT "$taxon\t$year\t$lat\t$long\t$elevation\t$id\n";

}

close IN;
close OUT;
exit;