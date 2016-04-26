% init_system.m
%% A vizsgalando szerkezet es a vizsgalat alapadatainak megadasa
%% MODOSITHATO
%% Verifikalas a 16.4 feladat alapjan [2]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% idolepesek raszterfelbontasa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% egy idolepes hossza:
    dt = 0.1;
%% vizsgalt idotartam hossza:
    Tmax = 2;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = (0:dt:Tmax); %az idolepesek raszterenek kialakitasa
Tstepnum = size(t,2); %osszes idopillanat szama
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% redszert leiro matrixok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% gyorsulas erteke
    g = 386; % [in/(s^2)]
% egyes szintek tomege    
    m = 100/g; %[kips/g]
% egyes szintek merevsege    
    k = 100; %[kips/in]

%% tomegmatrix:
M_full = m*[1 , 0, 0, 0, 0;...
            0 , 1, 0, 0, 0;...
            0 , 0, 1, 0, 0;...
            0 , 0, 0, 1, 0;...
            0 , 0, 0, 0, 1];
%% merevsegi matrix      
K_full = k*[ 2, -1,  0,  0,  0;...
            -1,  2, -1,  0,  0;...
             0, -1,  2, -1,  0;...
             0,  0, -1,  2, -1;...
             0,  0,  0, -1,  1];
%% klasszikus csillapitas:
   kszi = 0.05;         
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sajatertek-feladat megoldasa modalanalizishez
[V,W2] = eigs(K_full,M_full,2,'sa');
W = sqrt(W2);
VT = V.'; 
M = VT*M_full*V;
K = VT*K_full*V;
%a rendszer merete, kulon nem kell megadni
Ndim = size(W,1);
%csillapitasi matrix
C = kszi*(2*M*W);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% tehervektor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% talajgyorsulas
ddUg0=0.5*g; %[g] % amplitudo
%% minden idopillanathoz zerusertekekkel feltoltes:
ddUg = zeros(1,Tstepnum);
%% a vizsgalt idoszak elso feleben harmonikus fuggveny
for j = 1:(Tstepnum/2)
    ddUg(:,j)=ddUg0*sin(2*pi*t(j)); % felulirja a korabbi nullakat
end
%% a tehervektorok szamitasa
q_full = -m*[1;1;1;1;1]*ddUg; % otszabadsagfoku rendszer
q_v = VT*(-m*[1;1;1;1;1]);
q = q_v*ddUg; % ketszabadsagfokura redukalt rendszer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kezdeti feltetelek
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% nincs kezdeti elmozdulas:
   U0(1:Ndim,1) = [0;0];
%% nincs kezdeti sebesseg:
   V0(1:Ndim,1) = [0;0];
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a kezdeti pillanatban a gyorsulas a mozgasegyenlet megoldasabol
A0 = M\(q(:,1)-C*V0-K*U0); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%