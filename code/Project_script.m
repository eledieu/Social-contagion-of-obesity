%function Project_script(studied_variable,threshold)
	load('DATA.mat')
    prompt = 'What variable do you want to study? Type BMI or body_fat  ';
    studied_variable = input(prompt);
    prompt = 'Choose a meaningful threshold for the variable:';
    threshold = input(prompt);
    % Generate adjancency matrix of subjects
    [adj_mat,adj_mat_bin,unique_source,unique_target] = mssmm_adj(participantID_weight,participantID_weight,source_friendship,date_friendship_can);
    % Degree distibution in the network
    [contacts,avg_degree] = degree_distribution(adj_mat_bin);
    disp(avg_degree);
    % Is the ego above the threshold at the exam:
    PersonID_x_AboveAtExam = persons_above( participantID_weight,studied_variable, date_weigth_can,threshold);
	%Plots the evolution of the number of person above figure
    plot(sum(PersonID_x_AboveAtExam)/size(PersonID_x_AboveAtExam,1))
	% When did a transition from one state to the next happen and which way:
    PersonID_x_ChangedStateAtDayX = persons_changed_state( PersonID_x_AboveAtExam );
    %Plots the evolution of the number of person above
    figure
    plot(sum(PersonID_x_AboveAtExam)/size(PersonID_x_AboveAtExam,1))
    % Number of contacts above the threshold at the exam:
    [number_of_contacts] = count_obese_contacts(PersonID_x_AboveAtExam, adj_mat_bin);
    % Percentage of total transitions happening given a count of contacts
    % above the threshold:
    change_under = mssmm_regression(PersonID_x_ChangedStateAtDayX, number_of_contacts, sum(adj_mat_bin(:,:,1)),true)
    change_above = mssmm_regression(PersonID_x_ChangedStateAtDayX, number_of_contacts, sum(adj_mat_bin(:,:,1)),false)
    % regression on the parameters
    [above b g a] = mssmm_regression_results(change_above, change_under)
    % plot regression results
    figure(1);
    plot(change_above(:,1),change_above(:,2))
    hold on;
    x = change_above(:,1);
    y = b*x+a;
    plot(x,y*100,'o');
    hold off;
    initial_infected = sum(PersonID_x_AboveAtExam(:,1)) * (100 / size(PersonID_x_AboveAtExam,1));
    figure(2);
    [susceptible,infected] = simulation(a,b,g, initial_infected, size(PersonID_x_AboveAtExam,2), 0.01);
%end

% First test: studied_variable=BMI, threshold=26: slight correlation,
% ~stable state at 75% infected
% Second test: studied_variable=body_fat, threshold=25: apparent negative correlation,
% ~stable state at 15% infected
% Third test: studied_variable=BMI, threshold=25: some correlation,
% ~stable state at 90% infected
% Fourth test: studied_variable=body_fat, threshold=25: apparent negative correlation,
% ~stable state at 12% infected
