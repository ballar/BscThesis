% timestep.m
%% az elmozdulasok szamitasa idolepesenkent CR algoritmussal
%% NEM MODOSITHATO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% integralo parameterek
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% alpha ertekei idolepesenkent valtozik
CR_alpha1 = (4*M+2*dt*C+(dt^2)*K_akt)\(4*M);  
CR_alpha2 =  CR_alpha1;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% elmozdulas szamitas 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kovetkezo elmozdulas
 U_next   = U_akt+dt*dU_akt+CR_alpha2*(dt^2)*ddU_akt;
% kovetkezo sebesseg
 dU_next  = dU_akt+CR_alpha1*dt*ddU_akt;
 
% elmozdulas tarolasa
 U(:,i+1) = U_next;
% elokeszlet a kovetkezo idolepeshez
 U_akt = U_next; dU_akt = dU_next; 