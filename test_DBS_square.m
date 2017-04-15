%% test m.file with DBS squarewave

%------------------------------------------------------------------------
%------------------------------------------------------------------------
%% init parameters
%------------------------------------------------------------------------
%------------------------------------------------------------------------

% parameters of functions used init
t_final = 50;
step = 0.01;
k = 1200;
b = 5.5*pi*2;
h = 0.5;

% creation of array to store the results
t = [0:step:t_final];
RKutta = zeros(length(t),5);
Euler = zeros(length(t),5); 

% Computing
RKutta = Parkinson_DBS_square(k,b,h,step,t_final);
Euler = Parkinson_DBS_square_euler(k,b,h,step,t_final);

%------------------------------------------------------------------------
%------------------------------------------------------------------------
%% Plotting
%------------------------------------------------------------------------
%------------------------------------------------------------------------

figure(1) % first figure

subplot(2,1,1) % plot 1

    plot(RKutta(:,4),RKutta(:,5))       % plot Runge Kutta
    hold on
    plot(Euler(:,4),Euler(:,5),'g')     % plot Euler
    title('Y_{dot} against X_{dot}')    % title of the graph
    xlabel('X_{dot}')                   % name of the x label
    ylabel('Y_{dot}')                   % name of the y label
    grid on                             % activation of the grid

subplot(2,1,2) % plot 2

    plot(RKutta(:,2),RKutta(:,4))          % plot Runge Kutta
    hold on
    plot(Euler(:,2),Euler(:,4),'g')        % plot Euler
    title('X_{dot} against X')             % title of the graph
    xlabel('X')                            % name of the x label
    ylabel('X_{dot}')                      % name of the y label
    grid on                                % activation of the grid

    figure(2) % second figure
    
    plot(RKutta(:,2),RKutta(:,3))       % plot Runge Kutta
    hold on
    plot(Euler(:,2),Euler(:,3),'g')     % plot Euler
    title('X against Y')                % title of the graph
    xlabel('Y')                         % name of the x label
    ylabel('X')                         % name of the y label
    grid on                             % activation of the grid
    