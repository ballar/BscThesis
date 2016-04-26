function createfig_q (X1, YMatrix1, integration_algorithm)
%CREATEFIG_Q (X1,YMATRIX1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data
 
%  Auto-generated by MATLAB on 03-Apr-2014 22:37:42
 
% Create figure
figure1 = figure('NumberTitle','off',...
'Name','A 4.1 gyorsulás',...
'Color',[0.800000011920929 0.800000011920929 0.800000011920929]);
 
% Create axes
axes1 = axes('Parent',figure1,'YGrid','on','XGrid','on');
box(axes1,'on');
hold(axes1,'all');
 
% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',axes1);
set(plot1(1),'LineWidth',2.0,'DisplayName','\ddUg');
% set(plot1(2),'LineWidth',2.0,'DisplayName','q(2)');
% set(plot1(3),'LineWidth',0.3,'DisplayName','K^{-1}q(1)');
% set(plot1(4),'LineWidth',0.3,'Color',[0 0.749019622802734 0.749019622802734],...
% 'DisplayName','K^{-1}q(2)');
%set(plot1(157),'DisplayName','57');

%  set(plot1(5),...
% 'Color',[0.501960813999176 0.501960813999176 0.501960813999176]);
 
% Create xlabel
xlabel('t [sec]');
 
% Create ylabel
ylabel('ddUg [in/s^2]');
 
% Create title
if     integration_algorithm == 1; tit = 'Euler-Cauchy Method';
elseif integration_algorithm == 2; tit = 'Runge-Kutta Method (RK2)';
elseif integration_algorithm == 3; tit = 'Central Difference Method';
elseif integration_algorithm == 4; tit = 'Newmark Method';
elseif integration_algorithm == 5; tit = 'Wilson-\theta Method';
elseif integration_algorithm == 6; tit = 'HHT-\alpha Method';
elseif integration_algorithm == 7; tit = 'CR Algorithm';
else
end
    
title(tit);
 
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Orientation','horizontal','Location','SouthEast');



end

