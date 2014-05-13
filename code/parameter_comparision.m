
PersonID_x_AboveAtExam = persons_above(participantID_weight,BMI, date_weigth_can,26);
    
result_infected = zeros (20, 5, 10, 146);
result_susceptible = zeros (20, 5, 10, 146);
result_corr = zeros(20,5,10);
index1 = 0;
for a=0:0.06:1.2
    index1 = index1 + 1;
    index2 = 0;
    for b=0.003:0.001:0.008
        index2 = index2 + 1;
        index3 = 0;
        for g=0:0.05:0.5
            index3 = index3 + 1;
            [susceptible,infected] = simulation_short(a,b,g, 18);
            result_infected(index1, index2, index3, :) = infected;
            result_susceptible(index1, index2, index3, :) = susceptible;
            cor = xcorr(infected(:,1:145)/100, sum(PersonID_x_AboveAtExam)/size(PersonID_x_AboveAtExam,1));
            result_corr(index1, index2, index3) = cor(1,1);
        end
    end
end
