function [simulation] = simulation(a,b,g)
%parameters: a=spontaneous infection rate; b=transmission rate; g=recovery rate;
dt=0.01;        % time step
d = 20;         % simulated duration

% initial condition
S=100;      % Susceptible egos
I=20;   % Infected individualsS
% book-keeping variable
index = 0;

% simulation loop
for t=0:dt:d
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
hold on

