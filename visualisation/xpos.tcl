set selec [atomselect 0 "index 493" frame first]
set outfile [open "test0.dat" w]
for {set i 0} {$i < 120} {incr i} {
puts $outfile [$selec get {x z}]
set selec [atomselect 0 "index 493" frame $i]
} 
