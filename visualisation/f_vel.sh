#!/bin/bash

for sys in WCA LJ EPS2; do
 for pore in h1.5 h4.0;  do
  for rho in rho001 rho01 rho05; do
   if [[ "$pore" == "h1.5" ]]; then
    XRANGE=-1.25:1.25
   elif [[ "$pore" == "h4.0" ]]; then
    XRANGE=-2.75:2.75
   fi

gnuplot << EOF

set terminal postscript enhanced color "Helvetica" 24
unset key

cd "/home/frentrup/molsim/md-nemd/adsor/$sys/$pore/$rho"

#set yrange [-0.02:0.1]

set output "/home/frentrup/molsim/md-nemd/adsor/plots/f-vel_$sys $pore $rho.eps"

# plot velocities
set xlabel "{/Times-Italic z} [{/Symbol s}]"
set ylabel "{/Times-Italic v_x} [({/Symbol e}/m)^{(1/2)}]"
set xrange[$XRANGE]
plot "./f005/profile0.dat" u 1:(-1*\$3) w l, \
     "./f02/profile0.dat" u 1:(-1*\$3) w l, \
     "./f05/profile0.dat" u 1:(-1*\$3) w l, \
     "./f1/profile0.dat" u 1:(-1*\$3) w l, \
     "./f2/profile0.dat" u 1:(-1*\$3) w l, \
     "./f4/profile0.dat" u 1:(-1*\$3) w l, \
     "./f6/profile0.dat" u 1:(-1*\$3) w l, \
     "./f8/profile0.dat" u 1:(-1*\$3) w l, \
     "./fx/profile0.dat" u 1:(-1*\$3) w l, \
     "./fx2/profile0.dat" u 1:(-1*\$3) w l, \
     "./fx6/profile0.dat" u 1:(-1*\$3) w l, \
     "./fxx/profile0.dat" u 1:(-1*\$3) w l
EOF

  done
 done
done

