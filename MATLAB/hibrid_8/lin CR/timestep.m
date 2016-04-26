% timestep.m


if integration_algorithm == 1;    % Euler
    
        U(:,i+1)   = U(:,i)+dU(:,i)*dt;
        dU(:,i+1)  = dU(:,i)+ddU(:,i)*dt;
        ddU(:,i+1) = Euler_M_inv_q(:,i+1)-Euler_M_inv_C*dU(:,i+1)-Euler_M_inv_K*U(:,i+1);
    
elseif integration_algorithm == 2;    % Runge-Kutta Method (RK2)

    U_half(:,i)   = U(:,i)+dt/2*dU(:,i);
    dU_half(:,i)  = dU(:,i)+dt/2*ddU(:,i);
    ddU_half(:,i) = RK_M_inv_q_half(:,i)-RK_M_inv_C*dU_half(:,i)-RK_M_inv_K*U_half(:,i);
    U(:,i+1)   = U(:,i)+dU_half(:,i)*dt;
    dU(:,i+1)  = dU(:,i)+ddU_half(:,i)*dt;
    ddU(:,i+1) = RK_M_inv_q(:,i+1)-RK_M_inv_C*dU(:,i+1)-RK_M_inv_K*U(:,i+1);

    
elseif integration_algorithm == 3;       % Central difference method
        if i == 1
            U(:,i+1)=CentDiff_L_inv_q(:,i)+CentDiff_F*U(:,i)+CentDiff_G*U_00;
        else U(:,i+1)=CentDiff_L_inv_q(:,i)+CentDiff_F*U(:,i)+CentDiff_G*U(:,i-1);
        end
    elseif integration_algorithm == 4;      % Newmark`s Method
        
        U(:,i+1) = Newmark_L_inv_q(:,i+1)+Newmark_L_inv_MC_U*U(:,i)+Newmark_L_inv_MC_dU*dU(:,i)+Newmark_L_inv_MC_ddU*ddU(:,i);
        dU(:,i+1) = Newmark_a3*(U(:,i+1)-U(:,i))-Newmark_a4*dU(:,i)-Newmark_a5*ddU(:,i);
        ddU(:,i+1) = Newmark_a0*(U(:,i+1)-U(:,i))-Newmark_a1*dU(:,i)-Newmark_a2*ddU(:,i);
    
    elseif integration_algorithm == 5;      % Wilson Theta Method
        
        U_theta(:,i+1) = WilsonT_L_inv_q(:,i)+WilsonT_L_inv_theta_q(:,i+1)-WilsonT_L_inv_theta_q(:,i)+WilsonT_L_inv_MC_U*U(:,i)+WilsonT_L_inv_MC_dU*dU(:,i)+WilsonT_L_inv_MC_ddU*ddU(:,i);
        ddU(:,i+1) = WilsonT_a4*(U_theta(:,i+1)-U(:,i))+WilsonT_a5*dU(:,i)+WilsonT_a6*ddU(:,i);
        dU(:,i+1) = dU(:,i)+WilsonT_a7*(ddU(:,i+1)+ddU(:,i));
        U(:,i+1) = U(:,i)+dt*dU(:,i)+WilsonT_a8*(ddU(:,i+1)+2*ddU(:,i));
        
    elseif integration_algorithm == 6;      % HHT-alpha Method
        
        U(:,i+1) = HHTa_L_inv_q_alpha(:,i)+HHTa_L_inv_MC_U*U(:,i)+HHTa_L_inv_MC_dU*dU(:,i)+HHTa_L_inv_MC_ddU*ddU(:,i);
        dU(:,i+1) = HHTa_a3*(U(:,i+1)-U(:,i))-HHTa_a4*dU(:,i)-HHTa_a5*ddU(:,i);
        ddU(:,i+1) = HHTa_a0*(U(:,i+1)-U(:,i))-HHTa_a1*dU(:,i)-HHTa_a2*ddU(:,i);
        
    elseif integration_algorithm == 7;      % CR Algorithm
        U(:,i+1)   = U(:,i)+dt*dU(:,i)+CR_alpha2_dt_dt*ddU(:,i);
        dU(:,i+1)  = dU(:,i)+CR_alpha1_dt*ddU(:,i);
        ddU(:,i+1) = CR_M_inv_q(:,i+1)-CR_M_inv_C*dU(:,i+1)-CR_M_inv_K*U(:,i+1);
else
end