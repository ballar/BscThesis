function [ f_s ] = resisting_force( U_akt )
%% visszaterto ero szamitasa az elmozdulasvektor fuggvenyeben
%% neminearisan rugalmas anyag

% globalis valtozok
global L H
% anyagmodell parameterei
a = 200;
b = 90;
% globalis es lokalis koordinatarendszer kozotti osszefugges
U_ii = sqrt((L+U_akt(1))^2+H^2)-sqrt(L^2+H^2);
%% lokalis a visszaterito ero
f_s_ii =  a*atan(b*U_ii);
% lokalis es globalis koordinatarendszer kozotti osszefugges
II = (L+U_akt(1))/(sqrt((L+U_akt(1))^2+H^2));
%% globalis a visszaterito ero
f_si = f_s_ii*II;
%% a szerkezet a visszaterito ero vektora 
f_s = [f_si;0];
end

