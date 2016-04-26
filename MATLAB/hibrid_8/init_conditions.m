% init_conditions.m
%% helyfoglalo matrixok es segedmatrixok

% elmozdulasvektorok helyfoglalasa
U = [U0,zeros(Ndim , Tstepnum-1)];

% elore elvegezheto muveletek
CR_M_inv_q = M\q; 
CR_M_inv_C = M\C;   