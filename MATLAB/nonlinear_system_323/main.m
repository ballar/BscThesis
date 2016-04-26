% main.m
%% Adott nemlinearis feladat megoldasa idolepeses modszerrel
%% NEM MODOSITHATO
%% 3.2.3 feladat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% biztonsagi torles
clear; 

%% az alapadatok beolvasasa
init_system;

%% felugro menu az integralo algoritmus kivalasztasara
integration_algorithm = menu ('Chose an  algorithm, please.',...
    'Central Difference Method',...
    'Newmark Method (acc)',...
    'Newmark Method (disp)',...
    'Exit');

%% integralasi parameterek beolvasasa
integration_parameters;
%% elokeszito szamitasok futtatasa, 
% helyfoglalo es segedmatrixok letrehozasa
init_conditions;

%% szamitas idolepesenkent
for i=1:Tstepnum-1
    
    % elmozdulasok szamitasa es tarolasa
    timestep;
    
end
%% elmozdulasok tarolasa
U_20 = U;

%% tehervektorok modositasa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q = q_10*sin(20*t);

%% elokeszito szamitasok futtatasa, 
% helyfoglalo es segedmatrixok letrehozasa
init_conditions;

%% szamitas idolepesenkent
for i=1:Tstepnum-1
    
    % elmozdulasok szamitasa es tarolasa
    timestep;
    
end
%% elmozdulasok tarolasa
U_10 = U;
 
%% tehervektorok modositasa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q = q_40*sin(20*t);

%% elokeszito szamitasok futtatasa, 
% helyfoglalo es segedmatrixok letrehozasa
init_conditions;

%% szamitas idolepesenkent
for i=1:Tstepnum-1
    
    % elmozdulasok szamitasa es tarolasa
    timestep;
    
end
%% elmozdulasok tarolasa
U_40 = U;
 
%% tehervektorok modositasa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q = q_80*sin(20*t);

%% elokeszito szamitasok futtatasa, 
% helyfoglalo es segedmatrixok letrehozasa
init_conditions;

%% szamitas idolepesenkent
for i=1:Tstepnum-1
    
    % elmozdulasok szamitasa es tarolasa
    timestep;
    
end
%% elmozdulasok tarolasa
U_80 = U;

%% az eredmenyek kirajzolasa
% elmozdulas-ido diagram q_0 = 20 -ra
createfigure(t,U_20, integration_algorithm)
% elmozdulas-ido diagram osszes teherre
createfigure_q_var(t,[U_10(1,:);U_20(1,:);U_40(1,:);U_80(1,:)],...
                    integration_algorithm)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%