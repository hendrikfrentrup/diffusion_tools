#!/bin/bash

XRANGE=-2.75:2.75
gnuplot << EOF

set terminal postscript enhanced color "Helvetica" 24
unset key

cd "/home/frentrup/molsim/md-nemd/adsor/"

#set yrange [-0.02:0.1]

set output "/home/frentrup/molsim/md-nemd/adsor/plots/cms_rho_profile.eps"

# plot densities
set xlabel "{/Times-Italic z} [{/Symbol s}]"
set ylabel "{/Symbol r} [{/Symbol s}^{-3}]"
set xrange[$XRANGE]
plot "./WCA/h1.5/rho05/f1/norm_profile0.dat" u 1:2 w l lw 4 title 'WCA wall', \
     "./WCA/h4.0/rho05/f1/norm_profile0.dat" u 1:2 w l lw 4 title 'LJ wall ({/Symbol e}=2.0)'

EOF

#  done
# done
#done

