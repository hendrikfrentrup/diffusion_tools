#!/usr/bin/env python
#==============================================
#
#'Calculating the collective MSD from com file'
#                H. Frentrup
#                2012-06-19
#
#==============================================

from __future__ import with_statement
import math
import numpy as np
import matplotlib.pyplot as plt

nRun=20000
nFreq=10
corrL=10000
dt=0.002

"""
com.nvt will look like this (LAMMPS output)
# Fix print output for fix com
10020 0.4224899133 0.539011437 -0.01172981053
10040 0.420949263 0.5424329548 -0.01473384116
10060 0.4189370691 0.5465813695 -0.01619470341
10080 0.4166562854 0.5507838643 -0.01685123804
10100 0.4147486937 0.5548665819 -0.01703052617
10120 0.4137940116 0.5592093971 -0.01615531945
10140 0.4131846524 0.5633856767 -0.01409617734
10160 0.4123955685 0.5670507411 -0.01236037612
10180 0.4117813079 0.5708598453 -0.01052114194
...
20009820 -41.21724835 27.23531438 -0.02351593422
20009840 -41.22072903 27.23482715 -0.02348020322
20009860 -41.22437861 27.23445808 -0.02317734181
20009880 -41.22787955 27.23386503 -0.02326480869
20009900 -41.23154733 27.23240388 -0.0227242728
20009920 -41.2354601 27.23031371 -0.02179734569
20009940 -41.23948929 27.22880107 -0.0220121452
20009960 -41.24328006 27.22747286 -0.02352548948
20009980 -41.24614489 27.22576312 -0.02609081527
20010000 -41.24861195 27.22398558 -0.02912213363

"""

inFile = open("com.nvt", "r")
rubbish = inFile.readline()
counter=0

# initialize time and counter for # of samples
time = np.zeros((int(corrL), 1))
sampleCounter = np.zeros((int(corrL), 1))

# initialize collective MSD vector
collMSD = np.zeros((int(corrL), 3))

for line in inFile:
    # read current profile
    data = np.array(line.strip('()\n ').split())
    t=np.array(data[0].astype(float))*dt
    r=np.array(data[1:4].astype(float))

    if (counter==0 or counter>=corrL):
        counter=0   # set counter to zero     
        t0=t        # take first sample
        r0=r
        # set displacement to zero
        disp=np.array([0.0,0.0,0.0])
        sampleCounter[counter]+=1
    else: # take a normal sample
        disp+=r-r0
        time[counter]=t-t0
        collMSD[counter,:]+=disp*disp
        r0=r
        sampleCounter[counter]+=1
    if counter == 3500:
        print disp, collMSD[counter,:] 
    counter+=1

for i in range(sampleCounter.shape[0]):
    collMSD[i,:]=collMSD[i,:]/sampleCounter[i]

plt.plot(time[:],collMSD[:,0]+collMSD[:,1]+collMSD[:,2])
plt.show()


