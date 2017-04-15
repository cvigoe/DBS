%% Animation Script
% Author: Conor Igoe
% Note: this script assumes that the 'untreated' matrix exists for comparison

%% Movie Setup
n_frames = 1000;

% Variable to store frames of movie; counter for collecting frames
M(n_frames) = struct('cdata',[],'colormap',[]);
j = 1;


%% Parameters
% System parameters
k = 1200;
b = 10*pi;
h = 0.2;
step = 0.001;
t_final = 10000;
t = 0:step:t_final;

% Wave parameters
freq = b/(6000*pi);
amp = 1000;
phase = pi/2;

% Flag for squarewave
squarewave = false;

%% Simulation
if squarewave == true
    wave = amp*square(2*pi*freq*t + phase);
    simulation = Parkinson_DBS_square(k, b, h, step, t_final);
else
    wave = amp*sin(2*pi*freq*t + phase);
    simulation = Parkinson_DBS_sine(k, b, h, step, t_final);
end

%% Figure Setup
close all
fig = figure('units','normalized','position',[1 1 1 1]);

pos1 = [0.05 0.1 0.3 0.8];
subplot('Position', pos1)

pos2 = [0.4 0.1 0.55 0.8];
subplot('Position', pos2)

%% Animation - change commenting for axis inversion
for i = linspace(1,(length(simulation(:,1))-1), n_frames)
    drawnow
    clf
    
    % ---------------------------------------------
    % Subplot 1
    subplot('Position', pos1)

    % plot(simulation(1:floor(i),2),simulation(1:floor(i),3), 'LineWidth', 4);
    plot(simulation(1:floor(i),3),simulation(1:floor(i),2), 'LineWidth', 4);
    
    hold on
    
    X = linspace(-40, 40, 8000);
    Y = 2*10*pi*X - (2/pi)*1200*atan(X/0.2);
    Y1 = linspace(-2000,2000,4000);
    X1 = (Y1./Y1)*(wave(floor(i))/(100*pi*pi));
    equilibrium_x = (wave(floor(i))/(100*pi*pi));
    equilibrium_y = 2*10*pi*equilibrium_x - (2/pi)*1200*atan(equilibrium_x/0.2);
    [x,y] = meshgrid(-40:5:40, -2000:250:2000);
    u = y - 2*b*x + (2/pi)*(k)*(atan(x./h));
    v = -b*b*x + wave(floor(i));    

    % plot(X,Y, 'LineWidth', 4)
    plot(Y,X, 'LineWidth', 4)
    % plot(X1, Y1, 'LineWidth', 4)
    plot(Y1, X1, 'LineWidth', 4)
    % quiver(x,y,u,v,'ShowArrowHead', 'off')
    quiver(y,x,v,u,'ShowArrowHead', 'off')
    % plot(untreated(:,2),untreated(:,3), 'LineWidth', 1)
    plot(untreated(:,3),untreated(:,2), 'LineWidth', 1)
    % plot(equilibrium_x, equilibrium_y, 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 15, 'LineStyle', 'None')
    % plot(equilibrium_x, equilibrium_y, 'ow', 'MarkerFaceColor', 'w', 'MarkerSize', 10, 'LineStyle', 'None')
    plot(equilibrium_y, equilibrium_x, 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 15, 'LineStyle', 'None')
    plot(equilibrium_y, equilibrium_x, 'ow', 'MarkerFaceColor', 'w', 'MarkerSize', 10, 'LineStyle', 'None')
    % plot(simulation(floor(i),2),simulation(floor(i),3), 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 15)
    plot(simulation(floor(i),3),simulation(floor(i),2), 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 15)

    % Annotations & plot settings
    mTextBox = uicontrol('style','text');
    set(mTextBox,'String',string('time = ') + sprintf('%0.2f', (i)*(0.001)), 'FontWeight', 'bold', 'FontSize', 14.0, 'InnerPosition', [100 0 100 30], 'HorizontalAlignment', 'left')    
    AX=legend('Trajectory in phase space', 'x_{dot} nullcline', 'y_{dot} nullcline', '"Velocity" Vector Field', 'Autonomous Limit Cycle');
    set(AX,'FontSize',9)
    set(AX,'FontWeight','bold')
    % xlabel('x','FontSize', 14, 'FontWeight', 'bold')
    % ylabel('y','FontSize', 14, 'FontWeight', 'bold')
    xlabel('y','FontSize', 14, 'FontWeight', 'bold')
    ylabel('x','FontSize', 14, 'FontWeight', 'bold')
    % axis([-40 40 -2000 2000])
    axis([-2000 2000 -40 40])

    % ---------------------------------------------
    % Subplot 2
    subplot('Position', pos2)

    plot(untreated(:,1),untreated(:,2), 'LineWidth', 4, 'Color', [0.8500, 0.3250, 0.0980]);

    hold on

    plot(simulation(1:floor(i),1),simulation(1:floor(i),2), 'LineWidth', 4, 'Color', [0,0.4470,0.7410]);
    plot(simulation(floor(i),1),simulation(floor(i),2), 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 15);
    
    % Annotations & plot settings
    mTextBox = uicontrol('style','text');
    set(mTextBox,'String',string('time = ') + sprintf('%0.2f', (i)*(0.001)), 'FontWeight', 'bold', 'FontSize', 14.0, 'InnerPosition', [100 -25 100 50], 'HorizontalAlignment', 'left')
    AX=legend('Autonomous', 'Sinusoidal f_{DBS}(t)');
    set(AX,'FontSize', 9);
    set(AX,'FontWeight','bold');
    axis([0 t_final -40 40])
    xlabel('t','FontSize', 14, 'FontWeight', 'bold');
    ylabel('x','FontSize', 14, 'FontWeight', 'bold');

    % ---------------------------------------------
    % Get movie frame
    M(j) = getframe(fig);
    j = j + 1;
end