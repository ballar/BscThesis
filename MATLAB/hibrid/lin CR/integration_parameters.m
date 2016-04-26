%integration_parameters.m
%% Initialize integration parameters

if integration_algorithm == 4;     % Newmark`s Method 
    %default values: gamma=0.5, beta=0.25
     Newmark_gamma = 0.5;
     Newmark_beta = 0.25;
 
     if Newmark_gamma<0.5 || Newmark_beta < 0.25*(0.5+Newmark_gamma)^2
        print('Warning: The method is not stable.')    
     end
     
elseif integration_algorithm == 5;      % Wilson Theta Method
   
    WilsonT_theta = 1.37; % default value: 1.4

elseif integration_algorithm == 6;      % HHT-alpha Method
    
    HHTa_alpha = 0.70; % 0.67 < HHTa_alpha < 1.0
    HHTa_beta  = (2-HHTa_alpha)^2/4; % default value: (2-HHTa_alpha)^2/4 >= 0.25
    HHTa_gamma = 1.5-HHTa_alpha; % default value: 1.5-HHTa_alpha >= 0.5
    
elseif integration_algorithm == 7;      % CR Algorithm
   
    CR_alpha1 = (4*M+2*dt*C+(dt^2)*K)\(4*M);
    CR_alpha2 =  CR_alpha1;
    
else    
         
end
