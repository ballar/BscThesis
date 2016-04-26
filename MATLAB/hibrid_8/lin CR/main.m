%% main.m

% kommentek 'help main'-hez!!!

clear;

init_system;

integration_algorithm = menu ('Chose an  algorithm, please.',...
    'Euler-Cauchy Method',...
    'Runge-Kutta Method (RK2)',...
    'Central Difference Method',...
    'Newmark`s Method',...
    'Wilson Theta Method',...
    'HHT-alpha Method',...
    'CR Algorithm',...
    'Exit');

integration_parameters;
init_conditions;

for i=1:Tstepnum-1
    
    timestep;
    
end

figure1 = figure;
axes1 = axes('Parent',figure1,'YGrid','on','XGrid','on');
plot(t,U(2,:)-U(1,:),t,K_q(2,:)-K_q(1,:),t,zeros(Tstepnum),'Parent',axes1)

%  plot(t,U(Ndim,:),t,U(Ndim-4,:))

%  plot(t,U(2,:)-U(1,:),t,U(1))
