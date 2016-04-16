#!/usr/bin/env python
#==============================================
#
#   'analyze dump files for stuck CO2 molecules'
#                H. Frentrup
#                2013-07-23
#
#==============================================

import numpy as np
import pylab as pl

myDir='/home/hf210/molsim/lammps_run/teth_pim1/'

n1=3745
def loadFrame(filename):
    r=[]

    inFile = open(filename, "r")
    for i in xrange(3):
        inFile.next()
    N=int(inFile.next().split()[0])

    for i in xrange(5):
        inFile.next()
    
    r = np.zeros((N,3))
    for i in xrange(N):
        line=inFile.next().split()
        r[(int(line[0])-n1)/3-1]=np.array(line[7:10],dtype='float64') 
               
    inFile.close()

    return r
    
first=loadFrame(myDir+'co2/first_frame.pos')
last=loadFrame(myDir+'co2/last_frame.pos') 

dist=last-first
dist_bar=np.zeros(len(dist))
for i in xrange(len(dist)):
    dist_bar[i]=np.sqrt(dist[i][0]**2+dist[i][1]**2+dist[i][2]**2)
    
ind = np.arange(len(dist_bar))
for i,e in enumerate(dist_bar):
    pl.bar(i, np.log10(e), width=0.75, bottom=0, \
    color=str(np.log10(e)/np.log10(dist_bar.max())) )
pl.show() 
