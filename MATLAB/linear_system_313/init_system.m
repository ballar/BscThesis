% init_system.m
%% A vizsgalando szerkezet es a vizsgalat alapadatainak megadasa
%% MODOSITHATO
%% 3.1.3 szabadrezgeses feladat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% idolepesek raszterfelbontasa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% egy idolepes hossza:
   dt = 0.02;
%% vizsgalt idotartam hossza:
   Tmax=12.;
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = (0:dt:Tmax); %az idolepesek raszterenek kialakitasa
Tstepnum = size(t,2); %osszes idopillanat szama
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% redszert leiro matrixok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% tomegmatrix:
   M = [45 , 0;...
         0 , 45];     
%% merevsegi matrix
   K = [ 36000 , -18000;...
        -18000 , 18000];    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ndim = size(M,1); %a rendszer merete, kulon nem kell megadni
% sajatertek-feladat megoldasa a kezdeti feltetelekhez
[V,Omega2] = eigs(K,M,2,'sa'); 
Omega = sqrt(Omega2); %sajatkorfrekvenciak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% zerus csillapitas
C = zeros(Ndim,Ndim); %csillapitasi matrix                 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% tehervektor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% zerus teher
   q = zeros(Ndim,Tstepnum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kezdeti feltetelek
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% az egyik sajatvektorral aranyos kezdeti elmozdulas:
    U0(1:Ndim,1) = V(:,1);
%% nincs kezdeti sebesseg:
    V0(1:Ndim,1) = [0;0];
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a kezdeti pillanatban a gyorsulas a mozgasegyenlet megoldasabol
A0 = M\(q(:,1)-C*V0-K*U0); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
