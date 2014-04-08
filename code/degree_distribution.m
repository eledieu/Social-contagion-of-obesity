function [P]=degree_distribution(adj_mat)
    
    date=size(adj_mat,3);
    len_source=size(adj_mat,1);
    
    P=zeros(len_source,date);
    
    for t=1:size(adj_mat,3)
        for k=1:len_source
            P(k,t)=sum(adj_mat(k,:,t));
        end
        figure,
        hist(P(:,t))
        title(['Degree distribution t=',num2str(t)],'FontSize',10,'fontweight','bold')
    end
 
end