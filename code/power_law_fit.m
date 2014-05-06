function [distribution_degree_h,distribution_degree_pval] = power_law_fit(contacts)
% Returns a Power law fit of the network distribution degree 

% Input:
% contacts is a matrix containing the number of contacts of each
% person at the different period when friendship assessed

% Output:
% distribution_degree_h=Hypothesis test result, returned as a logical value.
% If equal to 1, null hypothesis is rejected.
% If equal to 0, failure to reject the null hypothesis 
% distribution_degree_pval=p-value p of the hypothesis test

%% Distribution degree power law fit
for t=1:size(contacts,2)
    total_contacts=sum(contacts(:,t));
    
    % nelements count the number of elements in each range
    [nelements,centers]=hist(contacts(:,t),10);
    nelements(nelements==0)=NaN;
    
    % Curve fitting tool
    log_centers=log(centers);
    log_elements=log(1/total_contacts*nelements);
    
    fit_power_law=fitlm(log_elements,log_centers);
    fit_coeff=double(fit_power_law.Coefficients)
    
    % alpha*x^(beta)
    alpha=fit_coeff(1,1);
    beta=fit_coeff(2,1);
    
    % Kolomogorov Smirnov test
    [distribution_degree_h,distribution_degree_pval]=kstest(nelements,'Alpha',0.05,'CDF',[transpose(nelements),alpha*transpose(nelements).^beta]);
    
end

end