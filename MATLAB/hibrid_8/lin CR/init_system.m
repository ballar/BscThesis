% init_system.m
%% A vizsgalando szerkezet es a vizsgalat alapadatainak mgadasa
%% 
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

%%%%%%%%%%%%%%%%%%
%% system matrices
%%%%%%%%%%%%%%%%%%
m=45.359237;       k=138148.17;
Mfix=eye(5)*m;     Kfix=eye(5)*(k*2);  
Kfix(1,2)=-k; Kfix(2,1)=-k; Kfix(2,3)=-k; Kfix(3,2)=-k;
Kfix(3,4)=-k; Kfix(4,3)=-k; Kfix(4,5)=-k; Kfix(5,4)=-k;
Kfix(5,5)=k;
[Ufix,Vfix]=eig(Kfix,Mfix);
for i=1:5 Tfix(i)=2*pi/sqrt(Vfix(i,i)); end; Tfix;
alfa1K=0.02/sqrt(Vfix(1,1));
Cfix=alfa1K*Kfix;
for i=1:5 ksi_fix(i)=alfa1K*sqrt(Vfix(i,i)); end; ksi_fix;
for i=1:5 ksi_fix(i)=(Ufix(:,i)'*Cfix*Ufix(:,i))/sqrt(Vfix(i,i)); end; ksi_fix;

kb=pi*pi*m*6; cb=0.1*6*m*pi;
Mb=eye(6)*m;  Kb(2:6,2:6)=Kfix(1:5,1:5); 
Kb(1,1)=k+kb; Kb(1,2)=-k; Kb(2,1)=-k;
[Ub,Vb]=eig(Kb,Mb);
for i=1:6 Tb(i)=2*pi/sqrt(Vb(i,i)); end; Tb;
Cb(2:6,2:6)=Cfix(1:5,1:5);  Cb(1,1)=cb+Cb(6,6);
Cb(1,2)=-alfa1K*k; Cb(2,1)=-alfa1K*k;
for i=1:6 ksi_b(i)=(Ub(:,i)'*Cb*Ub(:,i))/sqrt(Vb(i,i)); end; ksi_b;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ndim = size(M,1); % a rendszer merete, kulon nem kell megadni
[V,Omega2] = eig(K,M); % sajatertek-feladat megoldasa az 
                                  % aranyos csillapitas szamitasahoz
Omega = sqrt(Omega2); % sajatkorfrekvenciak
%% ket szf. eseten alfa es  beta pontosan megadhato
% alpha = (2*ksi*Omega(1,1)*Omega(2,2))/(Omega(1,1)+Omega(2,2)); 
% beta = (2*ksi)/(Omega(1,1)+Omega(2,2));                        
% C = alpha*M+beta*K; %csillapitasi matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
%% load vector
%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%
%% initial conditions
%%%%%%%%%%%%%%%%%%%%%
%% nincs kezdeti elmozdulas:
   U0(1:Ndim,1) = zeros(Ndim,1); 
%% nincs kezdeti sebesseg:
   V0(1:Ndim,1) = zeros(Ndim,1); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A0 = M\(q(:,1)-C*V0-K*U0); % a kezdeti pillanatban a gyorsulas 
                           % a mozgasegyenlet megoldasabol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%