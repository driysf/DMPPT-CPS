model PVPanel

  import SI = Modelica.SIunits;

  constant SI.Current I_SC = 1.5; // Short-circuit current that depends on the type of panel (NEED TO BE VALIDATED BY A SPECIALIST)
  
  Integer NumPanel;   // Index of the panels
  

  irradiationConf conf_Irradiance;
  
  configModel conf;
  
  PVCell cells[conf.CELLS_NUMBER];

  SI.Current I ;
  SI.Voltage V;
  SI.Power P;

equation


	  // Set the Irradiance to the panels	  
	  for j in 1:conf.CELLS_NUMBER loop
		cells[j].G = conf_Irradiance.panelIrradiance[NumPanel,j];
	  end for;




	  // Cell in series (voltage summed up and current the same)  
	    V = sum({cells[i].V for i in 1:conf.CELLS_NUMBER});
	  for i in 1:conf.CELLS_NUMBER loop
	    cells[i].I = I;
	  end for;
	  // end of cells in series

	  P = I * V;

end PVPanel;
