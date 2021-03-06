function  hiszt(X1, YMatrix1)
%HISZT Summary of this function goes here
%   Detailed explanation goes here

% Create figure
figure1 = figure('NumberTitle','off',...
'Name','A 4.1 modális elmozdulásai',...
'Color',[0.800000011920929 0.800000011920929 0.800000011920929]);
 
% Create axes
axes1 = axes('Parent',figure1,'YGrid','on','XGrid','on');
box(axes1,'on');
hold(axes1,'all');
 
% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',axes1);
set(plot1(1),'LineWidth',2.0,'DisplayName','f_s');
% set(plot1(2),'LineWidth',2.0,'DisplayName','U_2');
% set(plot1(2),'LineWidth',0.3,'DisplayName','K^{-1}q(2)');
% set(plot1(4),'LineWidth',0.3,'Color',[0 0.749019622802734 0.749019622802734],...
% 'DisplayName','K^{-1}q(2)');
%set(plot1(157),'DisplayName','57');

%  set(plot1(5),...
% 'Color',[0.501960813999176 0.501960813999176 0.501960813999176]);
 
% Create xlabel
xlabel('U(1) [m]');
 
% Create ylabel
ylabel('f_s [kN]');
 
% Create title

    
% title('Hybrid simulation');
 
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Orientation','horizontal','Location','SouthEast');

end

