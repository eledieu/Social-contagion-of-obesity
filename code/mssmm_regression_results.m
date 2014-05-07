function [above b g a] =mssmm_regression_results(change_above, change_under)
 % Compute the parameters to be used in the SIS and SISa model
 
 %OUTPUT :: The parameters to be used in the SIS model and SISa model, by
 %determining the state that is infectious ( cf. Hill and al.)
 % above : boolean variable. 1 if above is the infectious state. 0 if under
 % is the infectious state
 
 %INPUT ::
 % changes_above : output of the function msssm_regression on the changes
 % from the under threshold state to the above threshold state
 % changes_under : output of the function msssm_regression on the changes
 % from the above threshold state to the under threshold state
 
 X_above = change_above(:,1);
 y_above = change_above(:,2)/100;
 
 X_under = change_under(:,1);
 y_under = change_under(:,2)/100;
 
 lin_above = fitlm(X_above, y_above, 'linear')
 lin_under = fitlm(X_under, y_under, 'linear')
    
 coef_above = cell2mat(table2cell(lin_above.Coefficients));
 coef_under = cell2mat(table2cell(lin_under.Coefficients));
 
 if coef_under(2,4) > coef_above(2,4) % Corresponds to a comparison of the p-value
     above = 1;
     b = coef_above(2,1);
     a = coef_above(1,1);
     g = coef_under(1,1);
 else
     above = 0;
     b = coef_under(2,1);
     a = coef_under(1,1);
     g = coef_above(1,1);
 end

end
