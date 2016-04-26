%EQ_load.m - földrengés rekord beolvasása
%
%Egy, pl a http://www.vibrationdata.com/elcentro.dat
%alapján elmentett rekordot a vizsgálat alapjául szolgáló
%gyorsulásokat tartalmazó upp vektorba olvas be és interpolál

%ha csak tesztként ezt a fájlt futtatjuk, akkor nincs dt, t, Tstepnum.
%ilyenkor adjunk meg valamit:
if(~exist("dt","var")) 
      dt=0.01;t=(0:dt:20);Tstepnum=size(t,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%időpont és gyorsulásértékek beolvasása:
input_data=importdata("elcentro.dat",",");
%helyfoglalás a talaj gyorsulása vektorának:
upp=zeros(Tstepnum,1);

%a beolvasott adatok időpontjai:
tload=input_data(:,1);
%a beolvasott adatok gyorsulásai:
input_accel=input_data(:,2)*9.81;
%a beolvasott adatsor hossza:
Tload_stepnum=size(input_accel,1);

%Az egyes interpolációkat mindig a taktual-adik és a következő
%teherérték (telozo és tkovetkezo) közé interpoláljuk. 
%Ezek kezdeti értékei:
taktual=1; telozo=tload(taktual);tkovetkezo=tload(taktual+1);
%A vizsgálandó tartományon minden időpillanatra:
for i= 1: Tstepnum
% - megnézzük, hogy nem kerültünk-e át a következő
%   interpolálási tartományba:
    if t(i)>tkovetkezo ;
%     ha igen, akkor az interpolálás alsó és felső határát eggyel feljebb léptetjük
      taktual=taktual+1; 
      if (tpill==Tload_stepnum); break; end; %de csak ha van még ott teher
      telozo=tload(taktual);tkovetkezo=tload(taktual+1);
    end;  
% - t_ksi-ben relatív időt mérünk az interpoláláshoz (0 az elején, 1 a végén):
    t_ksi=(t(i)-telozo)/(tkovetkezo-telozo);
% - és lineárisan interpolálunk
    upp(i)=input_accel(taktual)*(1-t_ksi)+input_accel(taktual+1)*t_ksi;
end

% plot(tload,input_accel, t,upp)

% Ndim=3; M=[1,0,0;0,2,0;0,0,3]; %peldaul
% q=zeros(Ndim,Tstepnum); iranyvektor=ones(Ndim,1); qtomeg=-M*iranyvektor;
% for i=1:Tstepnum
%     q(:,i)=qtomeg*upp(i);
% end

