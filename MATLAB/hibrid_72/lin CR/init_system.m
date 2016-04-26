% init_system.m
%% Initialize system

%% raster

dt = 0.06;
t = (0:dt:15);

Tstepnum = size(t,2);

%% system matrices

M = [ 45 ,  0 ;...
       0 , 45 ];
K = [ 36000 , -18000 ;...
     -18000 ,  18000 ];

Ndim = size(M,1);

[V,Omega2] = eigs(K,M,2,'sa');
Omega =  sqrt(Omega2);
ksi = 0.05;

alpha = (2*ksi*Omega(1,1)*Omega(2,2))/(Omega(1,1)+Omega(2,2));
beta = (2*ksi)/(Omega(1,1)+Omega(2,2));
C = alpha*M+beta*K;

%% load vector

q = [20;20]*sin(20*t);


%% initial conditions

U0(1:Ndim,1) = [0;0];
V0(1:Ndim,1) = [0;0];
A0 =  M\(q(:,1)-C*V0-K*U0);
