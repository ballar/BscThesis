% init_conditions.m
 
U = [U0,zeros(Ndim , Tstepnum-1)];
dU = [V0,zeros(Ndim , Tstepnum-1)];   
ddU = [A0,zeros(Ndim , Tstepnum-1)];

K_q = K\q;
        
if  integration_algorithm == 1;    % Euler-Cauchy method
    
        Euler_M_inv_q = M\q;
        Euler_M_inv_C = M\C;
        Euler_M_inv_K = M\K;
    
elseif integration_algorithm == 2;    % Runge-Kutta Method (RK2)

        q_half=[1;1]*sin(10*(t+dt/2));
        U_half=zeros(size(M,1),size(t,2)-1);
        dU_half=zeros(size(M,1),size(t,2)-1);
        ddU_half=zeros(size(M,1),size(t,2)-1);
        
        RK_M_inv_q = M\q;
        RK_M_inv_q_half = M\q_half; 
        RK_M_inv_C = M\C;
        RK_M_inv_K = M\K;

elseif integration_algorithm == 3;    % Central difference method
        
        U_00 = 0.5*(M\(dt*dt*(q(:,1)-K*U(:,1)-C*dU(:,1)+2/(dt*dt)*M*U(:,1)))-2*dt*dU(:,1));
        
        CentDiff_L = (1/(dt*dt)*M+1/(2*dt)*C);
        CentDiff_L_inv_q = CentDiff_L\q;
        CentDiff_F=CentDiff_L\(2/(dt*dt)*M-K);
        CentDiff_G=CentDiff_L\(1/(2*dt)*C-1/(dt*dt)*M);
        
    elseif integration_algorithm == 4;     % Newmark`s Method
               
        Newmark_a0 = 1/(Newmark_beta*(dt*dt));
        Newmark_a1 = Newmark_a0*dt;
        Newmark_a2 = 1/(2*Newmark_beta)-1;
        Newmark_a3 = Newmark_gamma/(Newmark_beta*dt);
        Newmark_a4 = Newmark_gamma/Newmark_beta-1;
        Newmark_a5 = (Newmark_gamma/(2*Newmark_beta)-1)*dt;

        Newmark_L = K+Newmark_a0*M+Newmark_a3*C;
        Newmark_L_inv_q = Newmark_L\q;

        Newmark_L_inv_M    = Newmark_L\M;
        Newmark_L_inv_M_a0 = Newmark_L_inv_M *Newmark_a0;
        Newmark_L_inv_M_a1 = Newmark_L_inv_M *Newmark_a1;
        Newmark_L_inv_M_a2 = Newmark_L_inv_M *Newmark_a2;

        Newmark_L_inv_C    = Newmark_L\C;
        Newmark_L_inv_C_a3 = Newmark_L_inv_C*Newmark_a3;
        Newmark_L_inv_C_a4 = Newmark_L_inv_C*Newmark_a4;
        Newmark_L_inv_C_a5 = Newmark_L_inv_C*Newmark_a5;

        Newmark_L_inv_MC_U   = (Newmark_L_inv_M_a0+Newmark_L_inv_C_a3);
        Newmark_L_inv_MC_dU  = (Newmark_L_inv_M_a1+Newmark_L_inv_C_a4);
        Newmark_L_inv_MC_ddU = (Newmark_L_inv_M_a2+Newmark_L_inv_C_a5);
        
    elseif integration_algorithm == 5;      % Wilson Theta Method
        
        U_theta = zeros(Ndim , Tstepnum);
        
        WilsonT_a0 = 6/((WilsonT_theta*dt)^2);
        WilsonT_a1 = 3/(WilsonT_theta*dt);
        WilsonT_a2 = 2*WilsonT_a1;
        WilsonT_a3 = WilsonT_theta*dt/2;
        WilsonT_a4 = WilsonT_a0/WilsonT_theta;
        WilsonT_a5 = -WilsonT_a2/WilsonT_theta;
        WilsonT_a6 = 1-3/WilsonT_theta;
        WilsonT_a7 = dt/2;
        WilsonT_a8 = dt*dt/6;

        WilsonT_L               = K+WilsonT_a0*M+WilsonT_a1*C;
        WilsonT_L_inv_q         = WilsonT_L\q;
        WilsonT_L_inv_theta_q   = WilsonT_L\(WilsonT_theta*q);

        WilsonT_L_inv_M     = WilsonT_L\M;
        WilsonT_L_inv_M_a0  = WilsonT_L_inv_M*WilsonT_a0;
        WilsonT_L_inv_M_a2  = WilsonT_L_inv_M*WilsonT_a2;
        WilsonT_L_inv_M_2   = WilsonT_L_inv_M*2;

        WilsonT_L_inv_C     = WilsonT_L\C;
        WilsonT_L_inv_C_a1  = WilsonT_L_inv_C*WilsonT_a1;
        WilsonT_L_inv_C_2   = WilsonT_L_inv_C*2;
        WilsonT_L_inv_C_a3  = WilsonT_L_inv_C*WilsonT_a3;

        WilsonT_L_inv_MC_U   = (WilsonT_L_inv_M_a0+WilsonT_L_inv_C_a1);
        WilsonT_L_inv_MC_dU  = (WilsonT_L_inv_M_a2+WilsonT_L_inv_C_2);
        WilsonT_L_inv_MC_ddU = (WilsonT_L_inv_M_2+WilsonT_L_inv_C_a3);
        
    elseif integration_algorithm == 6;      % HHT-alpha Method
        
        q_alpha = [1;1]*sin(10*(t+HHTa_alpha));

        HHTa_a0 = 1/(HHTa_beta*(dt*dt));
        HHTa_a1 = HHTa_a0*dt;
        HHTa_a2 = 1/(2*HHTa_beta)-1;
        HHTa_a3 = HHTa_gamma/(HHTa_beta*dt);
        HHTa_a4 = HHTa_gamma/HHTa_beta-1;
        HHTa_a5 = (HHTa_gamma/(2*HHTa_beta)-1)*dt;

        HHTa_L = HHTa_alpha*K+HHTa_a0*M+HHTa_alpha*HHTa_a3*C;
        HHTa_L_inv_q_alpha = HHTa_L\q_alpha;
        
        HHTa_L_inv_M    = HHTa_L\M;
        HHTa_L_inv_M_a0 = HHTa_L_inv_M *HHTa_a0;
        HHTa_L_inv_M_a1 = HHTa_L_inv_M *HHTa_a1;
        HHTa_L_inv_M_a2 = HHTa_L_inv_M *HHTa_a2;

        HHTa_L_inv_C    = HHTa_L\C*HHTa_alpha;
        HHTa_L_inv_C_a3 = HHTa_L_inv_C*HHTa_a3;
        HHTa_L_inv_C_a4 = HHTa_L_inv_C*HHTa_a4;
        HHTa_L_inv_C_a5 = HHTa_L_inv_C*HHTa_a5;
        
        HHTa_L_inv_HHTa_alpha_K = HHTa_L\K*(HHTa_alpha-1);
        HHTa_L_inv_HHTa_alpha_C = HHTa_L\C*(HHTa_alpha-1);
        
        HHTa_L_inv_MC_U   = (HHTa_L_inv_M_a0+HHTa_L_inv_C_a3+HHTa_L_inv_HHTa_alpha_K);
        HHTa_L_inv_MC_dU  = (HHTa_L_inv_M_a1+HHTa_L_inv_C_a4+HHTa_L_inv_HHTa_alpha_C);
        HHTa_L_inv_MC_ddU = (HHTa_L_inv_M_a2+HHTa_L_inv_C_a5);
    
    elseif integration_algorithm == 7;      % CR Algorithm
        
        CR_alpha2_dt_dt = CR_alpha2*(dt^2);
        CR_alpha1_dt = CR_alpha1*dt;
        CR_M_inv_q = M\q;
        CR_M_inv_C = M\C;
        CR_M_inv_K = M\K;
        
else
end