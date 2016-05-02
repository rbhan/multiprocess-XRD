from __future__ import print_function
import numpy as np
from numpy import linalg as LA
import math
from pymatgen.io.xyz import XYZ
from pymatgen.core import structure
from pymatgen.core.sites import PeriodicSite
from pymatgen.core import Site
from pymatgen import Lattice, Structure, Molecule
from pymatgen.io.vasp import Poscar, sets
from string import digits
from pymatgen.analysis.diffraction.xrd import XRDCalculator

####################################################################
def read_structures():
	file=open('input','r')
	lines=file.readlines()
	file.close()

    	index=find_line('input','NUMBER OF STRUCTURES')
    	global n
	n = int(lines[index+1])

	index=find_line('input','LIST OF STRUCTURES')
	global structure_files
	structure_files = []
	for l in range(index+1,n+index+1):
		elements=lines[l].split()
		structure_files.append(elements[0])
	
	return(structure_files)

####################################################################
def find_line(file,searchExp):
	f=open(file,'r')
	index=0
	for line in f:
		if searchExp in line:
			break
		index += 1
        f.close()

	return(index)

####################################################################
# filename = 'TMDMOF.vasp'
read_structures()
for each in structure_files:
	print(each)
	filename = str(each + ".vasp")

	structure_pos = Poscar.from_file(filename)

	c = XRDCalculator()
	structure = structure_pos.structure
	XRD = c.get_xrd_data(structure, scaled = True, two_theta_range = (5,20))

	fil = filename.split(".", 1)
	f = open(str(fil[0] + ".xye"), 'w')
	print(*XRD, sep='\n', file=f)
