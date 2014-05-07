function [] = BMI_distribution(BMI,participantID_weight)
% Returns the distribution of the BMI
%   Input: %% BMI
%
%   Output: %% distribution of BMI
    
    unique_participantID_weight=unique(participantID_weight);
    
    unique_BMI=zeros(length(unique_participantID_weight),1);
    
    for i=1:length(unique_participantID_weight)
        index_unique=find(ismember(participantID_weight,unique_participantID_weight(i)));
        Index_unique=index_unique(1);
        unique_BMI(i)=BMI(Index_unique);
    end
    axis=1:50;
    histfit(unique_BMI,50);

end

