function [ upp,tload,input_accel ] = EQ_load(fileToRead)
%%  foldrenges rekord beolvasasa
%Egy, pl a http://www.vibrationdata.com/elcentro.dat
%alapjan elmentett rekordot a vizsgalat alapjaul szolgalo
%gyorsulasokat tartalmazo upp vektorba olvas be es interpolal
global   t  Tstepnum; 

%idopont es gyorsulasertekek beolvasasa:
input_data=importdata(fileToRead,',');
%helyfoglalas a talaj gyorsulasa vektoranak:
upp=zeros(Tstepnum,1);

%a beolvasott adatok idopontjai:
tload=input_data(:,1);
%a beolvasott adatok gyorsulasai:
input_accel=input_data(:,2)*9.81;
%a beolvasott adatsor hossza:
Tload_stepnum=size(input_accel,1);

%Az egyes interpolaciokat mindig a taktual-adik es a kovetkezo
%teherertek (telozo es tkovetkezo) koze interpolaljuk. 
%Ezek kezdeti ertekei:
taktual=1; telozo=tload(taktual);tkovetkezo=tload(taktual+1);
%A vizsgalando tartomanyon minden idopillanatra:
for i= 1: Tstepnum
% - megnezzuk, hogy nem kerultunk-e at a kovetkezo
%   interpolalasi tartomanyba:
    if t(i)>tkovetkezo ;
%     ha igen, akkor az interpolalas also es felso hatarat 
%     eggyel feljebb leptetjuk
      taktual=taktual+1; 
      if (taktual == Tload_stepnum); break; end; 
      % (de csak ha van meg ott teher)
      telozo=tload(taktual);tkovetkezo=tload(taktual+1);
    end;  
% - t_ksi-ben relativ idot merunk az interpolalashoz 
%   (0 az elejen, 1 a vegen):
    t_ksi=(t(i)-telozo)/(tkovetkezo-telozo);
% - es linearisan interpolalunk
    upp(i) = input_accel(taktual)*(1-t_ksi)...
           + input_accel(taktual+1)*t_ksi;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%