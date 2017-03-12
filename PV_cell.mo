model PVCell

  import SI = Modelica.SIunits;
  import k = Modelica.Constants.k "Bolzmann constant";


  constant SI.Charge q = 1.6e-19 "Elementary charge";
  constant SI.Energy E_gap = 1.124 * q "Band gap Energy";
  constant SI.Temperature T_stc = SI.Conversions.from_degC(25) "STC cell temperature";
  constant SI.Irradiance G_stc = 1000 "STC sun irradiance";
  constant SI.Current I_ph_stc = 7.7 "STC photocurrent";  

  
  parameter SI.Resistance R_s = 0.11 "Cell serial resistor";
  parameter SI.Resistance R_p = 148  "Cell parallel resistor";
  parameter SI.Temperature NOCT = SI.Conversions.from_degC(46) "Nominal operating cell temperature";
  
  parameter SI.Temperature T_amb = SI.Conversions.from_degC(20) "Ambient temperature";
  parameter Real nu (unit = "1") = 1.0255 "Diode ideality factor";
  parameter Real C_0 (unit = "A/K^3") = 373 "Diode temperature coefficient";
  parameter Real alpha (unit = "1/K") = 0.07 "Current thermal coefficient";

   SI.Irradiance G "Sun irradiance";
  
  SI.Temperature T "Cell temperature";
  SI.Current I_0 "Diode saturation current";
  SI.Current I_ph "Photocurrent";
  SI.Current I;
  SI.Voltage V;
  SI.Power P;



equation
  I = I_ph - I_0 * (exp(q * (V + R_s * I) / (nu * k * T)) - 1) - ((V + R_s * I) / R_p) "Kirchhof's law for R_s node";
  I_ph = I_ph_stc * G / G_stc * (1 + alpha * (T - T_stc));
  T = T_amb + (NOCT - SI.Conversions.from_degC(20)) * G / 800;
  I_0 = C_0 * T^3 * exp(-E_gap / (k * T));
  P = I * V;

end PVCell;
