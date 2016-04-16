import os
import blockAverages as bl
import pylab as pl
import numpy as np

#import pdb

fig='helium'
c='#000099'
thisDir='/home/hf210/molsim/lammps_run/teth_pim1/nemd_bulkforce/'+fig+'/'
filename='dens.grad-T293-f0.011789519999999999514'
thisDensGrad=thisDir+filename
rx=bl.readXCoords(thisDensGrad)
ry=bl.averageBlocks(bl.readYData(thisDensGrad))
#print "density left: {0:7.6e}, right: {1:7.6e}".format(ry[0][40:100].mean(),ry[0][290:360].mean())
pl.figure(fig)
pl.subplot(311)
pl.plot(rx,ry[0],color=c,lw=1)
cur_axis=pl.axis()
#pl.axis([rx[0],rx[-1],cur_axis[2],cur_axis[3]])
pl.xlabel(r'$x$ / A')
pl.ylabel(r'$\rho$ / A$^{-3}$')
filename='vel.grad-T293-f0.011789519999999999514'
thisVelGrad=thisDir+filename
vx=bl.readXCoords(thisVelGrad)
vy=bl.averageBlocks(bl.readYData(thisVelGrad))
#print "velocity left: {0:7.6e}, right: {1:7.6e}".format(vy[0][40:100].mean(),vy[0][290:360].mean())
pl.subplot(312)
pl.plot(vx,vy[0],color=c,lw=1)
cur_axis=pl.axis()
#pl.axis([vx[0],vx[-1],cur_axis[2],cur_axis[3]])
pl.xlabel(r'$x$ / A')
pl.ylabel(r'$v_{x}$ / A fs$^{-1}$')
pl.subplot(313)
pl.plot(vx,ry[0]*vy[0],color=c,lw=1)
cur_axis=pl.axis()
#pl.axis([vx[0],vx[-1],cur_axis[2],cur_axis[3]])
pl.xlabel(r'$x$ / A')
pl.ylabel(r'Flux $j_{x}$ / A$^{-2}$ fs$^{-1}$')

fy=ry[0]*vy[0]
print "flux: {0:7.6e}".format( fy.mean() )
print "density: {0:7.6e}".format( ry[0].mean() )
