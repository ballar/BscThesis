function [ II ] = f_s_lab2num( L, H, U )
%% lokalisbol globalis rendszerbe szamol
II = (L+U(1))/(sqrt((L+U(1))^2+H^2));

end

