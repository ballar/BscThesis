% init_system.m
%% A vizsgalando szerkezet es a vizsgalat alapadatainak megadasa
%% MODOSITHATO
%% 3.2.2 feladat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% idolepesek raszterfelbontasa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% egy idolepes hossza:
   dt = 0.02;
%% vizsgalt idotartam hossza:
   Tmax=6;
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = (0:dt:Tmax); %az idolepesek raszterenek kialakitasa
Tstepnum = size(t,2); %osszes idopillanat szama
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% redszert leiro matrixok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% tomegmatrix:
M = [ 45 ,  0 ;...
       0 , 45 ];
%% merevsegi matrix
K = [ 36000 , -18000 ;...
     -18000 ,  18000 ];
%% aranyos csillapitas:
   ksi = 0.05;
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ndim = size(M,1); %a rendszer merete, kulon nem kell megadni
% sajatertek-feladat megoldasa az aranyos csillapitas szamitasahoz
[V,Omega2] = eigs(K,M,2,'sa'); 
Omega = sqrt(Omega2); %sajatkorfrekvenciak
% ket szabadsagfok eseten alfa es beta pontosan megadhato
alpha = (2*ksi*Omega(1,1)*Omega(2,2))/(Omega(1,1)+Omega(2,2)); 
beta = (2*ksi)/(Omega(1,1)+Omega(2,2));                       
C = alpha*M+beta*K; % csillapitasi matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% tehervektor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% statikus teher
q_0 = [100;100];
q = q_0*cos(0*t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kezdeti feltetelek
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% nincs kezdeti elmozdulas:
   U0(1:Ndim,1) = [0;0];
%% nincs kezdeti sebesseg:
   V0(1:Ndim,1) = [0;0];
   
%% globalis valtozok a visszaterito ero 
% es az erintomerevseg szamitasahoz   
global a b
    a = 200;
    b = 90;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a visszaterito ero a kezdeti idopontban
f_s0 = resisting_force(U0);
% a kezdeti pillanatban a gyorsulas a nemlinearis
% mozgasegyenlet megoldasabol
A0 =  M\(q(:,1)-C*V0-f_s0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%