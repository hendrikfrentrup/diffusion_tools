#!/usr/bin/env python
#==============================================
#
#       'Graphene slit pore for lammps'
#                H. Frentrup
#                2012-06-06
#
#==============================================
import math
import random

random.seed()

# parameters
H = 3.0 # pore width
rep = [10,5] # number of unit cell replicas
# graphene honeycomb
d  = 1.42  # C-C distance
a1 = math.sqrt(3.0)*d
a2 = 3.0*d

i_atom=0
z=-0.5*H
print "{}\n".format(2*4*rep[0]*rep[1])
# == graphene sheet bottom ==
for ia1 in range(rep[0]):
    for ia2 in range(rep[1]):
        i_atom+=1
        x = ia1*a1
        y = ia2*a2
        print "{0:6d} 1   {1:4.5f} {2:4.5f} {3:4.5f}".format(i_atom, x, y, z)
        
        i_atom+=1
        y = ia2*a2 + 2.0*d
        print "{0:6d} 1   {1:4.5f} {2:4.5f} {3:4.5f}".format(i_atom, x, y, z)

        i_atom+=1
        x = (ia1+0.5)*a1
        y = ia2*a2 + 0.5*d
        print "{0:6d} 1   {1:4.5f} {2:4.5f} {3:4.5f}".format(i_atom, x, y, z)
 
        i_atom+=1
        y = ia2*a2 + 1.5*d
        print "{0:6d} 1   {1:4.5f} {2:4.5f} {3:4.5f}".format(i_atom, x, y, z)

z=0.5*H
x_offset=random.random()*0.5
y_offset=random.random()*0.5
# == graphene sheet top ==
for ia1 in range(rep[0]):
    for ia2 in range(rep[1]):
        i_atom+=1
        x = ia1*a1
        y = ia2*a2
        print "{0:6d} 1   {1:4.5f} {2:4.5f} {3:4.5f}".format(i_atom, x+x_offset, y+y_offset, z)

        i_atom+=1
        y = ia2*a2 + 2.0*d
        print "{0:6d} 1   {1:4.5f} {2:4.5f} {3:4.5f}".format(i_atom, x+x_offset, y+y_offset, z)

        i_atom+=1
        x = (ia1+0.5)*a1
        y = ia2*a2 + 0.5*d
        print "{0:6d} 1   {1:4.5f} {2:4.5f} {3:4.5f}".format(i_atom, x+x_offset, y+y_offset, z)
 
        i_atom+=1
        y = ia2*a2 + 1.5*d
        print "{0:6d} 1   {1:4.5f} {2:4.5f} {3:4.5f}".format(i_atom, x+x_offset, y+y_offset, z)

