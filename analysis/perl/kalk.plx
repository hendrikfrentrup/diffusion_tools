#!/usr/bin/perl -w

$file="@ARGV";

open(FH, "< $file")
  or die "could not read $file";

local $/ = "\n"; # use line break for jump to next array element

$porewidth=5;
$porex=8;

$ln=1;
while(<>)	#($zeile=<FH>)
	{
	@data=$_; # read each line into data
	#$ln++; # <STDIN>;
	}

foreach (5..10)
{ 
print @data[$_] "\n";
}

close(FH);
