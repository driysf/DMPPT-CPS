model ClosedLoop
  import SI = Modelica.SIunits;
  constant SI.Frequency f_a = 100; // 10 ms
  constant SI.Time T_a = 1 / f_a;

  Plant plant;
  
  configModel conf;
  
  discrete Real x[4];
  discrete Real u[2];
  discrete Real z[5];
  discrete Real y;

initial equation
  //x[] is the set of the state variables of the duty Controller and z[] is the set of the state variables of the Delta Duty controller


  // State variables of the Duty Controller
  x[1] = plant.panel.I;
  x[2] = plant.panel.V;
  x[3] = 0.04;		// initial value of delta Duty
  x[4] = 0; 		// initial value of duty cycle



  // State variables of the DeltaDuty Controller 
  z[1] = 0.04;  	// initial value of delta Duty
  z[2] = 0; 		// initial value of main_counter
  z[3] = 0; 		// initial value of p_counter
  z[4] = 0; 		// initial value of n_counter
  z[5] = 0;		// initial value of the last delta Duty

 
equation
  plant.dt = y;
  when sample(0, T_a) then // We sample to implement the "Perturbe & observe" methodology
    u[1] = plant.panel.I;
    u[2] = plant.panel.V;
    (x, y, z) = Controller(pre(x), u, pre(z));
  end when;
 
end ClosedLoop;
