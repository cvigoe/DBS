%% test m.file without DBS

%------------------------------------------------------------------------
%------------------------------------------------------------------------
%% init parameters
%------------------------------------------------------------------------
%------------------------------------------------------------------------

% parameters of functions used init
t_final = 1000;
step = 0.001;
h = 0.5;
b = 5.9*2*pi;
k = 1200;
A = 1;

% creation of array to store the results
t = [0:step:t_final];
RKutta = zeros(length(t),5);
Euler = zeros(length(t),5); 

% Computing
RKutta = Parkinson_kutta4(A,k,b,h,step,t_final);
Euler = Parkinson_euler(A,k,b,h,step,t_final);

%------------------------------------------------------------------------
%------------------------------------------------------------------------
%% Plotting
%------------------------------------------------------------------------
%------------------------------------------------------------------------

figure(1) % first figure

subplot(2,1,1) % plot 1

    plot(RKutta(:,4),RKutta(:,5))       % plotting Runge Kutta
    hold on
    plot(Euler(:,4),Euler(:,5),'g')     % plotting Euler
    title('Y_{dot} against X_{dot}')    % title of the graph
    xlabel('X_{dot}')                   % name of the x label
    ylabel('Y_{dot}')                   % name of the y label
    grid on                             % activation of the grid

subplot(2,1,2) % plot 2

    plot(RKutta(:,2),RKutta(:,4))          % plotting Runge Kutta
    hold on
    plot(Euler(:,2),Euler(:,4),'g')        % plotting Euler
    title('X_{dot} against X')             % title of the graph
    xlabel('X')                            % name of the x label
    ylabel('X_{dot}')                      % name of the y label
    grid on                                % activation of the grid

    figure(2) % second figure
    
    plot(RKutta(:,2),RKutta(:,3))       % plotting Runge Kutta
    hold on
    plot(Euler(:,2),Euler(:,3),'g')     % plotting Euler
    title('X against Y')                % title of the graph
    xlabel('Y')                         % name of the x label
    ylabel('X')                         % name of the y label
    grid on                             % activation of the grid

    