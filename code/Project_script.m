function Project_script(studied_variable,threshold)
    load('mssmm_data.mat')
    [adj_mat,adj_mat_bin,unique_source,unique_target]=mssmm_adj(source,target,source_friendship,date_friendship_can)
    [P]=degree_distribution(adj_mat_bin)
    PersonID_x_AboveAtExam = persons_above( participantID_weight,studied_variable, date_weigth_can,threshold)
    PersonID_x_ChangedStateAtDayX = persons_changed_state( PersonID_x_AboveAtExam )
    [number_of_contacts] = count_obese_contacts(PersonID_x_AboveAtExam, adj_mat_bin)
    change_under=mssmm_regression(PersonID_x_ChangedStateAtDayX(1:90,:), number_of_contacts, sum(adj_mat_bin(:,:,1)),true)
    change_above=mssmm_regression(PersonID_x_ChangedStateAtDayX(1:90,:), number_of_contacts, sum(adj_mat_bin(:,:,1)),false)
    [above b g a] =mssmm_regression_results(change_above, change_under)
end

% First test: studied_variable=BMI, threshold=26
