% timestep.m
%% Elmozdulasok szamitasa es tarolasa
%% NEM MODOSITHATO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Centralis differenciak modszere
if  integration_algorithm == 1;       
        if i == 1
        % elmozdulasnovekmeny szamitasa az elso idolepesben                                       
            DeltaU_koveto = CentDiff_L_inv_q(:,i)...
                          - CentDiff_L_inv*f_s0...
                          + CentDiff_L_inv_F*( U(:,i) - U_00 );
        % kovetkezo elmozdulas szamitasa az elso idolepesben
            U(:,i+1) = U(:,i)+DeltaU_koveto;
            
        else
                        
        % aktualis visszaterito ero szamitasa                                       
            [f_s] = resisting_force(U(:,i));
        % elozo elmozdulasnovekmeny tarolasa                                  
            DeltaU_elozo = DeltaU_koveto;
        % elmozdulasnovekmeny szamitasa                                  
            DeltaU_koveto = CentDiff_L_inv_q(:,i)...
                          - CentDiff_L_inv*f_s...
                          + CentDiff_L_inv_F*DeltaU_elozo;           
        % kovetkezo elmozdulas szamitasa
            U(:,i+1) = U(:,i)+DeltaU_koveto;
            
        end
        
%% Newmark modszer gyorsulasos valtozat       
elseif integration_algorithm == 2;            
    
        % aktualis erintomerevseg szamitasa                                       
            K_T = tangent_stiffness(U(:,i));
        % aktualis visszaterito ero szamitasa                                       
            f_si = resisting_force(U(:,i));
        % kiegyensulyozatlan ero helyfoglalo matrixa                                       
            r_ikov = zeros(Ndim,itermax+1);
        
        %% kvazi-Newton-Raphson iteracio   
           for j = 1:itermax  
        
             % gyorsulas a j+1. iteracios lepesben
                ddU_jkov = (M+dt*Newmark_gamma*C...
                         + dt^2*Newmark_beta*K_T)\(q(:,i+1)...
                         + r_ikov(:,j)-f_si-C*dU(:,i)...
                         - dt*(1-Newmark_gamma)*C*ddU(:,i)...
                         - K_T*dt*dU(:,i)...
                         - K_T*(0.5-Newmark_beta)*dt^2*ddU(:,i));
             % elmozdulas a j+1. iteracios lepesben
                U_jkov = U(:,i)+dt*dU(:,i)...
                       + ((0.5-Newmark_beta)*dt^2)*ddU(:,i)...
                       + (Newmark_beta*(dt^2)*ddU_jkov);
                       
             % visszaterito ero a j+1. iteracios lepesben
                f_s_kov = resisting_force(U_jkov);
             % kiegyensulyozatlan ero a j+1. iteracios lepesben
                r_ikov(:,j+1) = r_ikov(:,j)+q(:,i+1)...
                              - f_s_kov-M*ddU_jkov-C*(dU(:,i)...
                              + ((1-Newmark_gamma)*dt)*ddU(:,i)...
                              + Newmark_gamma*dt*ddU_jkov);
             % konvergencia kriterium ellenorzese   
                if sqrt(r_ikov(:,j+1).'*r_ikov(:,j+1)) < NR_eps1               
                    break  % az iteracio leallitasa              
                end
                                 
            end
            
        % kovetkezo elmozdulas tarolasa                                       
            U(:,i+1) = U_jkov;
        % kovetkezo sebessegvektor szamitasa    
            dU(:,i+1) = Newmark_a3*(U(:,i+1)-U(:,i))...
                      - Newmark_a4*dU(:,i)-Newmark_a5*ddU(:,i);
        % kovetkezo gyorsulasvektor szamitasa    
            ddU(:,i+1) = Newmark_a0*(U(:,i+1)-U(:,i))...
                       - Newmark_a1*dU(:,i)-Newmark_a2*ddU(:,i);    

%% Newmark modszer elmozulasos valtozat        
elseif integration_algorithm == 3;      
    
        % hatekony tehervektor a kovetkezo idopontban
            q_hat = q(:,i+1)+Newmark_A_3*ddU(:,i)...
                  + Newmark_A_2*dU(:,i);
        % aktualis visszaterito ero szamitasa                                       
            f_si = resisting_force(U(:,i));
        % aktualis erintomerevseg szamitasa                                       
            K_T = tangent_stiffness(U(:,i));
            
        % segedmatrix invertalasa iteracio elott                                       
            Newmark_A_1_K_T_inv = inv(Newmark_A_1+K_T);
            
        % aktualis elmozdulas kimentese a szamitas gyorsitasara                                      
            U_i = U(:,i);
        % elmozdulasnovekmenyek helyfoglalasa                                     
            DeltaU_i = zeros(Ndim,1);
        % aktualis visszaterito ero mentese                                       
            f_s = f_si;            
        % kiegyensulyozatlan ero helyfoglalo matrixa                                       
            r_i = zeros(Ndim,itermax);
            
        %% kvazi-Newton-Raphson iteracio   
             for j = 1:itermax 
                 
                 p = q_hat-f_s-Newmark_A_1*DeltaU_i;
             % elmozdulasnovekmeny a j. iteracios lepesben
                 DeltaU_ij = Newmark_A_1_K_T_inv*p;
             % novelt elmozdulasnovekmeny a j. iteracios lepesben
                 DeltaU_i = DeltaU_i+DeltaU_ij;
             % novelt elmozdulas a j. iteracios lepesben
                 U_ij = U_i+DeltaU_i;
             % novelt elmozdulas a j. iteracios lepesben
                 f_s = resisting_force(U_ij);
             % kiegyensulyozatlan ero a j. iteracios lepesben
                r_i(:,j) = Newmark_A_1*DeltaU_i+f_s-q_hat;
                 
             % konvergencia kriterium ellenorzese   
                if sqrt(r_i(:,j).'*r_i(:,j)) < NR_eps1
                     break % az iteracio leallitasa
                end                
                 
             end
             
        % kovetkezo elmozdulas tarolasa                                       
             U(:,i+1) = U_ij;
            
        % kovetkezo sebessegvektor szamitasa    
             dU(:,i+1) = Newmark_a3*(U(:,i+1)-U(:,i))...
                       - Newmark_a4*dU(:,i)-Newmark_a5*ddU(:,i);
        % kovetkezo gyorsulasvektor szamitasa    
             ddU(:,i+1) = Newmark_a0*(U(:,i+1)-U(:,i))...
                        - Newmark_a1*dU(:,i)-Newmark_a2*ddU(:,i);
            
    
else break;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%