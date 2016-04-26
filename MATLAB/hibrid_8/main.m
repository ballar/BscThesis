% main.m
%% Adott nemlinearis feladat megoldasa hibrid szimulacioval
%% NEM MODOSITHATO
%% Keplekeny szeizmikus szigetelés

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% biztonsagi torles
clear; 

%% az alapadatok beolvasasa
init_system;
%% elokeszito szamitasok futtatasa, 
% helyfoglalo es segedmatrixok letrehozasa
init_conditions;
% visszaterito ero helyfoglalo matrixa hizsterezisgorbehez
f_s_ = zeros(1, Tstepnum);

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
    % visszaterito szamitasa hiszterezisgorbehez
    f_s_(:,i) = f_si_lab;
    
end

%% az eredmenyek kirajzolasa

% elmozdulas-ido diagram az elso szinten
creatfig2(t,U(1,:))
% elmozdulas-ido diagram tetoszinten
createfig5(t,U(6,:))
% elmozdulas-ido diagram a statikus elmozdulasokkal
createfig_Kq(t,U(2,:)-U(1,:))

%% eredmenyek osszefoglalasa tablazatban
% maximalis elmozdulasok szamitasa
dl = [U(2,:)-U(1,:);U(2,:);U(6,:);k*(U(2,:)-U(1,:))];
dl_max = max([max(dl.');abs(min(dl.'))]);
% tablazat kiadasa
createtable(dl_max.')

%% hiszterezis gorbe kirajzolasa
hiszt(U(1,1:end-1),f_s_(1:end-1))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%