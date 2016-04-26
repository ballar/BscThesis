function [ f_s ] = resisting_force( U_akt )
%% visszaterto ero szamitasa az elmozdulasvektor fuggvenyeben
%%  linearisan rugalmas-linearisan felkemenyedo keplekeny anyag

global mat_param;
 kb  =mat_param(1);%: kb rugalmas merevseg
alfap=mat_param(2);%: aktiv keplekeny merevseg 
%                     es rugalmas merevseg aranya
 u_0 =mat_param(3);%: u_0 (elso folyas)
 u_p =mat_param(4);%: u_p pillanatnyi keplekeny alakvaltozas

u_h= u_0 + u_p /(1-alfap);
u_n=-u_0 + u_p /(1-alfap);
%% a visszaterito ero szamitasa es keplekeny esetben 
%  az u_p frissitese
if (u_h < U_akt(1))  %aktiv keplekeny huzott
fs= kb * ((1-alfap)*u_0 + alfap*U_akt(1));
mat_param(4)=U_akt(1)-fs/kb;
elseif (U_akt(1) < u_n ) %aktiv keplekeny nyomott
fs= kb * ((alfap-1)*u_0 + alfap*U_akt(1));
mat_param(4)=U_akt(1)-fs/kb;
else  %rugalmas (vagy passziv keplekeny)
fs= kb * (U_akt(1)-u_p);
end

f_s= fs ;

end

