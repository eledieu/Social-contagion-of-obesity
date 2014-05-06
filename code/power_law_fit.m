function [distribution_degree_coeff] = power_law_fit(contacts)
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
distribution_degree_coeff=zeros(size(contacts,2),2);
distribution_degree_h=zeros(size(contacts,2),1);
distribution_degree_pval=zeros(size(contacts,2),1);

for t=1:size(contacts,2)
    total_contacts=sum(contacts(:,t));
    
    % nelements count the number of elements in each range
    [nelements,centers]=hist(contacts(:,t),10);
    nelements(nelements==0)=NaN;
    
    % Curve fitting tool
    log_centers=log(centers);
    log_nelements=log(nelements);
    fit_power_law=fitlm(log_centers,log_nelements,'linear');
    fit_coeff=double(fit_power_law.Coefficients);
    
    % alpha*x^(beta)
    distribution_degree_coeff(t,1)=fit_coeff(1,1);
    distribution_degree_coeff(t,2)=fit_coeff(2,1);
    
    lnalpha=distribution_degree_coeff(t,1);
    beta=distribution_degree_coeff(t,2);
    
    % Kolomogorov Smirnov test
    % [h,pval]=kstest(nelements,'Alpha',0.05,'CDF',[transpose(centers),exp(lnalpha)*transpose(centers).^beta]);
    % distribution_degree_h(t,1)=h;
    % distribution_degree_pval(t,1)=pval;
     
end

end