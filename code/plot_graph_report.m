function [] = plot_graph_report(number_of_contacts,avg_degree,knn)
%Plot the graphs used in the final report
 
%% Degree distribution graph
    for t=1:size(avg_degree,1)
        total_contacts=sum(number_of_contacts(:,t));
        figure;
        bar(1:max(number_of_contacts(:,t)),1/total_contacts*histc(number_of_contacts(:,t),1:max(number_of_contacts(:,t))),'histc')% Histogram of degree distribution
        title(['Close Friends Distribution t=',num2str(t)],'FontSize',10,'fontweight','bold')
        
        figure;       
        hist(number_of_contacts(:,t))% Histogram of degree distribution
        xlabel('Number of Close Friends')
        ylabel('Close Friends Frequency')
        title(['Close Friends Distribution t=',num2str(t)],'FontSize',10,'fontweight','bold')
    end
%% Network assortativity
    for t=1:size(knn,2)
        axis=1:size(knn,1)
            figure;
            knn(knn==0)=nan
            plot(axis(1:45),knn(1:45,t),'*')
            xlabel('Average Degree k')
            ylabel('Average Nearest Neighbor Degree knn(k)')            
            title(['Network Assortativity t=',num2str(t)],'FontSize',10,'fontweight','bold')
    end
end




