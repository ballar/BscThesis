%% labor.m

% az elozo visszaterito ero tarolasa
f_s_prev = f_si_lab;
% az utolso elotti terheleslepcso elmozdulasanak szamitasa
U_imintau = U_lab_prev+(U_lab-U_lab_prev)*(1-tau);
% az utolso elotti terheleslepcsonel a visszaterito ero
f_s_imintau = resisting_force(U_imintau);
% extrapolalas az utolso terheleslepcsore
f_si_lab = f_s_prev+(f_s_imintau-f_s_prev)*1/(1-tau);  
% elmozdulasok kulonbsege
deltaU_lab = U_lab-U_lab_prev;
%% erintomerevseg
% A túl kicsit deltaU esetleg numerikusan elronthatja a számítást,
% ezért nem engedjük meg, hogy a "mért" merevség nagyobb legyen 
% a maximális kezdetinél.
epsilon_u = 0.0000001;
if abs(deltaU_lab) >= epsilon_u
    k_ti_lab = min(kb,(f_si_lab-f_s_prev)/deltaU_lab);
end
