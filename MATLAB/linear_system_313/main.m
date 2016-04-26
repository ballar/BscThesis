% main.m
%% Adott linearis feladat megoldasa idolepeses modszerrel
%% NEM MODOSITHATO
%% 3.1.3 szabadrezgeses feladat

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

%% mechanikai energia helyfoglalo matrixa
ME = zeros(1,Tstepnum);

%% szamitas idolepesenkent
for i=1:Tstepnum-1
    
    % elmozdulasok szamitasa es tarolasa
    timestep;
    
    % mechanikai energia szamitasa
    ME(i) = 1/2*(U(:,i).'*K*U(:,i))+1/2*(dU(:,i).'*M*dU(:,i));
    
end

% mechanikai energia az utolso pillanatban
ME(Tstepnum) = 1/2*(U(:,Tstepnum).'*K*U(:,Tstepnum))+1/2*(dU(:,Tstepnum).'*M*dU(:,Tstepnum));

%% az eredmenyek kirajzolasa
% elmozdulas-ido diagram 
createfigure(t,U,integration_algorithm)
% elmozdulas-ido diagram a statikus elmozdulasokkal
creatfig_Kq(t,[U;K_q],integration_algorithm)
% mechanikai energia ido fuggvenyeben
mech_en_fig(t,ME,integration_algorithm)
% elmozdulasok fazisterben
elm_fig(U(1,:),U(2,:),integration_algorithm)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%