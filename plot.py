#! /usr/bin/env python
import matplotlib.pyplot as p
import numpy as np
import sys


time = np.loadtxt('time.txt')
power_out = np.loadtxt('power_out.txt')
current_out = np.loadtxt('current_out.txt')
voltage_out = np.loadtxt('voltage_out.txt')

power_panel1 = np.loadtxt('power_panel1.txt')
voltage_panel1 = np.loadtxt('voltage_panel1.txt')
current_panel1 = np.loadtxt('current_panel1.txt')
dtc1 = np.loadtxt('dtc1.txt')
mode_1 = np.loadtxt('stateMode_pan1.txt')


power_panel2 = np.loadtxt('power_panel2.txt')
voltage_panel2 = np.loadtxt('voltage_panel2.txt')
current_panel2 = np.loadtxt('current_panel2.txt')
dtc2 = np.loadtxt('dtc2.txt')
mode_2 = np.loadtxt('stateMode_pan2.txt')


rows = 5
cols = 3
fig = 1


#

p.subplot(rows,cols,fig)
p.plot(voltage_panel1, power_panel1)
p.ylabel('Ppv_1')
p.xlabel('Vpv_1')
p.grid()
p.title('Ppv_1 vs Vpv_1')
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, voltage_panel1)
p.ylabel('Vpv_1')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, current_panel1)
p.ylabel('Ipv_1')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(voltage_panel2, power_panel2)
p.ylabel('Ppv_2')
p.xlabel('Vpv_2')
p.grid()
p.title('Ppv_2 vs Vpv_2')
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, voltage_panel2)
p.ylabel('Vpv_2')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, current_panel2)
p.ylabel('Ipv_2')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, power_panel1)
p.ylabel('Ppv_1')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, power_panel2)
p.ylabel('Ppv_2')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, power_out)
p.ylabel('P_out')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, current_out)
p.ylabel('I_out')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, mode_1)
p.ylabel('Mode_1')
p.xlabel('time')
p.grid()
p.axis([0,1,0,5])
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time,mode_2)
p.ylabel('Mode_2')
p.xlabel('time')
p.grid()
p.axis([0,1,0,5])
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, voltage_out)
p.ylabel('V_out')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, dtc1)
p.ylabel('dtc1')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.subplot(rows,cols,fig)
p.plot(time, dtc2)
p.ylabel('dtc2')
p.xlabel('time')
p.grid()
fig = fig + 1

#
p.show()
exit();


print "DONE !" 

