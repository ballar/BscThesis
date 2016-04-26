%% convert_lab2num.m
%% laborerenmenyek convertalasa numerikus szamitashoz

% lokalisbol globalis rendszerbe szamitas
II  = f_s_lab2num( L, H, U_akt ); 

% visszaterito ero globalis rendszerben
f_si_II =f_si_lab*II;
f_si = [f_si_II;zeros(Ndim-1,1)];
% erintomerevseg matrixanak eloallitasa globalis rendszerben
k_ti_II = k_ti_lab*II^2; 
K_ti = [k_ti_II , zeros(1,Ndim-1) ;...
        zeros(Ndim-1,Ndim)        ];
% aktualis merevseg    
K_akt = K+K_ti;