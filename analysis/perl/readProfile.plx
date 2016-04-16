#!/usr/bin/perl -w

$\="\n";
$output_file="@ARGV";

open(OUT, "< $output_file")
  or die "Could not open $output_file";

while(<OUT>){
	$line_number=$.;
}
@out=(1..$line_number);
while(<OUT>){
		($pos, $rubbish) = split(/    /);
		@out[$.]=$pos;
		print $rubbish;
}

foreach(@out){
	print $_;
}


close(OUT);
