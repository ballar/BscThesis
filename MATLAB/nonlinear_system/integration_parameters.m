%integration_parameters.m
%% Integralo parameterek es iteracios feltetelek megadasa
%% MODOSITHATO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% integralo parameterek
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Newmark modszer        
if integration_algorithm == 2 || 3;     
     %% default values: gamma=0.5, beta=0.25
     % Newmark konstans atlagos gyorsulassal: gamma=0.5, beta=0.25
     % Newmark linearis gyorsulassal: gamma=0.5, beta=1/6
     % Newmark explicit: gamma=0.5, beta=0
     Newmark_gamma = 0.5;
     Newmark_beta = 0.25;
     % ha nem megfelelo az ertek, figyelmeztet
     if Newmark_gamma<0.5 ||...
        Newmark_beta < 0.25*(0.5+Newmark_gamma)^2
        print('Warning: The method is not stable.')    
     end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% iteracios feltetelek
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

% iteraciok maximalis szama
     itermax = 10;
% kriterium feltetel hatarerteke az iteracio leallitasara     
     NR_eps1 = 10^(-3);
             
end
