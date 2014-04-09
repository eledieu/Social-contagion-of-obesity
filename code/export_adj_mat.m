function export_adj_mat(adj_mat)
% Export the adjacency matrix to 
    variable_name=inputname(1);
    variable_name
    csvwrite([variable_name,'.csv'],adj_mat);
end