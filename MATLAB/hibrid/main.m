% main.m
%% Adott nemlinearis feladat megoldasa hibrid szimulacioval
%% 6. fejezetben hibrid program bemutatasa

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% biztonsagi torles
clear; 

%% az alapadatok beolvasasa
init_system;
%% elokeszito szamitasok futtatasa, 
% helyfoglalo es segedmatrixok letrehozasa
init_conditions;

%% szamitas idolepesenkent
for i = 1:Tstepnum-1
    
    % numerikus szamitasok konvertalasa a laborba
    convert_num2lab;
    % az aktualis visszateriti ero 'merese', es az eredmenybol
%     az erintomerevseg szamitasa
    labor;
    % laboreredmenyek konvertalasa numerikus szamitashoz
    convert_lab2num;
    % aktualis gyorsulas szamitasa a mozgasegyenletbol
    ddU_akt = CR_M_inv_q(:,i)-CR_M_inv_C*dU_akt...
            - M\(K_akt*U_akt+f_si);
    % elmotdulasok szamitasa CR algorimussal
    timestep;
    
end

%% az eredmenyek kirajzolasa
% elmozdulas-ido diagram es statikus elmozdulasok 
createfig_Kq(t,[U;K\q])
% elmozdulas-ido diagram 
createfigure(t,U)
% teherfuggveny
createfig_q (t,q)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%