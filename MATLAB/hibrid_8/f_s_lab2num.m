function [ II ] = f_s_lab2num( L, H, U )
%F_S_LAB2NUM Summary of this function goes here
%   Detailed explanation goes here

II = (L+U(1))/(sqrt((L+U(1))^2+H^2));

end

