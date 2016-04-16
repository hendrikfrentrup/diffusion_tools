#!/bin/bash

#for sys in WCA LJ EPS2; do
# for pore in h1.5 h4.0;  do
#  for rho in rho001 rho01 rho05; do
#   if [[ "$pore" == "h1.5" ]]; then
#    XRANGE=-1.25:1.25
#   elif [[ "$pore" == "h4.0" ]]; then
#    XRANGE=-2.75:2.75
#   fi
#XRANGE=-1.25:1.25

a=3
gnuplot << EOF

set terminal postscript enhanced color "Helvetica" 24
unset key

cd "/home/hf210/molsim/md-nemd/adsor/"

#set yrange [-0.02:0.1]

set output "/home/hf210/molsim/md-nemd/adsor/plots/prezi_temp_grad.eps"


# plot temp
set xlabel "{/Times-Italic z} [{/Symbol s}]"
#set ylabel "{/Times-Italic v_x} [({/Symbol e}/m)^{(1/2)}]"
set ylabel "{/Times-Italic T} [{/Symbol e}/k_{B}]"
#set xrange[$XRANGE]
plot "./WCA/h1.5/rho05/f05/gradient0.dat" u 1:3 w l lw $a, \
     "./WCA/h1.5/rho05/f2/gradient0.dat" u 1:3 w l lw $a, \
     "./WCA/h1.5/rho05/f4/gradient0.dat" u 1:3 w l lw $a

#plot "./WCA/h1.5/rho05/f8/profile0.dat" u 1:(-1*\$3) w l title 'WCA wall'#, \
#     "./LJ/h1.5/rho05/fx6/profile0.dat" u 1:(-1*\$3) w l title 'LJ wall ({/Symbol e}=1.0', \
#     "./EPS2/h1.5/rho05/fxx/profile0.dat" u 1:(-1*\$3) w l title 'LJ wall ({/Symbol e}=2.0'

set output "/home/hf210/molsim/md-nemd/adsor/plots/prezi_dens_grad.eps"

# plot dens
set xlabel "{/Times-Italic z} [{/Symbol s}]"
set ylabel "{/Symbol-Oblique r} [{/Symbol s}^{-3}]"
#set xrange[$XRANGE]
plot "./WCA/h1.5/rho05/f05/norm_gradient0.dat" u 1:2 w l lw $a, \
     "./WCA/h1.5/rho05/f2/norm_gradient0.dat" u 1:2 w l lw $a, \
     "./WCA/h1.5/rho05/f4/norm_gradient0.dat" u 1:2 w l lw $a

#     "./LJ/h1.5/rho05/fx6/norm_profile0.dat" u 1:2 w l title 'LJ wall ({/Symbol e}=1.0', \
#     "./EPS2/h1.5/rho05/fxx/norm_profile0.dat" u 1:2 w l title 'LJ wall ({/Symbol e}=2.0'

EOF

#  done
# done
#done

