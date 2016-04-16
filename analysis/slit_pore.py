#!/usr/bin/env python
#==========================================
#
#   'Creating the slit pore geometry...'
#             H. Frentrup
#             2012-04-25
#
#==========================================
from __future__ import with_statement
from numpy import *
import math
#import scipy

#start random number generator
random.seed()

# input parameters
rhoWall=0.85
rhoFluid=0.75
H   = 4.0
Lx  = 50
ncx = 10
ncy = 8
ncz = 4

# model parameters
sigma=3.758
epsilon=148.6

# Unit Cell coordinates
unitCell =[ [0.25, 0.25, 0.25], \
            [0.75, 0.75, 0.25], \
            [0.75, 0.25, 0.75], \
            [0.25, 0.75, 0.75] ]

nPartWall = 4*ncx*ncy*ncz

# allocate( rPartWall(3,nPartWall) )
rWall = [ [ 0. for i in range(3) ] for j in range(nPartWall) ]

# construction of the slit pore: fcc lattice structure
m=0
for i in range(ncx):
   for j in range(ncy):
      for k in range(ncz):
         for l in range(len(unitCell)):
            rWall[m][0]=( unitCell[l][0]+float(i))/ncx
            rWall[m][1]=( unitCell[l][1]+float(j))/ncx
            rWall[m][2]=( unitCell[l][2]+float(k))/ncx
            m=m+1

# get dimension of this lattice
lBox = array([1.0, float(ncy)/ncx, float(ncz)/ncx])

lBox[0] = float(nPartWall)/rhoWall/lBox[1]/lBox[2]
lBox[0] = lBox[0]**(1.0/3.0)

lBox[1] = lBox[0]*lBox[1]
lBox[2] = lBox[0]*lBox[2]

volSolid = product(array(lBox))

rPartWall = array(rWall)

# center particle in the box
for i in range(nPartWall):
   rPartWall[i][0] = rPartWall[i][0]*lBox[0] - 0.5*lBox[0]
   rPartWall[i][1] = rPartWall[i][1]*lBox[0] - 0.5*lBox[1]
   rPartWall[i][2] = rPartWall[i][2]*lBox[0] - 0.5*lBox[2]

# separate the layer
for i in range(nPartWall):
   if (rPartWall[i][2] < 0.0):
      rPartWall[i][2] = rPartWall[i][2] - H*0.5
   else:
      rPartWall[i][2] = rPartWall[i][2] + H*0.5

lBox[2] = lBox[2] + H


nPartFluid = 30
# allocate( rPartFluid(3,nPartFluid) )
rFluid = [ [ 0. for i in range(3) ] for j in range(nPartFluid) ]
rPartFluid = array(rFluid)
for i in range(nPartFluid):
  rPartFluid[i][0]=lBox[0]*float(random.random()-0.5)
  rPartFluid[i][1]=lBox[1]*float(random.random()-0.5)
  rPartFluid[i][2]=(H-1)*(random.random()-0.5)

# output

print "LJ gas in a slit-pore"
print "         0         2"         # {}".format(nPartWall+nPartFluid)
print '{0:20.12f}{1:20.12f}{2:20.12f}'.format(sigma*lBox[0],0.,0.)
print '{0:20.12f}{1:20.12f}{2:20.12f}'.format(0.,sigma*lBox[1],0.)
print '{0:20.12f}{1:20.12f}{2:20.12f}'.format(0.,0.,sigma*lBox[2])
for i in range(nPartWall):
   print 'CH4_W         {0}'.format(i+1)
   print '{0:20.12f}{1:20.12f}{2:20.12f}'.format(sigma*rPartWall[i][0], sigma*rPartWall[i][1], sigma*rPartWall[i][2])
for i in range(nPartFluid):
   print 'CH4_F      {0}'.format(nPartWall+i+1)
   print '{0:20.12f}{1:20.12f}{2:20.12f}'.format(sigma*rPartFluid[i][0], sigma*rPartFluid[i][1], sigma*rPartFluid[i][2])

#outFile.close()
#outFile = open("./config.inp", "w")
#with open("./config.inp", "w") as outFile
#   for i in range(nPartWall):
#      outFile.write("N1",rPartWall[i][:])
#   outFile.closed
with open("config.xyz", "w") as outFile:
   outFile.write("{}\n".format(nPartFluid+nPartWall))
   for i in range(nPartWall):
      outFile.write("W1   {0: .8f}   {1: .8f}   {2: .8f}\n".format(rPartWall[i][0], rPartWall[i][1], rPartWall[i][2]))
   for i in range(nPartFluid):
      outFile.write("N1   {0: .8f}   {1: .8f}   {2: .8f}\n".format(rPartFluid[i][0], rPartFluid[i][1], rPartFluid[i][2]))

with open("FIELD", "w") as outFile:
   outFile.write("LJ gas in a slit-pore\nUNITS    kJ\n\n")
   outFile.write("MOLECULES 2\n")

   outFile.write("Wall\n")
   outFile.write("NUMMOLS   1\n")
   outFile.write("ATOMS {}\n".format(nPartWall)) # number of atoms in the wall
   outFile.write("CH4_W      16.0400000  0.0         {0}    0\n".format(nPartWall))
   outFile.write("tethers {0}\n".format(nPartWall))
   for i in range(nPartWall):
      outFile.write("harm   {0: d}  1.5d2   0.0d0   0.0d0\n".format(i+1))
   outFile.write("FINISH\n")
   outFile.write("Methane\n")
   outFile.write("NUMMOLS {}\n".format(nPartFluid)) # number of atoms in the wall
   outFile.write("ATOMS   1\n")
   outFile.write("CH4_F      16.0400000  0.00000000\n")
   outFile.write("FINISH\n\n")

   outFile.write("EXTERN\n")
   outFile.write("slab\n")
   outFile.write("0.0 0.0 0.5 {0}\n\n".format(sigma*lBox[0]*0.8))

   outFile.write("VDW    3\n")
   outFile.write("CH4_F  CH4_F   lj   1.486  3.758\n")
   outFile.write("CH4_W  CH4_W   wca  1.486  3.758\n")
   outFile.write("CH4_F  CH4_W   wca  1.486  3.758\n")
   outFile.write("CLOSE\n")
