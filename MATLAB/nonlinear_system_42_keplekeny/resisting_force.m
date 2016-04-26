function [ f_s ] = resisting_force( U_akt )
%% visszaterto ero szamitasa az elmozdulasvektor fuggvenyeben
%% linearisan rugalmas linearisan keplekeny anyag

%% globalis valtozok, az anyagmodell parameterei
global V_jy alpha k
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

%% az egyes szinteken a visszaterito ero        
for ij=1:5
 u_h= u_0 + u_p(ij) /(1-alfap);
 u_n=-u_0 + u_p(ij) /(1-alfap);
 if (u_h < delta_l(ij))  %aktiv keplekeny huzott
 f_r(ij)= kb * ((1-alfap)*u_0 + alfap*delta_l(ij));
 elseif (delta_l(ij) < u_n ) %aktiv keplekeny nyomott
 f_r(ij)= kb * ((alfap-1)*u_0 + alfap*delta_l(ij));
 else  %rugalmas (vagy passziv keplekeny)
 f_r(ij)= kb * (delta_l(ij)-u_p(ij));
 end
end
% a visszaterito ero vektora
f_s = [(-f_r(2:end)+f_r(1:end-1))' ; f_r(end)]; 
    
end

