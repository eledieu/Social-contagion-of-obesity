function [ output_args ] = obesity_confounding()
% Returns the regression of the US obesity by county against the median
% household income in 2010
% Source:http://www.ers.usda.gov/data-products/food-environment-atlas/data-access-and-documentation-downloads.aspx#.U3E4pSg-Vo4

    % Load input file
    load('DATA.mat')
    % Regression
    fitlm(MEDHHINC10/1000,PCT_OBESE_ADULTS10)

end

