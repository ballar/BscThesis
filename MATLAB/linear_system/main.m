% main.m
%% Adott linearis feladat megoldasa idolepeses modszerrel
%% NEM MODOSITHATO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% biztonsagi torles
clear; 

%% az alapadatok beolvasasa
init_system;

%% felugro menu az integralo algoritmus kivalasztasara
integration_algorithm = menu ('Chose an  algorithm, please.',...
    'Euler-Cauchy Method',...
    'Runge-Kutta Method (RK2)',...
    'Central Difference Method',...
    'Newmark`s Method',...
    'Wilson Theta Method',...
    'HHT-alpha Method',...
    'CR Algorithm',...
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

%% az eredmenyek kirajzolasa
% elmozdulas-ido diagram a statikus elmozdulasokkal
plot(t,U,t,K_q,t,zeros(Tstepnum))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%