clc,clear,close;
load data.mat;

x = finor(:,3);y=finor(:,2);z=finor(:,4);


[xData, yData, zData] = prepareSurfaceData( x, y, z );

% Set up fittype and options.
ft = 'linearinterp';

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

% Plot fit with data.
figure
subplot(2,1,1)
h=plot( fitresult, [xData, yData], zData );
legend(h,'untitled fit 1', 'z vs. x, y', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
zlabel z
grid on

subplot(2,1,2)
h=plot( fitresult, [xData, yData], zData );
legend(h,'untitled fit 1', 'z vs. x, y', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
zlabel z
grid on
