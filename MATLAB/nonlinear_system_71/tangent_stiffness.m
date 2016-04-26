function [ K_T ] = tangent_stiffness( U_akt, U_prev )
%% visszaterto ero szamitasa az elmozdulasvektor fuggvenyeben
%% nemlinearisan rugalmas anyag

% globalis valtozok
global k_n L H K

%% elmozdulasok kulonbsege
deltaU = U_akt(1)-U_prev(1);
%% visszaterito ero valtozasa
f_s_akt  = resisting_force( U_akt );
f_s_prev  = resisting_force( U_prev );
%% erintomerevseg
% A tul kicsit deltaU esetleg numerikusan elronthatja a szamitast,
% ezert nem engedjuk meg, hogy a "mert" merevseg nagyobb legyen 
% a maximalis kezdetinel.
k_ti = min(k_n*L^2/(L^2+H^2),(f_s_akt(1)-f_s_prev(1))/deltaU);
%% az erintomerevseg matrixa
K_T = K+[ k_ti , 0 ;...
             0 , 0  ];

end

