function [knn,knn_weight,number_of_contacts,unique_weight]=assortativity(adj_mat_bin,participantID_weight,weight)
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
    knn=zeros(len_source,date); % Average nearest-neighbor degree
    knn_weight=zeros(len_source,date); % Average nearest-neighbor weight
    unique_weight=zeros(len_source,date); 
    avg_degree=zeros(date,1);

    for t=1:date
        for k=1:len_source
            number_of_contacts(k,t)=sum(adj_mat_bin(k,:,t)); % Number of close friends of person k at time t
        end

        for n=1:len_source
            iter=0;
            
            unique_participantID_weight=unique(participantID_weight);            
            index_weight_source=find(ismember(participantID_weight,unique_participantID_weight(n)));
            Index_weight_source=index_weight_source(1);
            unique_weight(n,t)=weight(Index_weight_source);
            
            for l=1:len_source

                if adj_mat_bin(n,l,t)>0
                    index_weight_target=find(ismember(participantID_weight,unique_participantID_weight(l)));
                    Index_weight_target=index_weight_target(1);
                    knn_weight(n,t)=knn_weight(n,t)+weight(Index_weight_target);
                end

                if number_of_contacts(l,t)==n
                    for j=1:len_source
                        if adj_mat_bin(l,j,t)>0
                            knn(n,t)=knn(n,t)+number_of_contacts(j,t);
                            iter=iter+1;
                        end
                    end
                end
            end
            knn(n,t)=1/iter*knn(n,t);
            knn_weight(n,t)=1/number_of_contacts(n,t)*knn_weight(n,t);
        end
    end
end