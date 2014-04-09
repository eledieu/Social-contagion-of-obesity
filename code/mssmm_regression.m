function changes =mssmm_regression(persons_changed_states, count_contacts_above, number_contacts, under_to_above)
 % Compute the number of changes from under to above (or under) the threshold value
 % with respect to the number of contacts under (or above) threshold at the time step
 % of the change
 
 %OUTPUT :: A matrix of two columns. The first one corresponds to the number of contacts observed
 % the second one to the percentage of the changes that took place in this particular configuration of contacts
 
 %INPUT ::
 % persons_changed_state : output of the function persons_changed_state
 % (Returns a unique_persons by
 % first_date_of_mesure_to_last_date_of_mesure matrix with absolute value 1
 % if the person changed state with respect to previous day and 0 else.)
 % count_matrix_above : output of the count_matrix function
 % number_contacts : column vector with the total number of contacts of
 % each person
 % under_to_above : boolean value. if TRUE, then changes from under_to_above ; else
 % then compute the changes from state above to state under threshold
 
 n = size(count_contacts_above, 2);
 
 pcs = -persons_changed_states;
 contacts_new_state = count_contacts_above(:,2:n);
 
 if ~(under_to_above)
     pcs = persons_changed_states;
     contacts_new_state = repmat(number_contacts, 1, n-1)-contacts_new_state;
 end

 changes_with_counts = tabulate(uint8(contacts_new_state(pcs>0)));
 changes = changes_with_counts(:,[1 3])
 
    
end
