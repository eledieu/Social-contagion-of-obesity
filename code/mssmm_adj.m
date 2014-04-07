function [adj_mat,unique_source,unique_target]=mssmm_adj(source,target,source_friendship,date_friendship_can)
    load('mssmm_data.mat')
    %% Vector of unique source
        unique_source=zeros(1,1);
        for i=1:length(source) 
            newpart=1;
            for j=1:length(unique_source)
                if isequal(source(i),unique_source(j)) % test if 
                    newpart=0;
                else
                end
            end

            if newpart==1
                unique_source=vertcat(unique_source,source(i));
            else
            end

        end 
        unique_source=unique_source(2:end)
        length(unique_source)
    %% Vector of unique target
        unique_target=zeros(1,1);
        for i=1:length(target) 
            newpart=1;
            for j=1:length(unique_target)
                if isequal(target(i),unique_target(j)) % test if 
                    newpart=0;
                else
                end
            end

            if newpart==1
                unique_target=vertcat(unique_target,target(i));
            else
            end

        end 
        unique_target=unique_target(2:end);
        length(unique_target)    
    %% Creation of the adjacency matrix
 
    date=unique(date_friendship_can);
    adj_mat=zeros(length(unique_source),length(unique_target),length(date));
    
    for t=1:length(date)
        for i=1:length(source_friendship)
            
            % source_friendship_index returns index of person in the adjacency matrix
            source_friendship_index=find(ismember(unique_source,source_friendship(i)));
            target_friendship_index=find(ismember(unique_target,target_friendship(i)));
            
            % Adjacency matrix element value equal to weight_friendship
            % value ranges from 0 to 7
            adj_mat(source_friendship_index,target_friendship_index,t)=weight_friendship(i);
            
        end
    end
end
