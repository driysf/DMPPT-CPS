model Dmppt

  import SI = Modelica.SIunits;

  constant SI.Current deltaCurrent = 0.05;

  constant SI.Resistance R_DCAC = 1;

  parameter SI.Voltage V_DCAC = conf.PANELS_NUMBER * 0.6;
  
  ClosedLoop closed[conf.PANELS_NUMBER]; // Number of Panels for every Closed Loop controller

  configModel conf;


  SI.Current I_out;
  SI.Voltage V_out;
  SI.Power   P_out;
	

equation 

	   // Index the Panels	  
	  for i in 1:conf.PANELS_NUMBER loop
              closed[i].plant.panel.NumPanel  = i;
	  end for;	
	
	  
	   /* Input to the Inverter. BEGIN */
	   V_out = sum({closed[i].plant.V_out for i in 1:conf.PANELS_NUMBER});
	   

	   for i in 1:conf.PANELS_NUMBER loop
               I_out  = closed[i].plant.I_out;
	   end for;

	   
	   /* Input to the Inverter. END */

	   /* Output of the Inverter. BEGIN */
	   V_out = I_out * R_DCAC + V_DCAC;  
	   P_out = V_out * I_out;
	   /* Output of the Inverter. END */

	     /* DETECTION OF THE MODE OF THE CONVERTER. BEGIN */
		when sample(0.01,0.01)  then	
		for i in 1:conf.PANELS_NUMBER loop
						closed[i].plant.mode = StateController(closed[i].plant.I_out , closed[i].plant.panel.I , closed[i].plant.panel.I_SC);	  
		end for;
	     end when;	
	    /* DETECTION OF THE MODE OF THE CONVERTER. END */



   
end Dmppt;
