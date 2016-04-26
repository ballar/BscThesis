% main.m
%% Adott linearis feladat megoldasa idolepeses modszerrel
%% NEM MODOSITHATO
%% Fix megtamasztasu epulet

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
% elmozdulas-ido diagram az elso szinten
creatfig2(t,U(1,:), integration_algorithm)%;K_q(1,:)]
% elmozdulas-ido diagram tetoszinten
createfig5(t,U(5,:), integration_algorithm)%;K_q(5,:)]

%% eredmenyek osszefoglalasa tablazatban
% maximalis elmozdulasok szamitasa
dl = [U(1,:);U(1,:);U(5,:);k*U(1,:)];
dl_max = max([max(dl.');abs(min(dl.'))]);
% tablazat kiadasa
createtable(dl_max.')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%