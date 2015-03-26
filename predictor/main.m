%importing data from text files

data = csvread('../Data/data.txt');        % training data
valdata = csvread('../Data/valdata.txt');  % validation data

%display(data);
display('done importing....');

%data preprocessing
dColumn1 = data(:,1);
dColumn2 = data(:,2);

vColumn1 = valdata(:,1);
vColumn2 = valdata(:,2);

%display(column1);
%display(column2);

%%add configuration parameters here
[m, n] = size(data);             % size of your data
windowsize = 10;                 % size of your predicition window
previousWindow = dColumn1(end);  % the value of the last prediction window

%% Prediction Algorithms

% 1. Mean
[avg] = average(dColumn2);
%fprintf('average_value:  %d', avg);
display(avg);

% 2. Maximum
[maxima] = maximum(dColumn2);
%fprintf('maximum_value:  %d', maxima);
display(maxima);

% 3. FFT
[fft_value, pattern] = fft_func(dColumn2);
if(pattern == 1)
    s = 'Repeating pattern found';
else
    s = 'Repeating pattern not found';
end
%fprintf('fft_value:  %d ...%s', fft_value, s);
display(fft_value);
display(s);


% 4. Regression Trees
[rt_value] = regression_tree(dColumn1, dColumn2, previousWindow, windowsize);
%fprintf('Regression_tree_value:  %d', rt_value);
display(rt_value);

% 5. Using libsvm library - Support Vector Machines
[svm_value, accuracy, decision_values] = svm(dColumn1, dColumn2, previousWindow, windowsize);
%fprintf('Svm_value:  %d', svm_value);
display(svm_value);

