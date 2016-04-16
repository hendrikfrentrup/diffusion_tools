#!/bin/bash
TMP_DIR=`pwd`
T=300
for fex in 0.4 0.5 0.7 0.8 1.0; do
 echo "# Permeation run - Helium-Methane mix through PIM1" > in.run-T$T-f$fex
 echo "# Input parameters" >> in.run-T$T-f$fex
 echo "variable         T equal $T     # target temperature" >> in.run-T$T-f$fex
 echo "variable         f_ex equal $fex*0.0785968 # external field strength" >> in.run-T$T-f$fex

 cat in.template_force >> in.run-T$T-f$fex

 lammps -screen none -log log.run-T$T-f$fex -in in.run-T$T-f$fex &
done
