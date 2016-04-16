#!/usr/bin/env python
#==============================================
#
#   'Converting a config.inp file for lammps'
#                H. Frentrup
#                2012-05-25
#
#==============================================
from __future__ import with_statement
import math
from numpy import *

inFile = open("config.inp", "r")
outFile = open("data.config", "w")

rubbish = inFile.readline()
lBox = inFile.readline().strip('()\n ').split()
rubbish = inFile.readline()
rubbish = inFile.readline()
rubbish = inFile.readline()

print "\n\n"
print -1.0*float(lBox[0])/2.0, float(lBox[0])/2.0, 'xlo xhi'
print -1.0*float(lBox[1])/2.0, float(lBox[1])/2.0, 'ylo yhi'
print -1.0*float(lBox[2])/2.0, float(lBox[2])/2.0, 'zlo zhi'

coord = array([0.0, 0.0, 0.0])
index=0
n_fluid=0
n_wall=0
print "\nAtoms\n"
for line in inFile:
   if line.strip('()\n ').split()[0] == 'Lattice':
      break
   index=index+1
   name, coord[0], coord[1], coord[2]  = line.strip('()\n ').split() #inFile.readlinea
   if name=='N1':
      n_fluid=n_fluid+1
      atom_type=1
   elif name=='W1':
      atom_type=2
      print index, index, "3", coord[0], coord[1], coord[2]
      index=index+1
      n_wall=n_wall+1
   print index, index, atom_type, coord[0], coord[1], coord[2]

print "\nBonds\n"
index=1
for i in range(n_wall):
   print i+1, "1", n_fluid+index, n_fluid+index+1
   index=index+2

print "# lammps input\n", n_fluid+2*n_wall," atoms\n", n_wall, " bonds\n"
#,"0 angles\n0 dihedrals\n0 impropers"
print "3 atom types\n1 bond types"
print "Masses\n1 1.0\n2 1.0\n3 1.0\n"
#with open("data.config", "w") as outFile:
