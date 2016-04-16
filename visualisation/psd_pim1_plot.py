#!/usr/bin/env python
#==============================================
#
#          'creating various plots'
#                H. Frentrup
#                2012-08-22
#
#==============================================
from matplotlib import rcParams
#rcParams['font.family'] = 'sans-serif'
#rcParams['font.sans-serif'] = ['Tahoma']
rcParams['axes.labelsize'] = 16
rcParams['font.size'] = 16
rcParams['legend.fontsize'] = 12
rcParams['xtick.labelsize'] = 14
rcParams['ytick.labelsize'] = 14
import pylab

poreWidth=[]
psd_1=[]
psd_2=[]
psd_3=[]

# open PSD file
filename='psd_pim1.dat'
inFile = open(filename, "r")  #   with open(filename, "r") as inFile
#skip the first line of the file
line=inFile.next()
while line: # do this until the end of the file
    try:
        line=inFile.next().split()
        poreWidth.append(line[0])
        psd_1.append(line[1])
        psd_2.append(line[2])
        psd_3.append(line[3])
    except StopIteration:
        line=[]
        break
    except IndexError:
        line=[]
        break
inFile.close()

## figure paramters
#fig_width_pt = 400.0  # Get this from LaTeX using \showthe\columnwidth
#inches_per_pt = 1.0/72.27              # Convert pt to inch
#golden_mean = (math.sqrt(5)-1.0)/2.0   # Aesthetic ratio
#fig_width = fig_width_pt*inches_per_pt # width in inches
#fig_height = fig_width*golden_mean     # height in inches
#fig_size =  [fig_width,fig_height]
#params = {'axes.labelsize': 16,
#          'text.fontsize': 16,
#          'legend.fontsize': 12,
#          'xtick.labelsize': 14,
#          'ytick.labelsize': 14,
#          'figure.figsize': fig_size}
##          'backend': 'png',
##          'text.usetex': True,
#pylab.rcParams.update(params)




#pylab.plot(poreWidth, psd_3, label='PIM1', linewidth=4)   
pylab.plot(poreWidth, psd_1, label='PIM1', linewidth=3)
pylab.plot(poreWidth, psd_2, label='1nm pore', linewidth=3)
pylab.legend(loc='best')
pylab.xlabel(r'Pore size / $\AA$')
pylab.ylabel(r'Frequency (normalized)')
pylab.show()
#        dataBlocks = np.vstack( (dataBlocks,data) )
#        line=[]
