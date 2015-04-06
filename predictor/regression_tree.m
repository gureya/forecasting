function [ predicted_value ] = regression_tree( dColumn1, dColumn2, next_window )
%Load forecasting using Bagged Regression Trees
%   Detailed explanation goes here

    %% create a Regression Tree
    %fprintf('in progress..........');
%     T = classregtree(dColumn1,dColumn2, 'method', 'regression');
%     T = treefit(dColumn1,dColumn2,'method', 'regression');
%     simpleTree = prune(T, 100);
    %fprintf('done\n');
    
    T = fitrtree(dColumn1, dColumn2);

    %% validate the Regression Tree by evaluating the input data
    %RTREE_load = treeval(simpleTree,dColumn1);

    %% Use Regression Tree to forecast a the next window
    x = (next_window);  % nextwindow to be predicted
    RTREE_predicted = predict(T, x);
   % RTREE_predicted = treeval(simpleTree,x);
    predicted_value = RTREE_predicted;
    
end

