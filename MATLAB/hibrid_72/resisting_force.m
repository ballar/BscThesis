function [ f_s ] = resisting_force( U_akt )
%% visszaterto ero szamitasa az elmozdulasvektor fuggvenyeben
%% neminearisan rugalmas anyag

% anyagmodell parameterei
a = 200;
b = 90;

%% visszaterito ero
f_s =  a*atan(b* U_akt(1)); 
       
    
end

