function [] = plot_graph_report()
%Plot the graphs used in the final report
load('avg_degree.mat')
load('distribution_degree_coeff.mat')
load('contacts.mat')
load('knn.mat')
load('knn_weight.mat')
load('unique_weight.mat')
load('DATA.mat')
%% Degree distribution graph
    for t=1:size(avg_degree,1)
        total_contacts=sum(contacts(:,t));
        
        figure;       
        set(gca,'Fontsize',16);
        [nelements,centers]=hist(contacts(:,t),[]);
        hist(contacts(:,t),10);% Histogram of degree distribution        
        xlabel('Number of Close Friends','Fontsize',16);
        ylabel('Close Friends Frequency','Fontsize',16);
        
        hold;
        alpha=exp(distribution_degree_coeff(t,1))
        beta=distribution_degree_coeff(t,2)
        plot(centers,exp(distribution_degree_coeff(t,1))*centers.^distribution_degree_coeff(t,2),'*-');
        
        % Legend
        Legend=cell(2,1);
        Legend{1}='Histogram of close friends';
        Legend{2}='Fitted degree distribution';
        legend(Legend,'FontSize',12);
        
        hold off;
        
    end
%% Network assortativity - Average nearest neighbor degree 
    for t=1:size(knn,2)
        axis=1:size(knn,1);
        figure;
        set(gca,'Fontsize',16);
        knn(knn==0)=nan;
        plot(axis(1:45),knn(1:45,t),'*');
        xlabel('Average Degree','Fontsize',16);
        ylabel('Average Nearest Neighbor Degree','Fontsize',16);
        xlim([0 25]);   
        hold on
        
        fit_knn=fitlm(axis(1:45),knn(1:45,t));
        fit_knn_coeff=double(fit_knn.Coefficients);
        plot(axis(1:45),fit_knn_coeff(1,1)+fit_knn_coeff(2,1)*axis(1:45),'-');
        
        % Legend
        Legend=cell(2,1);
        Legend{1}='Actual average nearest neighbor degree';
        Legend{2}='Fitted values';
        legend(Legend,'FontSize',12);
                
        hold off
        ylim([0 15]);
    end
%% Network assortativity - Average nearest neighbor weight 
    for t=1:size(knn_weight,2)
        figure;
        set(gca,'Fontsize',16);
        unique_weight(knn_weight==0)=nan;
        unique_weight(isnan(knn_weight))=nan;        
        knn_weight(knn_weight==0)=nan;
        plot(unique_weight(:,1),knn_weight(:,3),'*');
        xlabel('Subject Weight','Fontsize',16);
        ylabel('Average Nearest Neighbor Weight','Fontsize',16);
        xlim([40 110]);
        hold on
        
        fit_knn_weight=fitlm(unique_weight(:,1),knn_weight(:,3));
        fit_knn_weight_coeff=double(fit_knn_weight.Coefficients);
        plot(unique_weight(:,1),fit_knn_weight_coeff(1,1)+fit_knn_weight_coeff(2,1)*unique_weight(:,1),'-')
       
        % Legend
        Legend=cell(2,1);
        Legend{1}='Actual average nearest neighbor weight';
        Legend{2}='Fitted values';
        legend(Legend,'FontSize',12);        
        
        hold off
        
    end
%% Returns the distribution of the BMI
    unique_participantID_weight=unique(participantID_weight);
    
    unique_BMI=zeros(length(unique_participantID_weight),1);
    
    for i=1:length(unique_participantID_weight)
        index_unique=find(ismember(participantID_weight,unique_participantID_weight(i)));
        Index_unique=index_unique(1);
        unique_BMI(i)=BMI(Index_unique);
    end
    axis=1:50;
    unique_BMI(unique_BMI<0)=nan; 
    histfit(unique_BMI,10,'lognormal');
    xlabel('BMI','Fontsize',16);
    ylabel('BMI frequency','Fontsize',16);
    xlim([15 50]);
    unique_BMI=unique_BMI(~isnan(unique_BMI));    
    mean(unique_BMI)
    %dfittool(unique_BMI)
         
    % Legend
    Legend=cell(2,1);
    Legend{1}='BMI distribution';
    Legend{2}='Fitted values';
    legend(Legend,'FontSize',12);   

end




