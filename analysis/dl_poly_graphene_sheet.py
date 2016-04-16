#!/usr/bin/env python
#==============================================
#
#       'Graphene sheet for DL_POLY'
#                H. Frentrup
#                2012-06-06
#
#==============================================
import math
# graphene and CNT
d  = 1.42  # C-C distance
a1 = math.sqrt(3.0)*d
a2 = 3.0*d

nax = int(50.0/a1)+1
nay = int(50.0/a2)+1

i_atom=0
z=0.0
print "400\n"
# == graphene sheets ==
for ia1 in range(10):
    for ia2 in range(10):
        i_atom+=1
        x = ia1*a1
        y = ia2*a2
        print 'C             {0}         6'.format(i_atom)
        print '{0:20.12f}{1:20.12f}{2:20.12f}'.format(x, y, z)   

        i_atom+=1
        y = ia2*a2 + 2.0*d
        print 'C             {0}         6'.format(i_atom)
        print '{0:20.12f}{1:20.12f}{2:20.12f}'.format(x, y, z) 
        
        i_atom+=1
        x = (ia1+0.5)*a1
        y = ia2*a2 + 0.5*d
        print 'C             {0}         6'.format(i_atom)
        print '{0:20.12f}{1:20.12f}{2:20.12f}'.format(x, y, z)   

        i_atom+=1
        y = ia2*a2 + 1.5*d
        print 'C             {0}         6'.format(i_atom)
        print '{0:20.12f}{1:20.12f}{2:20.12f}'.format(x, y, z)
