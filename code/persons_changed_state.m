function PersonID_x_ChangedStateAtDayX = persons_changed_state( PersonID_x_AboveAtExam )
%persons_changed_state computes for each unique person if they changed
%state with respect to previous day.
%
% OUTPUT:: PersonID_x_ChangedStateAtDayX : Returns a unique_persons by
% first_date_of_mesure_to_last_date_of_mesure matrix with value 1 if the person didn't changed state with respect to previous day.
% If the person state changed from under the threshold to above the
% threshold on the next day, the value is -1.
% If the person state changed from above the threshold to under the
% threshold on the next day, the value is 1.
% INPUT::
% PersonID_x_AboveAtExam

[m,n] = size(PersonID_x_AboveAtExam);

PersonID_x_ChangedStateAtDayX =  [[0,PersonID_x_AboveAtExam(2;n)] - [0,PersonID_x_AboveAtExam(1:n-1)]];

end
