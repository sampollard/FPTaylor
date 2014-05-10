@rnd = float<ieee_64,ne>;

k = 1.3806503e-23;

res rnd= (p + a * (N / V) * (N / V)) * (V - N * b) - k * N * T;
Mres = (p + a * (N / V) * (N / V)) * (V - N * b) - k * N * T;

{ T in [300.0, 300.0] /\
  a in [0.401, 0.401] /\
  b in [42.7e-6, 42.7e-6] /\
  N in [1000, 1000] /\
  p in [3.5e7, 3.5e7] /\
  V in [0.1, 0.5] 
  -> |res - Mres| in ?}


