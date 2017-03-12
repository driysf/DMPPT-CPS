model Plant

  import SI = Modelica.SIunits;
 
   //Overload Voltage Protection
  constant SI.Voltage V_max = 1.5 * conf.CELLS_NUMBER;
  constant SI.Voltage V_min = 0.1 * conf.CELLS_NUMBER;


  parameter SI.Frequency f_s = 5e4;
  parameter SI.Time T_s = 1 / f_s;


  PVPanel panel;

  configModel conf;
  
  parameter SI.Capacitance C1 = 1e-6;
  parameter SI.Capacitance C2 = 1e-6;
  parameter SI.Inductance L = 1e-3;
  parameter SI.Resistance R_D1_on = 0;
  parameter SI.Resistance R_D1_off = 1e6;
  parameter SI.Resistance R_D2_on = 0;
  parameter SI.Resistance R_D2_off = 1e6;
  parameter SI.Resistance R_D3_on = 0;
  parameter SI.Resistance R_D3_off = 1e6;


  SI.Power P_out;
  SI.Power P_loss;

  SI.Voltage V_out;
  SI.Voltage V_D1;
  SI.Voltage V_D2;
  SI.Voltage V_L;

  SI.Current I_out;
  SI.Current I_C1;
  SI.Current I_C2;
  SI.Current I_D1;
  SI.Current I_D2;
  SI.Current I_L;
  SI.Current I_D3;

  SI.Resistance R_D1;
  SI.Resistance R_D2;
  SI.Resistance R_D3;

  Real dt;
  Boolean on;
  Integer mode;

initial equation
  I_L = 0;
  mode = 1;
 
equation
  
			  			  
			  	    	  
			  I_C1 = C1 * der(panel.V); // condensatore
			  panel.V = V_L + V_D1;
			  V_L = L * der(I_L); 	    // induttanza
			  V_out = V_D1 - V_D2;
			  V_D1 = R_D1 * I_D1;
			  V_D2 = R_D2 * I_D2;
			  I_D2 = I_out + I_C2;
			  I_C2 = C2 * der(V_out);
			  I_L = I_D1 + I_D2;
			  

           
			  if mode == 1 then //MPPT 
				  panel.I=  I_C1 + I_L;
				  on = if SquareWave(T_s, dt, time) > 0 then true else false;    	  				  
				  R_D1 = if on then R_D1_on  else R_D1_off;
				  R_D2 = if on then R_D2_off else R_D2_on;
				  // Overload protection
				  R_D3 = if (V_out >= V_max) then R_D3_on else R_D3_off;

				  V_out = R_D3*I_D3 + ((panel.V * panel.I) / I_out);
							  
		
			   elseif mode == 2 then //CUT-OFF
				  panel.I=  I_C1 + I_L;	
				  on = if SquareWave(T_s, dt, time) > 0 then true else false;	  
				  R_D1 = if on then R_D1_on  else R_D1_off;
				  R_D2 = if on then R_D2_off else R_D2_on;  
				  // Overload protection
				  R_D3 = if (V_out >= V_max) then R_D3_on else R_D3_off;

				  V_out = R_D3*I_D3 + V_max;
				 		 

	 		   elseif mode == 3 then  //PASS-THROUGH
				  panel.I =  I_out;
				  on = if SquareWave(T_s, 0, time) > 0 then true else false;		   
				  R_D1 = R_D1_off;
				  R_D2 = R_D2_on;
				  R_D3 = R_D3_off;

				  V_out = R_D3*I_D3 + panel.V - R_D1 *I_out;
		 
			  else //mode == 4  BY-PASS
				   panel.I = panel.I_SC;
				   on = if SquareWave(T_s, 0, time) > 0 then true else false;			  
				   R_D1 = R_D1_off;
				   R_D2 = R_D2_on;
				   R_D3 = R_D3_off;
					  
				   V_out = R_D3*I_D3 - ((R_D1 + R_D2) * I_out);
				  			   
          		  end if;		

			  P_out = I_out * V_out;
			  P_loss = panel.P - P_out;

 end Plant;
