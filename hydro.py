#!/usr/bin/env python
# hydrostatics results analysis with NumPy & matplotlib
# D. DJokic, Mar-2013
# calculates only drafts - can be extended further


import numpy as np 
import matplotlib.pyplot as plt 

laun_draft=float(input("Input Draft to check Displacement [m]: "))
filename=raw_input("Enter CSV filename: ")

# reading data from CSV file - edit to suit data range

hyd=np.loadtxt(filename, dtype=float, comments="#", delimiter=',', converters=None, skiprows=2, usecols=(0,1,3), unpack=False, ndmin=0)
records=len(hyd)

T=[]  		#draft moulded [m]
Tk=[] 		#draft to bottom of the keel [m]
Displ=[]	#displacement [t]	

for i in range (0, records):
	T.append(hyd[i,0])
	Tk.append(hyd[i,1])
	Displ.append(hyd[i,2])
print(Displ)

# fitting to 2nd degree curve
p=np.polyfit(T, Displ, 2)
Calc_Dis=p[0]*laun_draft**2+p[1]*laun_draft+p[2]
print("\n")
print(Calc_Dis)

# display grid
fig=plt.figure()
ax=fig.add_subplot(111)

plt.plot(T, Displ)
plt.xlabel("Draft, moulded [m]")
plt.ylabel("Displacement [t]")
ax.grid()
plt.show()

c_disp=[]
drft=[]
for draft in range(0,20):
	pcal=p[0]*draft**2+p[1]*draft+p[2]
	c_disp.append(pcal)
	drft.append(draft)
plt.plot(drft, c_disp)
plt.xlabel("Draft, moulden [m]")
plt.ylabel("Displacement-p [t]")
ax.grid()
plt.show()