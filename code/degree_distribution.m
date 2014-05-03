function [contacts,avg_degree]=degree_distribution(adj_mat_bin)
    %% Returns the degree distribution (distribution of contact numbers) of the network at each time
    
    % Input:
            % Binary adjacency matrix: 1 if person are close friends and 0
            % otherwise
    % Ouput:
            % number_of_contacts matrix with the number of contacts of each person at the
            % each time
            % The plots displays the degree distribution histogram
            
    date=size(adj_mat_bin,3); % number of date
    len_source=size(adj_mat_bin,1); % number of persons
    
    contacts=zeros(len_source,date);
    avg_degree=zeros(date,1);
    
    for t=1:date
        for k=1:len_source
            contacts(k,t)=sum(adj_mat_bin(k,:,t)); % Number of close friends of person k at time t 
        end

        total_contacts=sum(contacts(:,t));
          
        % figure,

        % bar(1:max(number_of_contacts(:,t)),1/total_contacts*histc(number_of_contacts(:,t),1:max(number_of_contacts(:,t))),'histc')% Histogram of degree distribution
        
        % figure,
        
        avg_degree(t,1)=total_contacts/len_source;
        % hist(number_of_contacts(:,t))% Histogram of degree distribution
        % xlabel('Number of close friends')
        % ylabel('Close friends frequency')
        % title(['Close friends distribution t=',num2str(t)],'FontSize',10,'fontweight','bold')
        
    end
 
end