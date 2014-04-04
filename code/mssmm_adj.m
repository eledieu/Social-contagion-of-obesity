function [adj_mat,unique_source,unique_target]=mssmm_adj()
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
        length(unique_target)    
    %% Creation of the adjacency matrix
    adj_mat=zeros(length(unique_source),length(unique_source));
    for i=1:length(source)
        for j=1:length(unique_source)
            for k=1:length(unique_target)
            if isequal(source(i),unique_source(j)) && isequal(target(i),unique_target(k))
                if strcmp(funf_group(i),'see-peer')==1
                    adj_mat(j,k)=2; % 2 if see peer
                elseif strcmp(funf_group(i),'pay-peer')==1
                    adj_mat(j,k)=1; % 1 if pay-peer
                end
            else
            end
            end
        end
    end
           
end
