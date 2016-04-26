% main.m
%% Adott nemlinearis feladat megoldasa idolepeses modszerrel
%% NEM MODOSITHATO
%% 6. fejezetben hibrid program  verifikalasa 

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
% elmozdulas-ido diagram es statikus elmozdulasok 
createfig_Kq(t,[U;K\q], integration_algorithm)

%% maximumok szamitasa
dl = [U(1,:);U(2,:);U(2,:)-U(1,:)];
dl_max = max([max(dl.');abs(min(dl.'))]);
%% maximumok kiadasa tablazatban
createtable(dl_max.')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%