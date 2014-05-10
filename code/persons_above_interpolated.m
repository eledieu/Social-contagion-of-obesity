function PersonID_x_AboveAtExam = persons_above_interpolated( persons, vector_mesure, date_mesure, threshold)
%persons_above computes for each unique person if they are above the
%threshold at a given day.
%
% OUTPUT:: PersonID_x_AboveAtExam : Returns a unique_persons by
% first_date_of_mesure_to_last_date_of_mesure matrix with value 1 if above
% the threshold and 0 else.
% INPUT::
% persons: a vector of cells of personID strings,
% vector_mesure: a vector of numeric values, where value at row x
% corresponds to person at row x.
% date_mesure: a vector of dates in integer form, where value at row x
% corresponds to mesure at row x.
% threshold: a threshold above which the state is 1.

egos = unique(persons); % different persons
duration = max(date_mesure)-min(date_mesure) + 1; % Time elapsed from first mesurement (inclusive) to last mesurement (inclusive)
date_mesure = date_mesure - min(date_mesure) + 1; % normalize date_weight

PersonID_x_AboveAtExam = zeros(length(egos),duration); % make empty

warning('off', 'MATLAB:polyfit:RepeatedPointsOrRescale'); % temporarly turn off those warnings about badly conditioned polynomials, should discuss what to do about it

for i= 1:length(egos)
    personInd = find(ismember(persons,egos(i))); % personInd = person indexes
    
    mesureDateEgo = date_mesure(personInd); % We need the indexes corresponding to a person sorted by date, in order to compute the final matrix in one pass per person.
    dates_mesures = [mesureDateEgo, personInd]; % Prepend date vector to index vector
    dates_mesures = sortrows(dates_mesures); % Sort after date vector
    mbd = dates_mesures(:,2); % extract sorted by date index vector of the mesures i.e. MesuresByDate
    
    person_mesures = vector_mesure(mbd); % all the mesures of an ego
    p = polyfit(mesureDateEgo,person_mesures,length(mesureDateEgo)-1);
    x = 1:duration;
    y = polyval(p,x);
    
    
    y(y <= threshold) = 0; % binary matrix: 0 -> weight below threshold at this date for this person
    y(y > threshold) = 1; % binary matrix: 1 -> weight above or equal threshold at this date for this person
    PersonID_x_AboveAtExam(i,:) = y;
end

end
