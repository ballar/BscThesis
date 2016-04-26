function [ K_T ] = tangent_stiffness( U_akt )
%% erintomerevseg szamitasa az elmozdulasvektor fuggvenyeben
%% nemlinearisan rugalmas anyag

% globalis valtozok
global a b

k_1T = a*b/(1+b^2*U_akt(1)^2);
k_2T = a*b/(1+b^2*(U_akt(2)-U_akt(1))^2);
K_T = [ k_1T+k_2T , -k_2T  ;...
       -k_2T       ,  k_2T ];

end

