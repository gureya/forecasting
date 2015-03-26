function [ predicted_value, accuracy, decision_values ] = svm( dColumn1, dColumn2, previousWindow, windowsize )
%Using libsvm Library for prediction
%   Support Vector Machines - Regression Implementation
    data = dColumn2;       % training set 
    dataLabels = dColumn1; % training set labels
    options = ' -s 3 -t 2 -c 100 -p 0.001 -h 0'; % -s 3 = regression option

    model = svmtrain(dataLabels, data, options);

    nextwindow = previousWindow + windowsize; % nextwindow to be predicted

    x = (nextwindow); % label for the predicted value
    y = (0);          % data to be predicted

    [predicted_value, accuracy, decision_values] = svmpredict(x, y, model);
    
end

