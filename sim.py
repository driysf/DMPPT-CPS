#! /usr/bin/env python
from pymodelica import compile_fmu
from pyfmi import load_fmu
import matplotlib.pyplot as p
import numpy as np
import sys

#*********** LAUNCH THE SIMULATION  ********************#

# Compilation and loading of the models
fmu = compile_fmu('Dmppt', ['Dmppt.mo' ,'plant.mo','PV_panel.mo','Duty_controller.mo',  'PV_cell.mo', 'squarewave.mo', 'Closed_loop.mo', 'Duty_controllerDDD.mo','Config_model.mo','Config_irradiance.mo','State_controller.mo'], compiler_log_level='info')
model = load_fmu(fmu)
print "FMU done" 

# Set the options
opts = model.simulate_options()
opts['solver'] = 'CVode' 
opts['CVode_options']['discr'] = 'Adams'
opts['CVode_options']['maxh'] = 1.0e-7  # Max integrator step size
opts['filter'] = ['time', 'P_out','I_out', 'V_out', ['closed[1].plant.panel.P'], ['closed[1].plant.panel.V'], ['closed[1].plant.panel.I'], 
['closed[2].plant.panel.P'], ['closed[2].plant.panel.V'], ['closed[2].plant.panel.I'], ['closed[1].plant.mode'], ['closed[2].plant.mode'], 
['closed[1].plant.dt'], ['closed[2].plant.dt'], ['closed[1].plant.panel.cells[1].G']]   # Save only these variables


print " Values Set correctly ! "

print "Begin simulation" 

# Launch the Simulation
res = model.simulate(start_time =0, final_time=0.5, options=opts)

print "End Simulation, Saving values ..."

# Save the results ( Plotted after using the script plot.py)
np.savetxt('time.txt',res['time'])
np.savetxt('power_out.txt',res['P_out'])
np.savetxt('current_out.txt',res['I_out'])
np.savetxt('voltage_out.txt',res['V_out'])


np.savetxt('power_panel1.txt',res['closed[1].plant.panel.P'])
np.savetxt('voltage_panel1.txt',res['closed[1].plant.panel.V'])
np.savetxt('current_panel1.txt',res['closed[1].plant.panel.P'])
np.savetxt('dtc1.txt',res['closed[1].plant.dt'])
np.savetxt('stateMode_pan1.txt',res['closed[1].plant.mode'])

np.savetxt('power_panel2.txt',res['closed[2].plant.panel.P'])
np.savetxt('voltage_panel2.txt',res['closed[2].plant.panel.V'])
np.savetxt('current_panel2.txt',res['closed[2].plant.panel.I'])
np.savetxt('dtc2.txt',res['closed[2].plant.dt'])
np.savetxt('stateMode_pan2.txt',res['closed[2].plant.mode'])

exit();
print "DONE !" 
