% main.m
%% Adott linearis feladat megoldasa idolepeses modszerrel
%% NEM MODOSITHATO
%% Verifikalas a 16.4 peldaval[2]

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

%% elmozdulasok szamitasa otszabadsagfokra
U_full = V*U;

%% az eredmenyek kirajzolasa
% modalis elmozdulas-ido diagram elso szintre
createfigure(t, U(1,:), integration_algorithm)
% modalis elmozdulas-ido diagram masodik szintre
creatfig2(t, U(2,:), integration_algorithm)
% talajgyorsulasok az ido fuggvenyeben
createfig_q(t, ddUg, integration_algorithm)
% elmozdulas-ido diagram otszabadsagfoku rendszerre
createfig_U_full(t, U_full, integration_algorithm)

%% eredmenyeket osszefoglalo tablazat keszitese
A = [t.', U.', U_full.'];
createtable(A)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
