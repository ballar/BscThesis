function [ K_T ] = tangent_stiffness( U_akt )
%% erintomerevseg szamitasa az elmozdulasvektor fuggvenyeben
%% linearisan rugalmas linearisan keplekeny anyag

%% globalis valtozok, az anyagmodell parameterei
global  V_jy alpha k
delta_jy = V_jy/k;
global mat_param;

kb  =mat_param(1);%: kb rugalmas merevseg
alfap=mat_param(2);%: aktiv keplekeny merevseg
%                     es rugalmas merevseg aranya
u_0 =mat_param(3);%: u_0 (elso folyas)
u_p(1) =mat_param(4);%: u_p pillanatnyi keplekeny alakvaltozas
u_p(2) =mat_param(5);%: u_p pillanatnyi keplekeny alakvaltozas
u_p(3) =mat_param(6);%: u_p pillanatnyi keplekeny alakvaltozas
u_p(4) =mat_param(7);%: u_p pillanatnyi keplekeny alakvaltozas
u_p(5) =mat_param(8);%: u_p pillanatnyi keplekeny alakvaltozas

%% az egyes szintek relativ eltolodasai
delta_l = [U_akt(1); U_akt(2:end) - U_akt(1:end-1)];

K_temp=    [ 2 ,-1 , 0 , 0 , 0;...
            -1 , 2 ,-1 , 0 , 0;...
             0 ,-1 , 2 ,-1 , 0;...
             0 , 0 ,-1 , 2 ,-1;...
             0 , 0 , 0 ,-1 , 1];
%% keplekeny allapotban u_p es K_temp frissitese         
ij=1;
 u_h= u_0 + u_p(ij) /(1-alfap);
 u_n=-u_0 + u_p(ij) /(1-alfap);
 if (u_h < delta_l(ij))  %aktiv keplekeny huzott
 fs= kb * ((1-alfap)*u_0 + alfap*delta_l(ij));
 mat_param(ij+3)=delta_l(ij)-fs/kb;
 K_temp(1,1)=K_temp(1,1)-1+alfap;
 elseif (delta_l(ij) < u_n ) %aktiv keplekeny nyomott
 fs= kb * ((alfap-1)*u_0 + alfap*delta_l(ij));
 mat_param(ij+3)=delta_l(ij)-fs/kb;
 K_temp(1,1)=K_temp(1,1)-1+alfap;
 else  %rugalmas (vagy passziv keplekeny)
 end
 
for ij=2:5
 u_h= u_0 + u_p(ij) /(1-alfap);
 u_n=-u_0 + u_p(ij) /(1-alfap);
 if (u_h < delta_l(ij))  %aktiv keplekeny huzott
 fs= kb * ((1-alfap)*u_0 + alfap*delta_l(ij));
 mat_param(ij+3)=delta_l(ij)-fs/kb;
 K_temp(ij-1:ij,ij-1:ij)=K_temp(ij-1:ij,ij-1:ij)...
                        -(1-alfap)*[1,-1;-1,1];
 elseif (delta_l(ij) < u_n ) %aktiv keplekeny nyomott
 fs= kb * ((alfap-1)*u_0 + alfap*delta_l(ij));
 mat_param(ij+3)=delta_l(ij)-fs/kb;
 K_temp(ij-1:ij,ij-1:ij)=K_temp(ij-1:ij,ij-1:ij)...
                        -(1-alfap)*[1,-1;-1,1];
 else  %rugalmas (vagy passziv keplekeny)
 end
end

%% az erintomerevseg matrixa
K_T = kb*K_temp;

end

