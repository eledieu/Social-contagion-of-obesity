function PersonID_x_ChangedStateAtDayX = persons_changed_state( PersonID_x_AboveAtExam )
%persons_changed_state computes for each unique person if they changed
%state with respect to previous day.
%
% OUTPUT:: PersonID_x_ChangedStateAtDayX : Returns a unique_persons by
% first_date_of_mesure_to_last_date_of_mesure matrix with value 1 if the person changed state with respect to previous day and 0 else.
% INPUT::
% PersonID_x_AboveAtExam

[m,n] = size(PersonID_x_AboveAtExam);

P_by_S = zeros(m,n); % is short for PersonID_x_ChangedStateAtDayX
P_by_E = PersonID_x_AboveAtExam;

for i= 1:m
    for j= 2:n
        if P_by_E(i, j-1) ~= P_by_E(i, j)
            P_by_S(i, j) = 1;
    end
end

PersonID_x_ChangedStateAtDayX =  P_by_S;

end
