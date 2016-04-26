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
% A t�l kicsit deltaU esetleg numerikusan elronthatja a sz�m�t�st,
% ez�rt nem engedj�k meg, hogy a "m�rt" merevs�g nagyobb legyen 
% a maxim�lis kezdetin�l.
epsilon_u = 0.0000001;
if abs(deltaU_lab) >= epsilon_u
    k_ti_lab = min(kb,(f_si_lab-f_s_prev)/deltaU_lab);
end
