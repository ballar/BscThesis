%% convert_lab2num.m

% visszaterito ero eg�sz szerkezeten
f_si = [f_si_lab;zeros(Ndim-1,1)];

% erintomerevseg matrixanak eloallitasa eg�sz szerkezeten
K_ti = [k_ti_lab , zeros(1,Ndim-1) ;...
        zeros(Ndim-1,Ndim)        ];
    
% aktualis merevseg    
K_akt = K+K_ti;