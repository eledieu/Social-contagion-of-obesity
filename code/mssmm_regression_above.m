function changes_from_under_to_above =mssmm_regression_above(persons_changed_states, count_contacts_above)
 % Compute the number of changes from under to above the threshold value
 % with respect to the number of contacts under threshold at the time step
 % of the change
 
 %OUTPUT :: A column vector of the number of changes. The index of the
 %column vector corresponds to the number of contacts in the new state +1
 
 %INPUT :: 
 % persons_changed_state : output of the function persons_changed_state
 % (Returns a unique_persons by
 % first_date_of_mesure_to_last_date_of_mesure matrix with absolute value 1
 % if the person changed state with respect to previous day and 0 else.)
 % count_matrix_above : output of the count_matrix function
 
 pcs = persons_changed_state;
 contacts_new_state = count_contacts_above;
    
end
    
