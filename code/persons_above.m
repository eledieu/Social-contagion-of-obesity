function PersonID_x_AboveAtExam = persons_above( persons, vector_mesure, date_mesure, treshhold)
%persons_above computes for each unique person if they are above the
%treshhold at a given day.
%
% OUTPUT:: PersonID_x_AboveAtExam : Returns a unique_persons by
% first_date_of_mesure_to_last_date_of_mesure matrix with value 1 if above
% the treshhold and 0 else.
% INPUT::
% persons: a vector of cells of personID strings,
% vector_mesure: a vector of numeric values, where value at row x
% corresponds to person at row x.
% date_mesure: a vector of dates in integer form, where value at row x
% corresponds to mesure at row x.
% treshhold: a treshhold above which the state is 1.

egos = unique(persons); % different persons
duration = max(date_mesure)-min(date_mesure) + 1; % Time elapsed from first mesurement (inclusive) to last mesurement (inclusive)
date_mesure = date_mesure - min(date_mesure) + 1; % normalize date_weight

aboveTreshhold = vector_mesure; % we will directly overwrite the values in two passes
aboveTreshhold(aboveTreshhold <= treshhold) = 0; % binary matrix: 0 -> weight below treshhold at this date for this person
aboveTreshhold(aboveTreshhold > treshhold) = 1; % binary matrix: 1 -> weight above or equal treshhold at this date for this person

PersonID_x_AboveAtExam = zeros(length(egos),duration); % make empty

for i= 1:length(egos)
    person_indexes = find(ismember(persons,egos(i)));
    
    mesure_dates_of_this_person = date_mesure(person_indexes); % We need the indexes corresponding to a person sorted by date, in order to compute the final matrix in one pass per person.
    mesure_indexes_sorted_by_mesure_date = [mesure_dates_of_this_person, person_indexes]; % Prepend date vector to index vector
    mesure_indexes_sorted_by_mesure_date = sortrows(mesure_indexes_sorted_by_mesure_date); % Sort after date vector
    mesure_indexes_sorted_by_mesure_date = mesure_indexes_sorted_by_mesure_date(:,2); % extract sorted index vector
    mbd = mesure_indexes_sorted_by_mesure_date;
    % fill from first date up to first mesure with value of first mesure
    PersonID_x_AboveAtExam(i,1:date_mesure(mbd(1))-1) = aboveTreshhold(mbd(1));
    previous_mesure_date = date_mesure(mbd(1)); % set date of previous mesure
    for j= 2:length(mbd)
        % fill from previous date to current mesure date -1 with value of previous mesure
        PersonID_x_AboveAtExam(i,previous_mesure_date:date_mesure(mbd(j))-1) = aboveTreshhold(mbd(j-1));
        previous_mesure_date = date_mesure(mbd(j));
    end
    % fill from last date of mesure to last date with value of last mesure
    PersonID_x_AboveAtExam(i,previous_mesure_date:end) = aboveTreshhold(mbd(length(mbd)));
end

end
