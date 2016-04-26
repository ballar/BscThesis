%integration_parameters.m
%% Integralo parameterek megadasa
%% MODOSITHATO

%% Newmark modszer        
if integration_algorithm == 4;     
     %% default values: gamma=0.5, beta=0.25
     % Newmark konstans atlagos gyorsulassal: gamma=0.5, beta=0.25
     % Newmark linearis gyorsulassal: gamma=0.5, beta=1/6
     % Newmark explicit: gamma=0.5, beta=0
     Newmark_gamma = 0.5;
     Newmark_beta = 0.25;
     % ha nem megfelelo az ertek, figyelmeztet
     if Newmark_gamma < 0.5 ||...
             Newmark_beta < 0.25*(0.5+Newmark_gamma)^2
        print('Warning: The method is not stable.')    
     end
     
%% Wilson Theta eljaras       
elseif integration_algorithm == 5;     
    %% default value: 1.37
    WilsonT_theta = 1.37;  % 1.0 < WilsonT_theta < 1.4  

%% HHT-alfa modszer       
elseif integration_algorithm == 6;      
    %% default value: HHTa_alpha = 0.67
    HHTa_alpha = 0.70;     % 0.67 < HHTa_alpha < 1.0
    HHTa_beta  = (2-HHTa_alpha)^2/4; %(2-HHTa_alpha)^2/4 >= 0.25
    HHTa_gamma = 1.5-HHTa_alpha;   %  1.5-HHTa_alpha >= 0.5
    
%% CR algoritmus  
elseif integration_algorithm == 7;      
    %% default values
    CR_alpha1 = (4*M+2*dt*C+(dt^2)*K)\(4*M);
    CR_alpha2 =  CR_alpha1;
    
%% mas modszereknel nem szamol
else 
end