clear;

init_system;

integration_algorithm = menu ('Chose an  algorithm, please.',...
    'Euler-Cauchy Method',...
    'Runge-Kutta Method (RK2)',...
    'Central Difference Method',...
    'Newmark Method',...
    'Wilson-theta Method',...
    'HHT-alpha Method',...
    'CR Algorithm',...
    'Exit');

integration_parameters;
init_conditions;

for i=1:Tstepnum-1
    
    timestep;
    
end

mech_en_fig(t,ME,integration_algorithm)

elm_fig(U(1,:),U(2,:),integration_algorithm)%[U;K_q]

 

