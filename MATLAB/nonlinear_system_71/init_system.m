% init_system.m
%% A vizsgalando szerkezet es a vizsgalat alapadatainak megadasa
%% MODOSITHATO

%% globalis valtozok
global dt  t  Tstepnum k_n  L  H K;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% idolepesek raszterfelbontasa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% egy idolepes hossza:
   dt = 0.01;
%% vizsgalt idotartam hossza:
   Tmax=35;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = (0:dt:Tmax); %az idolepesek raszterenek kialakitasa
Tstepnum = size(t,2); %osszes idopillanat szama
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% redszert leiro matrixok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a szerkezet geometriaja
L = 3;
H = 3;
% a nemlinearis merevito rud merevsege
EA=76373;
k_n = EA/(sqrt(L^2+H^2));
% az egyes szintek merevsege
k = 18000;
%% tomegmatrix:
M = [ 45 ,  0 ;...
       0 , 45 ];
%% merevsegi matrix
K = k*[ 2 , -1 ;...
       -1 ,  1 ];
%% aranyos csillapitas
    ksi = 0.05; 
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ndim = size(M,1); %a rendszer merete, kulon nem kell megadni
% sajatertek-feladat megoldasa az aranyos csillapitas szamitasahoz
[V,Omega2] = eigs(K,M,2,'sa'); 
Omega = sqrt(Omega2); %sajatkorfrekvenciak
% ketzsabadsegfoku rendszer eseten alfa es beta szamithato
alpha = (2*ksi*Omega(1,1)*Omega(2,2))/(Omega(1,1)+Omega(2,2));
beta = (2*ksi)/(Omega(1,1)+Omega(2,2));
C = alpha*M+beta*K; % a csillapitasi matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% tehervektor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% minden idopillanathoz zerusertekekkel feltoltes:
   q = zeros(Ndim,Tstepnum); 
%% tamasz gyorsulasanak beolvasasa
   [ upp,tload,input_accel ] = EQ_load('elcentro.dat');
%% minden tomeg rezeg:
   iranyvektor=ones(Ndim,1); qtomeg=-M*iranyvektor;
%% a vizsgalt idoszak
   for i=1:Tstepnum
       q(:,i)=qtomeg*upp(i);
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kezdeti feltetelek
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% nincs kezdeti elmozdulas:
   U0(1:Ndim,1) = zeros(Ndim,1); 
%% nincs kezdeti sebesseg:
   V0(1:Ndim,1) = zeros(Ndim,1);
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a visszaterito ero a kezdeti idopontban
f_s0 = resisting_force(U0);
% a kezdeti pillanatban a gyorsulas a nemlinearis
% mozgasegyenlet megoldasabol
A0 =  M\(q(:,1)-C*V0-f_s0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




