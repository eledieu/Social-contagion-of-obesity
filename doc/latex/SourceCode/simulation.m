function [susceptible,infected] = simulation(a,b,g, initial_infect, duration, step)
    % SUMMARY: Simulates the SISa model for the automatic (or spontaneous)
    % infection factor a, the transmission rate b, and the recovery rate g,
    % for an initialy infected percentage of initial_infect, a duration of
    % 'duration' days, with a resolution in the timesteps of step.
    
    % OUTPUT::
            %susceptible vector with the susceptible percentage per timestep
            % infecter vector with the infected percentage per timestep
    % INPUT::
            %parameters: a=spontaneous infection rate; b=transmission rate; g=recovery
            %rate; duration=duration of the simulation; step=time step
            
    dt=step;        % time step, initialise manually here when desired
    d = duration;   % simulated duration, initialise manually here when desired

    % initial condition
    S=100-initial_infect;      % Susceptible egos
    I=initial_infect;   % Infected individualsS
    % book-keeping variable
    index = 0;

    % simulation loop
    for t=1:dt:d+1
        index = index + 1;
        dI = (b*S*I-g*I+a*S)*dt;
        dS = (-b*S*I+g*I-a*S)*dt;
        I = I + dI;
        i(index) = I;
        S = S + dS;
        s(index) = S;
    end
    format short
    x = linspace(1,t,(d/dt)+1);
    plot(x,s)
    grid on
    hold on
    plot(x,i,'o')
    hold off
    infected = i;
    susceptible = s;
end
