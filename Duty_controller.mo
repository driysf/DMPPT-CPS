// Perturbe & Observe
function Controller
    parameter Real dutymin = 0.05;
	parameter Real dutymax = 0.95;
	

	input Real x[4];
	input Real u[2];
    	input Real z[5];

	output Real xnext[4];
	output Real y;
	output Real znext[5];
	
			       	
	Real deltaDuty;	
	Real Pold;
	Real Pnew;	
	Real Vpan;			 
	Real Ipan; 
    	Real dtc;

	algorithm
		  
		   // Comunicate the value of the delta duty to the controller	
		   //z[1] := x[3];		  

		   // Delta Duty Control
		   znext := ControllerDelta(z,x[3]);


		   deltaDuty:= znext[1];
		   //deltaDuty := 0.04;



                  // Values coming from the input
		  Ipan := u[1];
		  Vpan := u[2];
		  Pold := x[1] * x[2];    // Initialization of the old value of Power
          	  dtc := x[4];


		 if (dtc <= dutymin) then 
		      dtc := dutymin;  	   
                 elseif (dtc >= dutymax) then 
                      dtc := dutymax;      
                 end if;

   	     	 Pnew := Vpan*Ipan;  

		 if (Pnew <= Pold) then // Observe

			  deltaDuty := -deltaDuty;
			  
		 end if; 

		dtc := dtc + deltaDuty;	// Perturbe

	    	xnext[1] := Ipan;
	    	xnext[2] := Vpan;
	    	xnext[3] := deltaDuty;
	    	xnext[4] := dtc;
	   	y := dtc;
	
end Controller;
