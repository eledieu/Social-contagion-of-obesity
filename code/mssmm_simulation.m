function [timeSim, sismod, sisamod]=mssmm_simulation(b, g, a, iniVal, tend)
 % Simulate the results of the ode equations of the SIS and the SISa. 
 
 %OUTPUT :: 
 % t column vector of time points
 % sismod matrix containing the results of the simulation of the SIS model
 %(with both numbers of infected and susceptible individuals at each time step)
 % sisamod matrix containing the results of the simulation of the SISa
 % model (with both numbers of infected and susceptible individuals at each
 % time step
 
 %INPUT ::
 % (b, g, a) parameters of the model
 % iniVal : a column vector of dimension 2. iniVal(1) is the number of
 % infected individuals at time t = 0 and iniVal(2) is the number of
 % susceptible individuals at time t = 0 (correspond to the output of the
 % function mssmm_regression_ini)
 % tend : end time of the simulation
 
 function dy = sis(t,y)
    dy = zeros(2,1);    % a column vector
    dy(1) = b*y(1)*y(2) - g*y(1); %y(1) = Number of infected indiduals
    dy(2) = - b*y(1)*y(2)+g*y(1); %y(2) = Number of susceptible individuals
 end
    
 function dy = sisa(t,y)
    dy = zeros(2,1);    % a column vector
    dy(1) = b*y(1)*y(2) - g*y(1)+a*y(2); %y(1) = Number of infected indiduals
    dy(2) = - b*y(1)*y(2)+g*y(1)-a*y(2); %y(2) = Number of susceptible individuals
 end

 options = odeset('RelTol', 1e-4, 'NonNegative', [1 2]);
 
 [sismod] = ode45(@sis, [0 tend], iniVal, options);
 [timeSim, sisamod] = ode45(@sisa, [0 tend], iniVal, options);
    
end
    
