% timestep.m
%% Elmozdulasok szamitasa es tarolasa
%% NEM MODOSITHATO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Euler-Cauchy modszer
if integration_algorithm == 1;    
    
    %% kovetkezo elmozdulas szamitasa
        U(:,i+1)   = U(:,i)+dU(:,i)*dt;
    %% kovetkezo sebesseg szamitasa
        dU(:,i+1)  = dU(:,i)+ddU(:,i)*dt;
    %% kovetkezo gyorsulas szamitasa
        ddU(:,i+1) = Euler_M_inv_q(:,i+1)...
                   - Euler_M_inv_C*dU(:,i+1)...
                   - Euler_M_inv_K*U(:,i+1);
    
%% Runge-Kutta modszer (RK2)    
elseif integration_algorithm == 2;   

    %% kovetkezo felezo elmozdulas szamitasa
        U_half(:,i)   = U(:,i)+(dt/2)*dU(:,i);
    %% kovetkezo felezo sebesseg szamitasa
        dU_half(:,i)  = dU(:,i)+(dt/2)*ddU(:,i);
    %% kovetkezo felezo gyorsulas szamitasa
        ddU_half(:,i) = RK_M_inv_q_half(:,i)...
                      - RK_M_inv_C*dU_half(:,i)...
                      - RK_M_inv_K*U_half(:,i);
    %% kovetkezo elmozdulas szamitasa
        U(:,i+1)   = U(:,i)+dU_half(:,i)*dt;
    %% kovetkezo sebesseg szamitasa
        dU(:,i+1)  = dU(:,i)+ddU_half(:,i)*dt;
    %% kovetkezo gyorsulas szamitasa
        ddU(:,i+1) = RK_M_inv_q(:,i+1)...
                   - RK_M_inv_C*dU(:,i+1)-RK_M_inv_K*U(:,i+1);
    
%% Centralis differenciak modszere
elseif integration_algorithm == 3;       
    
    %% kovetkezo elmozdulas szamitasa
       % az elso idopontban
       if i == 1
            U(:,i+1) = CentDiff_L_inv_q(:,i)...
                     + CentDiff_F*U(:,i)+CentDiff_G*U_00;
            % sebesseg szamitasa a mechanikai energiahoz
            dU(:,i+1) = 1/(2*dt)*(U(:,i+1)-U_00);     
        % es azt kovetoen
        else
            U(:,i+1) = CentDiff_L_inv_q(:,i)...
                     + CentDiff_F*U(:,i)+CentDiff_G*U(:,i-1);
            % sebesseg szamitasa a mechanikai energiahoz
            dU(:,i+1) = 1/(2*dt)*(U(:,i+1)-U(:,i-1));     
        end
%% Newmark modszer        
elseif integration_algorithm == 4;      
        
    %% kovetkezo elmozdulas szamitasa
        U(:,i+1) = Newmark_L_inv_q(:,i+1)...
                 + Newmark_L_inv_MC_U*U(:,i)...
                 + Newmark_L_inv_MC_dU*dU(:,i)...
                 + Newmark_L_inv_MC_ddU*ddU(:,i);
    %% kovetkezo sebesseg szamitasa
        dU(:,i+1) = Newmark_a3*(U(:,i+1)-U(:,i))...
                  - Newmark_a4*dU(:,i)-Newmark_a5*ddU(:,i);
    %% kovetkezo gyorsulas szamitasa
        ddU(:,i+1) = Newmark_a0*(U(:,i+1)-U(:,i))...
                   - Newmark_a1*dU(:,i)-Newmark_a2*ddU(:,i);
    
%% Wilson Theta eljaras       
elseif integration_algorithm == 5;      
        
    %% elmozdulas szamitasa t+theta*dt pillanatban
        U_theta(:,i+1) = WilsonT_L_inv_q(:,i)...
                       + WilsonT_L_inv_theta_q(:,i+1)...
                       - WilsonT_L_inv_theta_q(:,i)...
                       + WilsonT_L_inv_MC_U*U(:,i)...
                       + WilsonT_L_inv_MC_dU*dU(:,i)...
                       + WilsonT_L_inv_MC_ddU*ddU(:,i);
    %% kovetkezo gyorsulas szamitasa
        ddU(:,i+1) = WilsonT_a4*(U_theta(:,i+1)-U(:,i))...
                   + WilsonT_a5*dU(:,i)+WilsonT_a6*ddU(:,i);
    %% kovetkezo sebesseg szamitasa
        dU(:,i+1) = dU(:,i)+WilsonT_a7*(ddU(:,i+1)+ddU(:,i));
    %% kovetkezo elmozdulas szamitasa
        U(:,i+1) = U(:,i)+dt*dU(:,i)...
                 + WilsonT_a8*(ddU(:,i+1)+2*ddU(:,i));
        
%% HHT-alfa modszer       
elseif integration_algorithm == 6;      
        
    %% kovetkezo elmozdulas szamitasa
        U(:,i+1) = HHTa_L_inv_q_alpha(:,i)...
                 + HHTa_L_inv_MC_U*U(:,i)...
                 + HHTa_L_inv_MC_dU*dU(:,i)...
                 + HHTa_L_inv_MC_ddU*ddU(:,i);
    %% kovetkezo sebesseg szamitasa
        dU(:,i+1) = HHTa_a3*(U(:,i+1)-U(:,i))...
                  - HHTa_a4*dU(:,i)-HHTa_a5*ddU(:,i);
    %% kovetkezo gyorsulas szamitasa
        ddU(:,i+1) = HHTa_a0*(U(:,i+1)-U(:,i))...
                   - HHTa_a1*dU(:,i)-HHTa_a2*ddU(:,i);
        
%% CR algoritmus  
elseif integration_algorithm == 7;     
    
    %% kovetkezo elmozdulas szamitasa
        U(:,i+1)   = U(:,i)+dt*dU(:,i)+CR_alpha2_dt_dt*ddU(:,i);
    %% kovetkezo sebesseg szamitasa
        dU(:,i+1)  = dU(:,i)+CR_alpha1_dt*ddU(:,i);
    %% kovetkezo gyorsulas szamitasa
        ddU(:,i+1) = CR_M_inv_q(:,i+1)...
                   - CR_M_inv_C*dU(:,i+1)-CR_M_inv_K*U(:,i+1);
        
%% kilepes        
else
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%