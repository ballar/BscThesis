% init_system.m
%% A vizsgalando szerkezet es a vizsgalat alapadatainak megadasa
%% MODOSITHATO
%% Rugalmas szeizmikus szigetelés

%% globalis valtozok 
global dt  t  Tstepnum; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% idolepesek raszterfelbontasa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% egy idolepes hossza:
   dt = 0.01; 
%% vizsgalt idotartam hossza:
   Tmax=32;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = (0:dt:Tmax); % az idolepesek raszterenek kialakitasa
Tstepnum = size(t,2); % osszes idopillanat szama
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% redszert leiro matrixok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% egyes szintek tomege
m=45.359237;  %[t]
%% egyes szintek merevsege
k=138148.17;  %[kN/m]

%% Fix megtamasztsu epulet 
%%%%%%%%%%%%%%%%%%%%%%%%%%
%% tomegmatrix:
Mfix=eye(5)*m; 
%% merevsegi matrix
Kfix=eye(5)*(k*2);  
Kfix(1,2)=-k; Kfix(2,1)=-k; Kfix(2,3)=-k; Kfix(3,2)=-k;
Kfix(3,4)=-k; Kfix(4,3)=-k; Kfix(4,5)=-k; Kfix(5,4)=-k;
Kfix(5,5)=k;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sajatertek-feladat megoldasa klasszikus csillapitas szamitasahoz
[Ufix,Vfix]=eig(Kfix,Mfix);
for i=1:5 Tfix(i)=2*pi/sqrt(Vfix(i,i)); end; Tfix;
alfa1K=0.02/sqrt(Vfix(1,1));
% csillapitasi matrix
Cfix=alfa1K*Kfix;
% csillapitasi tenyezok
for i=1:5 ksi_fix(i)=alfa1K*sqrt(Vfix(i,i)); end; ksi_fix;
% periodusidok
for i=1:5 ksi_fix(i)=(Ufix(:,i)'*Cfix*Ufix(:,i))/sqrt(Vfix(i,i));
end; ksi_fix;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Szeizmikus szigetelessel ellatott epulet 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kb=pi*pi*m*6; cb=0.1*6*m*pi;
%% tomegmatrix:
Mb=eye(6)*m; 
%% merevsegi matrix
Kb(2:6,2:6)=Kfix(1:5,1:5); 
Kb(1,1)=k+kb; Kb(1,2)=-k; Kb(2,1)=-k;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sajatertek-feladat megoldasa nem-klasszikus csillapitashoz 
[Ub,Vb]=eig(Kb,Mb);
% periodusidok
for i=1:6 Tb(i)=2*pi/sqrt(Vb(i,i)); end; Tb;
% csillapitasi matrix
Cb(2:6,2:6)=Cfix(1:5,1:5);  Cb(1,1)=cb+Cb(6,6);
Cb(1,2)=-alfa1K*k; Cb(2,1)=-alfa1K*k;
% csillapitasi tenyezok
for i=1:6 ksi_b(i)=(Ub(:,i)'*Cb*Ub(:,i))/sqrt(Vb(i,i)); end; ksi_b;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Szamitashoz hsznalt matrixok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% tomegmatrix:
   %M = Mfix;
   M = Mb;
%% merevsegi matrix
   %K = Kfix;
   K = Kb;
%% csillapitasi matrix
   %C = Cfix;
   C = Cb;
%% aranyos csillapitas:
   ksi = 0.05; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ndim = size(M,1); % a rendszer merete, kulon nem kell megadni
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
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a kezdeti pillanatban a gyorsulas a mozgasegyenlet megoldasabol
A0 = M\(q(:,1)-C*V0-K*U0); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%