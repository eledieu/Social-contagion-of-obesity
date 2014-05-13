% function returns a matrix 'number_of_obese_contacts'
% that has the number of obese contacts each person has at every timestep
% weight_over_time: entry (i,j) represents whether person i is obese at
% time j (entry in the matrix is one) or not (entry is zero)
% adj matrix, entry (i,j) represents whether person i knows person j or not
function [number_of_obese_contacts] = count_obese_contacts(weight_over_time, adj_matrix)
    number_of_persons = size(weight_over_time,1);
    time_steps = size(weight_over_time,2);
    number_of_obese_contacts = zeros(number_of_persons, time_steps);
    for i = 1:number_of_persons
        for j = 1:number_of_persons    
            if adj_matrix(i,j)>=1     %check if person i is in relation with person j
                for k = 1:time_steps   % at any time step if person 'j' is obese, increment the number of obese contacts of person 'i' by one at that time step
                    if weight_over_time(j,k)>=1
                        number_of_obese_contacts(i,k) = number_of_obese_contacts(i,k) +1; 
                    end
                end
            end
        end
    end
end
