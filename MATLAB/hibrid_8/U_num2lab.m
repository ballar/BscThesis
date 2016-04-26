function [ U_lab ] = U_num2lab( L , H , U )
%U_NUM2LAB Summary of this function goes here
%   Detailed explanation goes here

U_lab = (sqrt((L+U(1))^2+H^2)-sqrt(L^2+H^2))/(sqrt(L^2+H^2));

end

