function [ f_s ] = resisting_force( U_akt )
%% visszaterto ero szamitasa az elmozdulasvektor fuggvenyeben
%% nemlinearisan rugalmas anyag

% globalis valtozok
global a b

% arcus tanges fuggveny szerint
f_s = [ a*atan(b* U_akt(1)) + a* atan(b* (U_akt(1)-U_akt(2)));...
        a*atan(b*(U_akt(2)-U_akt(1)))  ];
    
end

