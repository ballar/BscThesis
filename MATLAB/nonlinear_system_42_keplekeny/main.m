% main.m
%% Adott nemlinearis feladat megoldasa idolepeses modszerrel
%% NEM MODOSITHATO
%% 4.2 verifikalas bilinearis rugalmas anyagmodellel

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

%% az eredmenyek kirajzolasa
% elmozdulas-ido diagram 
createfigure(t,U, integration_algorithm)
% elmozdulas-ido diagram a folso szinten
creatfig2(t, U(5,:), integration_algorithm)

%% osszefoglalo tablazat keszitese
A = [t.', U.'];
createtable(A)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%