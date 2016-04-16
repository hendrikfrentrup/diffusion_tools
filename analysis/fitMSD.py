#!/usr/bin/env python
#==============================================
#
#    'Fitting collective MSD to linear f'
#                H. Frentrup
#                2012-06-19
#
#==============================================

from pylab import *
import scipy.optimize as opt

# Fit the first set
fitfunc = lambda p, x: p[0] + p[1]*x # Target function
errfunc = lambda p, x, y: fitfunc(p, x) - y # Distance to the target function

p0 = [0, 0.03] # Initial guess for the parameters
p1, success = opt.leastsq(errfunc, p0[:], args=(time, collMSD[:,0]+collMSD[:,1]+collMSD[:,2]))
