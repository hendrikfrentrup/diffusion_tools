#!/usr/bin/perl -w

#$\="\n";
#$,="      ";

{
    local $/ = "\n";
    while(<>){
       $temp = $_;
       ($t, $rho, undef) =~ x/$temp/;   #split("     ",$_); 
       print $. ,":" , $_, " read as t=", $t, " and rho=", $rho, "\n";
    }
}

