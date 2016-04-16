#!/usr/bin/env python
#===============================================
#
#'Convert EMD data to the transport coefficients'
#                H. Frentrup
#                2012-08-03
#
#===============================================

import numpy as np
import pylab as pl

mu=np.array([-13.25, -13.5 , -13.75, -14.  , -14.25, -14.5 , -14.75, -15.  ,
       -15.25, -15.5 , -15.75, -16.  , -16.25, -16.5 , -16.75, -17.  ,
       -17.25, -17.5 , -17.75, -18.  ])
rho=np.array([ 360.68578554,  349.73316708,  338.7680798 ,  327.40399002,
        312.46633416,  296.99002494,  280.2319202 ,  263.26932668,
        242.20698254,  216.2394015 ,  191.37905237,  162.6234414 ,
        133.01745636,  106.86783042,   84.88778055,   67.9201995 ,
         54.03740648,   43.44887781,   36.12718204,   28.81047382])


fig_width_pt = 246.0  # Get this from LaTeX using \showthe\columnwidth
inches_per_pt = 1.0/72.27               # Convert pt to inches
golden_mean = (sqrt(5)-1.0)/2.0         # Aesthetic ratio
fig_width = fig_width_pt*inches_per_pt  # width in inches
fig_height =fig_width*golden_mean       # height in inches
fig_size = [fig_width,fig_height]

params = {'font.size' : 10,
          'axes.labelsize' : 10,
          'font.size' : 10,
          'text.fontsize' : 10,
          'legend.fontsize': 10,
          'xtick.labelsize' : 8,
          'ytick.labelsize' : 8,
          'text.usetex': True,
          'figure.figsize': fig_size}
pylab.rcParams.update(params) 

# Plot data
pylab.figure(1)
pylab.clf()
pylab.axes([0.125,0.2,0.95-0.125,0.95-0.2])
pylab.plot(mu,rho,'g:',label=r'$\rho$')
pylab.plot(mu,rho*1.1,'-b',label=r'$1.1\rho$')
pylab.xlabel(r'Chemical Potential $\mu$ (red.)')
pylab.ylabel(r'Density $\rho$ ($\sigma^{-3}$)')
pylab.legend()
pylab.savefig('fig1.eps')    



