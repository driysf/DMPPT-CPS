

// In this model we are modeling the dynamic of the Irradiation in function of the Simulation time
model irradiationConf

	import SI = Modelica.SIunits;
	configModel conf;

    	// Nominal Irradiance ( need to be specified)
	constant SI.Irradiance nominalIrradiance = 1000;

	// Irradiances of the panels	
	SI.Irradiance panelIrradiance[conf.PANELS_NUMBER,conf.CELLS_NUMBER];


equation

	// After the tests the Irradiance will be done via a Loop for each panel


	/* Irradiance of the panels. BEGIN*/
	
	// First Panel
	 panelIrradiance[1,1] = nominalIrradiance * 0.75; 
	 panelIrradiance[1,2] = if time > 0.5 then nominalIrradiance * 0.5 else nominalIrradiance * 0.75;
	 panelIrradiance[1,3] = if time > 0.5 then nominalIrradiance  else nominalIrradiance * 0.55;
	 panelIrradiance[1,4] = if time > 0.5 then nominalIrradiance * 0.75 else nominalIrradiance * 0.85;
	 panelIrradiance[1,5] = nominalIrradiance * 0.25; 
	 panelIrradiance[1,6] = nominalIrradiance * 0.5;
	 panelIrradiance[1,7] = nominalIrradiance * 0.75;
	 panelIrradiance[1,8] = nominalIrradiance * 0.5;
 	 panelIrradiance[1,9] = if time > 0.5 then nominalIrradiance * 0.25 else nominalIrradiance * 0.5;
	 panelIrradiance[1,10] = if time > 0.5 then nominalIrradiance  else nominalIrradiance * 0.5;
	 panelIrradiance[1,11] = if time > 0.5 then nominalIrradiance * 0.75 else nominalIrradiance * 0.5;
	 panelIrradiance[1,12] = nominalIrradiance * 0.75;



	 // Second Panel
	 panelIrradiance[2,1]  = nominalIrradiance * 0.25; 
	 panelIrradiance[2,2]  = nominalIrradiance * 0.25;
	 panelIrradiance[2,3]  = nominalIrradiance * 0.25;
	 panelIrradiance[2,4]  = nominalIrradiance * 0.25;
	 panelIrradiance[2,5]  = nominalIrradiance * 0.25; 
	 panelIrradiance[2,6]  = nominalIrradiance * 0.25;
	 panelIrradiance[2,7]  = nominalIrradiance * 0.25;
	 panelIrradiance[2,8]  = nominalIrradiance * 0.25;
	 panelIrradiance[2,9]  = nominalIrradiance * 0.25; 
	 panelIrradiance[2,10] = nominalIrradiance * 0.25;
	 panelIrradiance[2,11] = nominalIrradiance * 0.25;
	 panelIrradiance[2,12] = nominalIrradiance * 0.25;


	/* Irradiance of the panels. END*/ 

end irradiationConf;
