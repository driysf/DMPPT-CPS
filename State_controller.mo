function StateController
	import SI = Modelica.SIunits;
	
	constant SI.Current deltaCurrent = 0.05;
	
	input SI.Current I_out;
	input SI.Current Ipan;
	input SI.Current I_SC;
	
	output Integer mode;
	
algorithm 
	  // CUT-OFF
			  if I_out < Ipan then
						mode := 2;
	
			  //PASS-THROUGH										
			  elseif (I_out >Ipan - deltaCurrent and I_out <= Ipan + deltaCurrent) then
						mode := 3;

			  //MPPT			
			  elseif I_out > Ipan and I_out < I_SC then 
						mode := 1;
						
			  // BY-PASS							 
			  else //if I_out >= I_SC then 
						mode := 4;
						 				   	
			  end if;
			  
end StateController;