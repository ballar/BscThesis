% init_system.m
%% A vizsgalando szerkezet es a vizsgalat alapadatainak megadasa
%% MODOSITHATO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% idolepesek raszterfelbontasa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% egy idolepes hossza:
   dt = 0.1;
%% vizsgalt idotartam hossza:
   Tmax=2;
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = (0:dt:Tmax); %az idolepesek raszterenek kialakitasa
Tstepnum = size(t,2); %osszes idopillanat szama
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% redszert leiro matrixok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% gyorsulas erteke
g = 386; % [in/(s^2)]
% globalis valtozok
global V_jy alpha k
% az egyes szintek tomege
m = 100/g; %[kips/g]
% az egyes szintek erintomerevsege
k = 100; %[kips/in]

%% tomegmatrix:
M = m*[1 , 0, 0, 0, 0;...
       0 , 1, 0, 0, 0;...
       0 , 0, 1, 0, 0;...
       0 , 0, 0, 1, 0;...
       0 , 0, 0, 0, 1];   
%% merevsegi matrix
K = k*[ 2, -1,  0,  0,  0;...
       -1,  2, -1,  0,  0;...
        0, -1,  2, -1,  0;...
        0,  0, -1,  2, -1;...
        0,  0,  0, -1,  1];
%% modalis csillapitasok szuperpozicioja
    ksi = 0.05; 
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ndim = size(M,1); %a rendszer merete, kulon nem kell megadni
% sajatertek-feladat megoldasa az aranyos csillapitas szamitasahoz
[V,Omega2] = eigs(K,M,Ndim,'sa'); 
Omega = sqrt(Omega2); %sajatkorfrekvenciak
M_n = V.'*M*V;
% csillapitas helyfoglalo matrixa
C = zeros(Ndim,Ndim);
for n=1:Ndim
    C = C + M*(2*ksi*Omega(n,n)/M_n(n,n)*V(:,n)*V(:,n).')*M;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% tehervektor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% talajgyorsulasok amplitudoja
ddUg0=0.5*g; %[g]
% talajgyorsulasok szamitasa
ddUg = zeros(1,Tstepnum);
for j = 1:(Tstepnum/2)
    ddUg(:,j)=ddUg0*sin(2*pi*t(j)); 
end
% tehervektorok
q = -m*[1;1;1;1;1]*ddUg;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kezdeti feltetelek
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% nincs kezdeti elmozdulas:
U0(1:Ndim,1) = [0;0;0;0;0];
%% nincs kezdeti sebesseg:
V0(1:Ndim,1) = [0;0;0;0;0];

%% anyagmodell parameterei
V_jy = 125; %[kips]
alpha = 0.05;
global mat_param; %will be needed insid a function:
mat_param=[k,alpha ,V_jy/k ,0.0,0.0,0.0,0.0,0.0];
%mat_param(1): kb rugalmas merevseg
%mat_param(2): aktiv keplekeny merevseg 
%              es rugalmas merevseg aranya
%mat_param(3): u_0 (elso folyas, delta_jy)
%mat_param(4-8): u_p pillanatnyi keplekeny
%                alakvaltozas szintenkent

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a visszaterito ero a kezdeti idopontban
f_s0 = resisting_force(U0);
% a kezdeti pillanatban a gyorsulas a nemlinearis
% mozgasegyenlet megoldasabol
A0 =  M\(q(:,1)-C*V0-f_s0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%