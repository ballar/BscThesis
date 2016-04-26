%% convert_num2lab.m
%% a numerikus szamitasok eredmenyeinek konvertalasa a laborba

% az elozo tarolasa
U_lab_prev = U_lab;
% az aktualis konvertalasa
U_lab = U_num2lab( L , H , U_akt );
