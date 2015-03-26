%%% Load forecasting using Bagged Regression Trees

%% generate predictors
predictedValue = dColumn1;

%% create a Regression Tree
fprintf('in progress..........');
T = classregtree(dColumn1,dColumn2, 'method', 'regression');
T = treefit(dColumn1,dColumn2,'method', 'regression');
simpleTree = prune(T, 100);
fprintf('done\n');

%% validate the Regression Tree by evaluating the input data
RTREE_load=treeval(simpleTree,dColumn1);
%display(RTREE_load);
%display(length(RTREE_load));
%% Use Regression Tree to forecast a the next window
nextwindow = previousWindow + windowsize; % nextwindow to be predicted
x = (nextwindow);
RTREE_predicted = treeval(simpleTree,x);
display(RTREE_predicted);