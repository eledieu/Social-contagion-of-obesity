function [adj_mat,adj_mat_bin,unique_source,unique_target,unique_funf_group] = mssmm_adj(source,target,source_friendship,date_friendship_can)
    %% Returns the adjacency matrix, a binary adjacency matrix, a vector of unique elements of source and target
    % Input: 
        % source is the vector source in FunFit Excel file, target is
        % the vector source in FunFit Excel file, source_friendship is the
        % vector source_friendship in SurveyFriendship Excel file, date_friendship is the
        % vector date_friendship in SurveyFriendship Excel file
        % self-reported friendship ranging from 0 to 7. The binary
        % adjacency matrix displays 1 when the the self reported
        % friendship > 2
    % Output:
        % adj_mat is a  3D adjacency matrix matrix, the first two dimensions corresponds to
        % the person and the third dimension to the date of friendship
        % unique_source is the vector of unique source (idem for
        % unique_target)
    
    load('DATA.mat')
    %% Vector of unique source
        unique_source = unique(participantID_weight);%zeros(1,1);
        number_of_egos = length(unique_source) % for logging
    %% Vector of unique target
        unique_target = unique(participantID_weight);%zeros(1,1);
        %length(unique_target)
        
    %% Return the experiment to which a person belongs (Control,See-Peer,Pay-Peer)
    % unique_funf_group = cell(length(unique_source),1);
    % for i = 1:length(unique_source)    
    %     funf_group_index = find(ismember(source,unique_source(i)));
    %     unique_funf_group{i} = funf_group{funf_group_index};
    % end
       
    %% Creation of the adjacency matrix
 
    date = unique(date_friendship_can);
    adj_mat = zeros(length(unique_source),length(unique_target),length(date));
    adj_mat_bin = zeros(length(unique_source),length(unique_target),length(date));

    for i = 1:length(source_friendship)

        % source_friendship_index returns index of person in the adjacency matrix
        source_friendship_index = find(ismember(unique_source,source_friendship(i)));
        target_friendship_index = find(ismember(unique_target,target_friendship(i)));
        date_index = find(ismember(date,date_friendship_can(i)));

        % Adjacency matrix element value equal to weight_friendship
        % value ranges from 0 to 7
        adj_mat(source_friendship_index,target_friendship_index,date_index) = weight_friendship(i);
        if weight_friendship(i)>2
            adj_mat_bin(source_friendship_index,target_friendship_index,date_index) = 1;% binary adjacency matrix 1
        else
        end

    end
end
