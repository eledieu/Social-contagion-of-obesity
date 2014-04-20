function [knn]=assortativity(adj_mat_bin)
    %% Returns the average nearest-neighbor degree to see if assortativity
        
    % Input:
            % Binary adjacency matrix: 1 if person are close friends and 0
            % otherwise
    % Ouput:
            % knn(k) for each time t where knn(k) is the average
            % nearest-neighbor degree of people with k contacts
            
    date=size(adj_mat_bin,3); % number of date
    len_source=size(adj_mat_bin,1); % number of persons
    
    number_of_contacts=zeros(len_source,date);
    knn=zeros(len_source,date);
    avg_degree=zeros(date,1);
    
    for t=1:date
        for k=1:len_source
            number_of_contacts(k,t)=sum(adj_mat_bin(k,:,t)); % Number of close friends of person k at time t
        end
        
        for n=1:len_source
        iter=1;
            for l=1:len_source
                if number_of_contacts(l,t)==n
                    for j=1:len_source
                        if adj_mat_bin(l,j,t)>0
                            knn(n,t)=knn(n,t)+number_of_contacts(j,t);
                            iter=iter+1;
                        else
                        end
                    end
                else
                end
            end
        knn(n,t)=1/iter*knn(n,t); % Average nearest-neighbor degree 
        end
    end
end