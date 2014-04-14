function [ iniVal ] = mssmm_simulation_ini( above, PersonID_x_AboveAtExam)
% Generates the initial conditions of the ode equation set

%OUTPUT :: 
 % iniVal : a column vector of dimension 2. iniVal(1) is the number of
 % infected individuals at time t = 0 and iniVal(2) is the number of
 % susceptible individuals at time t = 0
 
 %INPUT ::
 % above : boolean variable. TRUE if above is the infectious state
 % PersonID_x_AboveAtExam : output of the function persons_above
 
iniVal = zeros(2,1);
if above
    iniVal(1) = sum(PersonID_x_AboveAtExam(:,1), 1);
    iniVal(2) = size(PersonID_x_AboveAtExam,1) - iniVal(1);
else
    iniVal(2) = sum(PersonID_x_AboveAtExam(:,1), 1);
    iniVal(1) = size(PersonID_x_AboveAtExam,1) - iniVal(2);
end

end

