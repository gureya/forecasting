
%% EXAMPLE 1
% x                 = csvread('Data/data.txt');
% dataLabels        = x(:,1);
% display(dataLabels);
% data              = x(:,2);
% display(data);
% trainDataLength   = round(length(data)*70/100);
% TrainingSet       = data(1:trainDataLength);
% TrainingSetLabels = dataLabels(1:trainDataLength);
% TestSet           = data(trainDataLength+1:end);
% TestSetLabels     = dataLabels(trainDataLength+1:end);
% 
% options = ' -s 3 -t 2 -c 100 -p 0.001 -h 0';
% model   = svmtrain(TrainingSetLabels, TrainingSet, options);
% 
% [predicted_label, accuracy, decision_values] = svmpredict(TestSetLabels, TestSet, model);
% display(predicted_label);

%% EXAMPLE 2
% y = [11, 22, 33, 44, 55, 66, 77];
% x = [1, 2, 3, 4, 5, 6, 7];
% x1 = (1:7)'; % training set: should be column
% y1 = [11, 22, 33, 44, 55, 66, 77]'; % your time series
% options = ' -s 3 -t 2 -c 100 -p 0.001 -h 0';
% model = svmtrain(y1, x1, options);
% x2 = (8:10)'; % test set
% y2 = [88,99,110]'; % hidden values that we don't use for training
% [y2_predicted, accuracy, decision_values] = svmpredict(y2, x2, model);
% display(y2_predicted);

%% Support Vector Machine - Regression Implementation
data = dColumn2;       % training set 
dataLabels = dColumn1; % training set labels
options = ' -s 3 -t 2 -c 100 -p 0.001 -h 0'; % -s 3 = regression option

model = svmtrain(dataLabels, data, options);

nextwindow = previousWindow + windowsize; % nextwindow to be predicted

x = (nextwindow); % label for the predicted value
display(x);
y = [0];          % data to be predicted

[predictedValue, accuracy, decision_values] = svmpredict(x, y, model);
display(predictedValue);

