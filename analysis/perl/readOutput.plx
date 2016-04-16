#!/usr/bin/perl -w

$\="\n";
$output_file="@ARGV";

open(OUT, "< $output_file")
  or die "Could not open $output_file";

while(<OUT>){
	$line_number=$.;
	if(/Area of species/) {
		print "Pattern found in line: ", $line_number,"\n";
		($rubbish, $value) = split(/   /);
		print $value*2;
#		print join(':', split(/   /)); #, "\n"); 
#		print $_;
	}
#	if(eof()) {
#		last;
#	}
}

print "This file has ",$line_number," lines.\n";

close(OUT);
