% init_conditions.m
%% A szamitashoz szokseges helyfoglalo matrixok 
%% es segedmatrixok eloallitasa
%% NEM MODOSITHATO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% helyfoglalo matrixok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% elmozdulasvektor helyfoglalo matrixa a kezdeti ertekkel
%  es nullakkal feltoltve
U = [U0,zeros(Ndim , Tstepnum-1)];

%% statikus elmozdulas szamitasa
K_q = K\q;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% segedmatrixok a szamitashoz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Centralis differenciak modszere
if   integration_algorithm == 1;    % Central difference method
        
    %% elmozdulas -1 idopontban
        U_00 = 0.5*(M\(dt*dt*(q(:,1)-f_s0-C*V0+2/(dt*dt)*M*U(:,1)))-2*dt*V0);
          
    %% elore elvegezheto muveletek  
        CentDiff_a0 = 1/(dt*dt)*M;
        CentDiff_a1 = 1/(2*dt)*C;
        
    %% hatekony tomegmatrix  inverzevel szorzas    
        CentDiff_L = (CentDiff_a0+CentDiff_a1);
        CentDiff_L_inv = inv(CentDiff_L);
        CentDiff_L_inv_q = inv(CentDiff_L)*q;
        CentDiff_F = (CentDiff_a0-CentDiff_a1);
        CentDiff_L_inv_F = inv(CentDiff_L)*CentDiff_F;
    
%% Newmark modszer gyorsulasos valtozat       
elseif integration_algorithm == 2;     

   %% sebesseg- es gyorsulasvektorok helyfoglalo matrixai a kezdeti
%    ertekekkel es nullakkal feltoltve
        dU = [V0,zeros(Ndim , Tstepnum-1)];   
        ddU = [A0,zeros(Ndim , Tstepnum-1)];       

    %% elore elvegezheto muveletek  
        Newmark_a0 = 1/(Newmark_beta*(dt*dt));
        Newmark_a1 = Newmark_a0*dt;
        Newmark_a2 = 1/(2*Newmark_beta)-1;
        Newmark_a3 = Newmark_gamma/(Newmark_beta*dt);
        Newmark_a4 = Newmark_gamma/Newmark_beta-1;
        Newmark_a5 = (Newmark_gamma/(2*Newmark_beta)-1)*dt;
   
%% Newmark modszer elmozulasos valtozat        
elseif integration_algorithm == 3;     % Newmark`s Method (disp)

   %% sebesseg- es gyorsulasvektorok helyfoglalo matrixai a kezdeti
%    ertekekkel es nullakkal feltoltve
        dU = [V0,zeros(Ndim , Tstepnum-1)];   
        ddU = [A0,zeros(Ndim , Tstepnum-1)]; 
        
    %% elore elvegezheto muveletek  
        Newmark_a0 = 1/(Newmark_beta*(dt*dt));
        Newmark_a1 = Newmark_a0*dt;
        Newmark_a2 = 1/(2*Newmark_beta)-1;
        Newmark_a3 = Newmark_gamma/(Newmark_beta*dt);
        Newmark_a4 = Newmark_gamma/Newmark_beta-1;
        Newmark_a5 = (Newmark_gamma/(2*Newmark_beta)-1)*dt;

    %% elore szamithato matrixok  
        Newmark_A_1 = Newmark_a0*M+Newmark_a3*C;
        Newmark_A_2 = Newmark_a1*M+Newmark_a4*C;
        Newmark_A_3 = Newmark_a2*M+Newmark_a5*C;       
    
%% kilepes        
else break;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%