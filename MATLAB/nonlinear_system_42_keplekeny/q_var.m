clear;

init_system;
q = [10;10]*sin(20*t);

integration_algorithm = 3;

integration_parameters;
init_conditions;

for i=1:Tstepnum-1
    
    timestep;
    
end
 U_10 = U;
 
q = [20;20]*sin(20*t);

init_conditions;

for i=1:Tstepnum-1
    
    timestep;
    
end
 U_20 = U;
 
  q = [40;40]*sin(20*t);

init_conditions;

for i=1:Tstepnum-1
    
    timestep;
    
end
 U_40 = U;
 
  q = [80;80]*sin(20*t);

init_conditions;

for i=1:Tstepnum-1
    
    timestep;
    
end
 U_80 = U;
 

%plot(t,U,t,K_q,t,zeros(Tstepnum))
%createfigure(t,[U;K_q], integration_algorithm)
createfigure_q_var(t,[U_10(1,:);U_20(1,:);U_40(1,:);U_80(1,:)], integration_algorithm)
