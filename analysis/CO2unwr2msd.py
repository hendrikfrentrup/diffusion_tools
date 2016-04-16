#!/usr/bin/env python
#==============================================
#
#   'calculate mean square displacement from xyz'
#                H. Frentrup
#                2012-08-03
#
#==============================================

import numpy as np
import pylab as pl

myDir='/home/hf210/molsim/lammps_run/teth_pim1/co2/'
filename='unwrap_c-T293.dump'




nts_run = 56114420 # nr of production run time steps
nsample = 20 # nr of timesteps between frames in trajectory file (sample rate)
tmax = nts_run/nsample # maximum nr of samples from run

# for test purposes
tmax=400000 # break after tmax samples

it0=20000 # nr of samples after which a new time origin t0 is taken
it0max=100 # maximum nr of time origins t0 

corrtmax=it0*it0max # maximum nr of correlated samples




# read first lines

inFile = open(myDir+filename, "r")
line=inFile.next()
t=int(inFile.next()) # time counter
inFile.next()
N=int(inFile.next()) # number of particles
inFile.next()
xBox=inFile.next()
yBox=inFile.next()
zBox=inFile.next()
inFile.next()




# allocate arrays

r = np.zeros((N,3))
disp = np.zeros((N,3))
x = np.zeros(N)
y = np.zeros(N)
z = np.zeros(N)
x0 = np.zeros((it0max,N))
y0 = np.zeros((it0max,N))
z0 = np.zeros((it0max,N))
time0 = np.zeros(it0max)

ntime = np.zeros(corrtmax)

msd = np.zeros((corrtmax,3))
#vacf = np.zeros((corrtmax,3))

nt0=0 # nr of t0 taken


n1=3745 #346+311

# read first frame
for i in xrange(N):
    line=inFile.next().split()
    r[(int(line[0])-n1)/3-1]=np.array(line[7:10],dtype='float64') 

# save first frame to r0
nt0+=1
x0[0] = r[:,0].copy()
y0[0] = r[:,1].copy()
z0[0] = r[:,2].copy()
time0[0] = t
ntime[0] = 1

#import pdb
# read rest of file

while line:
    try:
        line=inFile.next()
        t=int(inFile.next())
        
#        if t==tmax:
#            print "reached tmax"
#            break
            
        # read header lines
        inFile.next()
        N=int(inFile.next())
        inFile.next()
        xBox=inFile.next()
        yBox=inFile.next()    
        zBox=inFile.next()
        inFile.next()
        # read configuration
        for i in xrange(N):
            line=inFile.next().split()
            r[(int(line[0])-n1)/3]=np.array(line[7:10],dtype='float64')
        
        x = r[:,0].copy()
        y = r[:,1].copy()
        z = r[:,2].copy()
        
        # take a new time origin t0 every it0 samples
        if (t/nsample%it0)==0:
            #pdb.set_trace()
            print 'new time origing at timestep: {0:3d}'.format(t)
            #pl.plot(msd[:,0],color=str(1-t/10000.))
            #pl.show()
            nt0+=1
            tt0=(nt0-1)%it0max
            x0[tt0] = r[:,0].copy()
            y0[tt0] = r[:,1].copy()
            z0[tt0] = r[:,2].copy()
            time0[tt0] = t            


        for i in xrange(min(nt0,it0max)):
            delt=t-time0[i]
            ntime[int(delt/nsample)]+=1
            disp[:,0]=(x-x0[i])
            disp[:,1]=(y-y0[i])
            disp[:,2]=(z-z0[i])
            msd[int(delt/nsample),0]+=sum(disp[:,0]**2)
            msd[int(delt/nsample),1]+=sum(disp[:,1]**2)
            msd[int(delt/nsample),2]+=sum(disp[:,2]**2)
            
#            vacf[int(delt/nsample),0]+=sum(x*x0[i])
#            vacf[int(delt/nsample),1]+=sum(y*y0[i])
#            vacf[int(delt/nsample),2]+=sum(z*z0[i])
    except StopIteration:
        print 'reached end' #' ('+line+')'
        
        line=[]

inFile.close()

#msd_out=np.array([ msd[0]/ntime/N, msd[:,1]/ntime/N, msd[:,2]/ntime/N,])

outFile = open(myDir+'out_unwr2msd.dat', "w")
for i, rr in enumerate(msd):
    outFile.write('{0:7d}   {1:7.4f}   {2:7.4f}   {3:7.4f}\n'.format(i, rr[0]/N/ntime[i], \
                                                                        rr[1]/N/ntime[i], \
                                                                        rr[2]/N/ntime[i]))
outFile.close()
