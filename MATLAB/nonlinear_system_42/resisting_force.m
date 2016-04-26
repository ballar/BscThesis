function [ f_s ] = resisting_force( U_akt )
%% visszaterto ero szamitasa az elmozdulasvektor fuggvenyeben
%% bilinearisan rugalmas anyag

% globalis valtozok
global V_jy alpha k
delta_jy = V_jy/k;
% az egyes szintek reéativ eltolodasa
delta_l = [U_akt(1); U_akt(2:end) - U_akt(1:end-1)];
% logikai operatorok f_r feltoltesere
g = delta_l > delta_jy;
l = delta_l < -delta_jy;
m = ~g & ~l;
% az egyes szinteken a visszaterito erok
f_r = l.*(-V_jy+alpha*k*(delta_l-delta_jy)) + m.*(k*delta_l) ...
    + g.*(V_jy+alpha*k*(delta_l-delta_jy));
% a visszaterito ero vektora
f_s = [-f_r(2:end)+f_r(1:end-1) ; f_r(end)];
    
end

