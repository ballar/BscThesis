function [ K_T ] = tangent_stiffness( U_akt )
%% erintomerevseg szamitasa az elmozdulasvektor fuggvenyeben
%% bilinearis rugalmas anyag

% globalis valtozok
global  V_jy alpha k
delta_jy = V_jy/k;
% az egyes szintek relatív eltolodasai
delta_l = [U_akt(1); U_akt(2:end) - U_akt(1:end-1)];
% logikai operatorok a kT feltoltesere
m = abs(delta_l) < delta_jy ;
g = ~m;
% az egyes szintek erintomerevsege
kT = m.*(k)+g.*(alpha*k);
% az erintomerevseg matrixa
K_T = [kT(1)+kT(2),      -kT(2),           0,           0,      0;...   
            -kT(2), kT(2)+kT(3),      -kT(3),           0,      0;... 
                 0,      -kT(3), kT(3)+kT(4),      -kT(4),      0;...
                 0,           0,      -kT(4), kT(4)+kT(5), -kT(5);...
                 0,           0,           0,      -kT(5),  kT(5)];

end

