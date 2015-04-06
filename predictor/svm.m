function [ predicted_value, accuracy, decision_values ] = svm( dColumn1, dColumn2, next_window )
%Using libsvm Library for prediction
%   Support Vector Machines - Regression Implementation
    data = dColumn2;       % training set 
    dataLabels = dColumn1; % training set labels
    
    %data = (data - repmat(min(data,[],1),size(data,1),1))*spdiags(1./(max(data,[],1)-min(data,[],1))',0,size(data,2),size(data,2));
    
    options = ' -s 3 -t 2 -c 100 -p 0.001 -h 0'; % -s 3 = regression option

    model = svmtrain(dataLabels, data, options);

    x = (next_window)'; % label for the predicted value
    y = (0)';          % data to be predicted

    [predicted_value, accuracy, decision_values] = svmpredict(x, y, model);
    
end

