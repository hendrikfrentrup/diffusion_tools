#!/bin/bash
#
# Plottet Simulationsergebnisse aus .run, .rav und .res-Dateien mit gnuplot
#
# Bug: Bei ChemPot wird immer die Ungenauigkeit der letzten Komponente
#      angezeigt
#

if [ -z $1 ]; then
  echo "ms2.plt  Plots ms2 simulations results with gnuplot."
  echo "Usage: ms2.plt <NameTag> <# of column (2-9)> [upper limit] [lower limit]"
  echo "  # of column:  2 pressure"
  echo "                3 density"
  echo "                4 temperature"
  echo "                5 potential energy"
  echo "                6 enthalpy"
  echo "              7-9 chemical potential of first,"
  echo "                    second or third component"
  exit 1
fi

if [ ! -r "${1}_1.run" ]; then
  echo "cannot read file ${1}_1.run"
  exit 1
fi

case "$2" in
 "2" ) ylabel="reduced pressure"
       faktor=0.5
       label="Pressure"
       ;;

 "3" ) ylabel="reduced density"
       faktor=0.05
       label="Density"
       ;;

 "4" ) ylabel="reduced temperature"
       faktor=0.002
       label="Temperature"
       ;;

 "5" ) ylabel="reduced potential energy"
       faktor=-0.05
       label="Potential energy"
       ;;

 "6" ) ylabel="reduced enthalpy"
       faktor=-0.05
       label="Enthalpy"
       ;;

 [7-9] ) ylabel="chemical potential"
       faktor=-0.15
       label="Chemical potential"
       ;;

   * ) echo "column identifier out of range (should be [2-7])"
       exit 1
       ;;
esac

if [ `grep -m 1 "NR" ${1}_1.rav | awk '{print $2}'` = "DISP" ]; then
  rc=$((${2}+1))
else
  rc=$2
fi
mw=`tail -n 1 ${1}_1.rav | awk '{print $'${rc}'}'`
ug=$(echo "scale=2; $mw*(1-($faktor))" | bc)
og=$(echo "scale=2; $mw*(1+($faktor))" | bc)

if [ -n "$3" ]; then
  ug="$3"
fi
if [ -n "$4" ]; then
  og="$4"
fi

yrange='['${ug}':'${og}']'

if [ -r $1_1.res ]; then
  var=`grep "^$label" $1_1.res | tail -n 1 | awk '{print $NF}'`
  varplus=$(echo "scale=4; $mw+$var/2" | bc)
  varminus=$(echo "scale=4; $mw-$var/2" | bc)
  gnuplot -persist << EOF1
set data s l
set xlabel "step"
set ylabel "$ylabel"
set yrange $yrange
set title "ms2 run $1"
plot "$1_1.run" using 1:$2 title "current value", \
  "$1_1.rav" using 1:$rc title "average", \
  $varplus title "upper uncertainty", \
  $varminus title "lower uncertainty"
EOF1

else
  gnuplot -persist << EOF2
set data s l
set xlabel "step"
set ylabel "$ylabel"
set yrange $yrange
set title "ms2 run $1"
plot "$1_1.run" using 1:$2 title "current value", \
  "$1_1.rav" using 1:$rc title "average"
EOF2

fi
