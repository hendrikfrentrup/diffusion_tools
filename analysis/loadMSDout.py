#!/usr/bin/env python
#==============================================
#
#   'plot mean square displacement from dat'
#                H. Frentrup
#                2013-07-23
#
#==============================================

import numpy as np
import pylab as pl

myDir='/home/hf210/molsim/lammps_run/teth_pim1/'

def loadMSDout(filename):
    t=[]
    msdx=[]
    msdy=[]
    msdz=[]
    inFile = open(filename, "r")
    for line in inFile:
        out=line.split()
        t.append(float(out[0]))
        msdx.append(float(out[1]))
        msdy.append(float(out[2]))
        msdz.append(float(out[3]))                
    inFile.close()
    t=np.array(t)
    msdx=np.array(msdx)
    msdy=np.array(msdy)
    msdz=np.array(msdz)
    return (t, msdx, msdy, msdz)
    
(t_He, msdx_He, msdy_He, msdz_He) = loadMSDout(myDir+'helium/out_unwr2msd.dat')
(t_Me, msdx_Me, msdy_Me, msdz_Me) = loadMSDout(myDir+'methane/long_run2/out_unwr2msd.dat')
(t_CO2, msdx_CO2, msdy_CO2, msdz_CO2) = loadMSDout(myDir+'co2/out_unwr2msd.dat')

msd_He=(msdx_He+msdy_He+msdz_He)
msd_Me=(msdx_Me+msdy_Me+msdz_Me)
msd_CO2=(msdx_CO2+msdy_CO2+msdz_CO2)

comp='He'
pl.figure(comp)
pl.plot(20*t_He,msdx_He, label=comp+' x', color='#FF0000')
pl.plot(20*t_He,msdy_He, label=comp+' y', color='#009900')
pl.plot(20*t_He,msdz_He, label=comp+' z', color='#0000FF')
pl.xlabel(r'Time $t$ / fs')
pl.ylabel(r'Mean square displacement / $\AA^{2}$')
pl.legend(loc='upper left')


comp='CH4'
pl.figure(comp)
pl.plot(20*t_Me,msdx_Me, label=comp+' x', color='#FF0000')
pl.plot(20*t_Me,msdy_Me, label=comp+' y', color='#009900')
pl.plot(20*t_Me,msdz_Me, label=comp+' z', color='#0000FF')
pl.xlabel(r'Time $t$ / fs')
pl.ylabel(r'Mean square displacement / $\AA^{2}$')
pl.legend(loc='upper left')


comp='CO2'
pl.figure(comp)
pl.plot(20*t_CO2,msdx_CO2, label=comp+' x', color='#FF0000')
pl.plot(20*t_CO2,msdy_CO2, label=comp+' y', color='#009900')
pl.plot(20*t_CO2,msdz_CO2, label=comp+' z', color='#0000FF')
pl.xlabel(r'Time $t$ / fs')
pl.ylabel(r'Mean square displacement / $\AA^{2}$')
pl.legend(loc='upper left')



from scipy import polyval,polyfit
a_He, b_He = polyfit(20*t_He[70*len(t_He)/100:90*len(t_He)/100],msd_He[70*len(t_He)/100:90*len(t_He)/100],1)
a_Me, b_Me = polyfit(20*t_Me[70*len(t_Me)/100:90*len(t_Me)/100],msd_Me[70*len(t_Me)/100:90*len(t_Me)/100],1)


#q_He, r_He = polyfit(np.log10(20*t_He[70*len(t_He)/100:90*len(t_He)/100]),np.log10(msd_He[70*len(t_He)/100:90*len(t_He)/100],1))
#q_Me, r_Me = polyfit(np.log10(20*t_Me[70*len(t_Me)/100:90*len(t_Me)/100]),np.log10(msd_Me[70*len(t_Me)/100:90*len(t_Me)/100],1))

q_He, r_He = polyfit(np.log10(20*t_He)[70*len(t_He)/100:90*len(t_He)/100],np.log10(msd_He)[70*len(t_He)/100:90*len(t_He)/100],1)
q_Me, r_Me = polyfit(np.log10(20*t_Me)[70*len(t_Me)/100:90*len(t_Me)/100],np.log10(msd_Me)[70*len(t_Me)/100:90*len(t_Me)/100],1)



# Aggregate
pl.figure('MSD He/CH4/CO2')
pl.plot(20*t_He,msd_He, label='He', color='#0000FF')
pl.plot(20*t_He,polyval((a_He,b_He),20*t_He), ':', label='He', color='#0000FF')
pl.plot(20*t_Me,msd_Me, label='CH4', color='#CC0000')
pl.plot(20*t_Me,polyval((a_Me,b_Me),20*t_Me), ':', label='CH4', color='#CC0000')
#pl.plot(20*t_CO2,msd_CO2, label='CO2', color='#000000')
pl.xlabel(r'Time $t$ / fs')
pl.ylabel(r'Mean square displacement / $\AA^{2}$')
pl.legend(loc='upper left')


pl.figure('log(MSD) He/CH4/CO2')
pl.plot(np.log10(20*t_He), np.log10(msd_He), label='He', color='#0000FF')
pl.plot(np.log10(20*t_He),polyval((q_He,r_He),np.log10(20*t_He)), ':', label='He', color='#0000FF')
pl.plot(np.log10(20*t_Me), np.log10(msd_Me), label='CH4', color='#CC0000')
pl.plot(np.log10(20*t_Me),polyval((q_Me,r_Me),np.log10(20*t_Me)), ':', label='CH4', color='#CC0000')
#pl.plot(np.log10(20*t_CO2), np.log10(msd_CO2), label='CO2', color='#000000')
pl.xlabel(r'log$_{10}$(Time $t$)')
pl.ylabel(r'log$_{10}$(MSD)')
pl.show()

print "He  D: {0:6.5f} (reached exponent {1:3.2f})".format(a_He,q_He)
print "CH4 D: {0:6.5f} (reached exponent {1:3.2f})".format(a_Me,q_Me)

