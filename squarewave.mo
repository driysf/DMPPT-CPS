function SquareWave
  input Real T;
  input Real dt;
  input Real t;
  output Real result;
algorithm
  result := if mod(t, T) < T * dt then 1 else 0;
end SquareWave;

