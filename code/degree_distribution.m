function [P]=degree_distribution(adj_mat)
    %% Returns the degree distribution (distribution of contact numbers) of the network at each time
    
    date=size(adj_mat,3); % number of date
    len_source=size(adj_mat,1); % number of persons
    
    P=zeros(len_source,date);
    
    for t=1:size(adj_mat,3)
        for k=1:len_source
            P(k,t)=sum(adj_mat(k,:,t)); % Number of contacts of person k at time t 
        end
        figure,
        hist(P(:,t)); % Histogram of degree distribution
        title(['Degree distribution t=',num2str(t)],'FontSize',10,'fontweight','bold')
    end
 
end