function [] = power_law_fit(contacts)
% Returns a Power law fit of the network distribution degree 

% Input:contacts is a matrix containing the number of contacts of each
% person at the different period when friendship assessed

% Output:curve fitting tool

%% Distribution degree power law fit
    for t=1:size(contacts,2)
        total_contacts=sum(contacts(:,t));
        
        % nelements count the number of elements in each range of axis
        [nelements,centers]=hist(contacts(:,t),10); 
        
        % figure;
        % hist(contacts(:,t),10);
        nelements(nelements==0)=NaN;
        
        % Curve fitting tool
        log_centers=log(centers);
        log_elements=log(1/total_contacts*nelements);
        cftool(log_centers,log_elements);
    end
end