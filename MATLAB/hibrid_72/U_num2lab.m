function [ U_lab ] = U_num2lab( L , H , U )
%% globalis renszerbol lokalisba szamitas 

U_lab = (sqrt((L+U(1))^2+H^2)-sqrt(L^2+H^2));

end

