function ControllerDelta	
	 input Real z[5];
	 input Real x;
	 protected  Real DeltaDuty;
	 protected Real main_counter;
	 protected Real p_counter;
	 protected Real n_counter;
	 protected Real oldDeltaDuty;	
	
	 protected constant Real deltaDeltaDuty = 0.001; // 0.1%
	 protected constant Real Nn = 12.00;
	 protected constant Real Np = 5.00;

	 public output Real znext[5];

algorithm
       

	// Intialisation of the values

	DeltaDuty := x;
   	main_counter:= z[2];
	p_counter:= z[3];
	n_counter:= z[4];
	oldDeltaDuty:= z[5];

	

	if sign(DeltaDuty) > sign(oldDeltaDuty) then
		main_counter := main_counter + 1;
		if main_counter <= 1 then 
			n_counter := n_counter + 1;
			if n_counter >= Nn then
				DeltaDuty := DeltaDuty - deltaDeltaDuty; 
				p_counter := 0;
				n_counter := 0;
			end if; 				
		else 
			p_counter := p_counter + 1;
			if p_counter >= Np then
				DeltaDuty := DeltaDuty + deltaDeltaDuty;
				p_counter := 0;
				n_counter := 0;
			end if;
		end if;
			
	else
		main_counter := 0;

	end if;	

	

	// Save the values
	znext[1] := DeltaDuty;
	znext[2] := main_counter;
	znext[3] := p_counter;
	znext[4] := n_counter;
	znext[5] := x;
	//znext[5] := -0.000001; // for testing the condition sign(DeltaDuty) > sign(oldDeltaDuty)
	
	
	
  
end ControllerDelta;
