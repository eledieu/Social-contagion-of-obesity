function [P]=degree_distribution(adj_mat_bin)
    %% Returns the degree distribution (distribution of contact numbers) of the network at each time
    % Input:
            % Binary adjacency matrix: 1 if person are close friends and 0
            % otherwise
    % Ouput:
            % P matrix with the number of contacts of each person at the
            % each time
            % The plots displays the degree distribution histogram
            
    date=size(adj_mat_bin,3); % number of date
    len_source=size(adj_mat_bin,1); % number of persons
    
    P=zeros(len_source,date);
    
    for t=1:date
        for k=1:len_source
            P(k,t)=sum(adj_mat_bin(k,:,t)); % Number of close friends of person k at time t 
        end
        figure,
        hist(P(:,t)); % Histogram of degree distribution
        title(['Degree distribution t=',num2str(t)],'FontSize',10,'fontweight','bold')
    end
 
end