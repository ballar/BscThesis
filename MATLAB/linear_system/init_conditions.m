% init_conditions.m
%% A szamitashoz szokseges helyfoglalo matrixok 
%% es segedmatrixok eloallitasa
%% NEM MODOSITHATO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% helyfoglalo matrixok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elmozdulas-, sebesseg- es gyorsulasvektorok matrixai a kezdeti
% ertekekkel es nullakkal feltoltve
U = [U0,zeros(Ndim , Tstepnum-1)];    % elmozdulasok
dU = [V0,zeros(Ndim , Tstepnum-1)];   % sebessegek 
ddU = [A0,zeros(Ndim , Tstepnum-1)];  % gyorsulasok
%% statikus elmozdulas szamitasa
K_q = K\q;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% segedmatrixok a szamitashoz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Euler-Cauchy modszer
if  integration_algorithm == 1;   
    
    %% tomegmatrix inverzevel szorzas
        Euler_M_inv_q = M\q; % a tehervektorok szorzasa
        Euler_M_inv_C = M\C; % a csillapitasi matrix szorzasa
        Euler_M_inv_K = M\K; % a merevsegi matrix szorzasa
        
%% Runge-Kutta modszer (RK2)    
elseif integration_algorithm == 2;   
    
    %% tehervektorok matrixanak interpolalasa a felezopontokban
        q_half = zeros(Ndim,Tstepnum-1);  % feltoltes nullakkal  
    % interpolalas
    for k = 1:(Tstepnum-1)
        q_half(:,k) = (q(:,k)-q(:,k+1))*0.5+q(:,k);
    end   
    
    %% helyfoglalo matrixok a felezopontokban
        U_half=zeros(Ndim,Tstepnum-1);   % elmozdulasok 
        dU_half=zeros(Ndim,Tstepnum-1);  % sebessegek 
        ddU_half=zeros(Ndim,Tstepnum-1); % gyorsulasok
     
    %% tomegmatrix inverzevel szorzas
        RK_M_inv_q = M\q;          % tehervektorok szorzasa
        RK_M_inv_q_half = M\q_half;% tehervektorok szorzasa
%                                    a felezopontokban 
        RK_M_inv_C = M\C;          % csillapitasi matrix szorzasa
        RK_M_inv_K = M\K;          % merevsegi matrix szorzasa 
        
%% Centralis differenciak modszere
elseif integration_algorithm == 3;    
 
    %% elmozdulas -1 idopontban
        U_00 = 0.5*(M\(dt*dt*(q(:,1)-K*U(:,1)...
             - C*dU(:,1)+2/(dt*dt)*M*U(:,1)))-2*dt*dU(:,1));
     
    %% hatekony tomegmatrix    
        CentDiff_L = (1/(dt*dt)*M+1/(2*dt)*C);
    %% hatekony tomegmatrix  inverzevel szorzas    
        CentDiff_L_inv_q = CentDiff_L\q;  % tehervektorok
        CentDiff_F=CentDiff_L\(2/(dt*dt)*M-K);
        CentDiff_G=CentDiff_L\(1/(2*dt)*C-1/(dt*dt)*M);

%% Newmark modszer        
elseif integration_algorithm == 4;    
    
    %% elore elvegezheto muveletek  
        Newmark_a0 = 1/(Newmark_beta*(dt*dt));
        Newmark_a1 = Newmark_a0*dt;
        Newmark_a2 = 1/(2*Newmark_beta)-1;
        Newmark_a3 = Newmark_gamma/(Newmark_beta*dt);
        Newmark_a4 = Newmark_gamma/Newmark_beta-1;
        Newmark_a5 = (Newmark_gamma/(2*Newmark_beta)-1)*dt;
    
    %% hatekony merevsegi matrix   
        Newmark_L = K+Newmark_a0*M+Newmark_a3*C;
        % hatekony merevsegi matrix inverzevel szorzas     
        Newmark_L_inv_q = Newmark_L\q;         
    %% elore elvegezheto matrixmuveletek a tomegmatrixszal
        Newmark_L_inv_M    = Newmark_L\M;
        Newmark_L_inv_M_a0 = Newmark_L_inv_M *Newmark_a0;
        Newmark_L_inv_M_a1 = Newmark_L_inv_M *Newmark_a1;
        Newmark_L_inv_M_a2 = Newmark_L_inv_M *Newmark_a2;
    %% elore elvegezheto matrixmuveletek a csillapitasi matrixszal
        Newmark_L_inv_C    = Newmark_L\C;
        Newmark_L_inv_C_a3 = Newmark_L_inv_C*Newmark_a3;
        Newmark_L_inv_C_a4 = Newmark_L_inv_C*Newmark_a4;
        Newmark_L_inv_C_a5 = Newmark_L_inv_C*Newmark_a5;        
    %% elmozdulas-, sebesseg- es gyorsulasvektorok szorzoi    
        Newmark_L_inv_MC_U   = (Newmark_L_inv_M_a0...
                             + Newmark_L_inv_C_a3);
        Newmark_L_inv_MC_dU  = (Newmark_L_inv_M_a1...
                             + Newmark_L_inv_C_a4);
        Newmark_L_inv_MC_ddU = (Newmark_L_inv_M_a2...
                             + Newmark_L_inv_C_a5);
       
%% Wilson Theta eljaras       
elseif integration_algorithm == 5;      
   
    %% elmozdulas helyfoglalasa t+theta idopontban
        U_theta = zeros(Ndim , Tstepnum);
    
    %% elore elvegezheto muveletek  
        WilsonT_a0 = 6/((WilsonT_theta*dt)^2);
        WilsonT_a1 = 3/(WilsonT_theta*dt);
        WilsonT_a2 = 2*WilsonT_a1;
        WilsonT_a3 = WilsonT_theta*dt/2;
        WilsonT_a4 = WilsonT_a0/WilsonT_theta;
        WilsonT_a5 = -WilsonT_a2/WilsonT_theta;
        WilsonT_a6 = 1-3/WilsonT_theta;
        WilsonT_a7 = dt/2;
        WilsonT_a8 = dt*dt/6;
        
    %% hatekony merevsegi matrix   
        WilsonT_L               = K+WilsonT_a0*M+WilsonT_a1*C;
        % hatekony merevsegi matrix inverzevel szorzas
        WilsonT_L_inv_q         = WilsonT_L\q;
        WilsonT_L_inv_theta_q   = WilsonT_L\(WilsonT_theta*q);
    %% elore elvegezheto matrixmuveletek a tomegmatrixszal
        WilsonT_L_inv_M     = WilsonT_L\M;
        WilsonT_L_inv_M_a0  = WilsonT_L_inv_M*WilsonT_a0;
        WilsonT_L_inv_M_a2  = WilsonT_L_inv_M*WilsonT_a2;
        WilsonT_L_inv_M_2   = WilsonT_L_inv_M*2;
    %% elore elvegezheto matrixmuveletek a csillapitasi matrixszal
        WilsonT_L_inv_C     = WilsonT_L\C;
        WilsonT_L_inv_C_a1  = WilsonT_L_inv_C*WilsonT_a1;
        WilsonT_L_inv_C_2   = WilsonT_L_inv_C*2;
        WilsonT_L_inv_C_a3  = WilsonT_L_inv_C*WilsonT_a3;
    %% elmozdulas-, sebesseg- es gyorsulasvektorok szorzoi  
        WilsonT_L_inv_MC_U   = (WilsonT_L_inv_M_a0...
                             + WilsonT_L_inv_C_a1);
        WilsonT_L_inv_MC_dU  = (WilsonT_L_inv_M_a2...
                             + WilsonT_L_inv_C_2);
        WilsonT_L_inv_MC_ddU = (WilsonT_L_inv_M_2...
                             + WilsonT_L_inv_C_a3);

%% HHT-alfa modszer       
elseif integration_algorithm == 6;      

    %% tehervektorok t+alpha*dt idopillanatban
        q_alpha = zeros(Ndim,Tstepnum-1); % helyfoglalas
    % interpolalas    
    for k = 1:(Tstepnum-1)
        q_alpha(:,k) = (q(:,k)-q(:,k+1))*HHTa_alpha+q(:,k);
    end   
    
    %% elore elvegezheto muveletek 
        HHTa_a0 = 1/(HHTa_beta*(dt*dt));
        HHTa_a1 = HHTa_a0*dt;
        HHTa_a2 = 1/(2*HHTa_beta)-1;
        HHTa_a3 = HHTa_gamma/(HHTa_beta*dt);
        HHTa_a4 = HHTa_gamma/HHTa_beta-1;
        HHTa_a5 = (HHTa_gamma/(2*HHTa_beta)-1)*dt;
        
    %% hatekony merevsegi matrix   
        HHTa_L = HHTa_alpha*K+HHTa_a0*M+HHTa_alpha*HHTa_a3*C;
        HHTa_L_inv_q_alpha = HHTa_L\q_alpha;
    %% elore elvegezheto matrixmuveletek a tomegmatrixszal    
        HHTa_L_inv_M    = HHTa_L\M;
        HHTa_L_inv_M_a0 = HHTa_L_inv_M *HHTa_a0;
        HHTa_L_inv_M_a1 = HHTa_L_inv_M *HHTa_a1;
        HHTa_L_inv_M_a2 = HHTa_L_inv_M *HHTa_a2;
    %% elore elvegezheto matrixmuveletek a csillapitasi matrixszal
        HHTa_L_inv_C    = HHTa_L\C*HHTa_alpha;
        HHTa_L_inv_C_a3 = HHTa_L_inv_C*HHTa_a3;
        HHTa_L_inv_C_a4 = HHTa_L_inv_C*HHTa_a4;
        HHTa_L_inv_C_a5 = HHTa_L_inv_C*HHTa_a5;
    %% elore elvegezheto matrixmuveletek   
        HHTa_L_inv_HHTa_alpha_K = HHTa_L\K*(HHTa_alpha-1);
        HHTa_L_inv_HHTa_alpha_C = HHTa_L\C*(HHTa_alpha-1);
    %% elmozdulas-, sebesseg- es gyorsulasvektorok szorzoi          
        HHTa_L_inv_MC_U   = (HHTa_L_inv_M_a0...
                          + HHTa_L_inv_C_a3...
                          + HHTa_L_inv_HHTa_alpha_K);
        HHTa_L_inv_MC_dU  = (HHTa_L_inv_M_a1...
                          + HHTa_L_inv_C_a4...
                          + HHTa_L_inv_HHTa_alpha_C);
        HHTa_L_inv_MC_ddU = (HHTa_L_inv_M_a2+HHTa_L_inv_C_a5);

%% CR algoritmus  
elseif integration_algorithm == 7;      
   
    %% alpha integralasi parameterek szorzasa
        CR_alpha2_dt_dt = CR_alpha2*(dt^2);
        CR_alpha1_dt = CR_alpha1*dt;
    %% tomegmatrix inverzevel szorzas
        CR_M_inv_q = M\q; % tehervektorok szorzasa
        CR_M_inv_C = M\C; % csillapitasi matrix szorzasa
        CR_M_inv_K = M\K; % merevsegi matrix szorzasa

%% kilepes        
else break;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%