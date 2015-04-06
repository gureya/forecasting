%importing data from text files
fil1 = 'Data/data.txt';
fid1 = fopen(fil1);
if all(fgetl(fid1) == -1)
    fprintf('Empty file...No training data available');
else
    data = csvread('Data/data.txt');        % training data
    predicted_data = [];                    % prediction data
    previous_predictions = zeros(1,5);      % initialize previous predictions to Zero
    
    %display(data);
    display('done importing....');
    
    again='y';
    %===========Testing==========================
    while (again =='y' || again=='Y')
    %============================================    
        %data preprocessing
        dColumn1 = data(:,1);
        dColumn2 = data(:,2);

        %% add configuration parameters here
        [m, n] = size(data);             % size of your data
        window_size = 10;                % size of your predicition window
        if m < 1
            fprintf('...Not enough training data available to make predictions...');
        else
            previous_window = dColumn1(end-1);  % the value of the last prediction window
            current_window = dColumn1(end);     % the value of the current prediction window
            next_window = current_window + window_size; % the value of the next prediction window

            display(previous_window);
            display(current_window);
            display(next_window);

            %% Prediction Algorithms

            % 1. Mean
            [avg] = average(dColumn2);
            %display(round(avg));

            % 2. Maximum
            [maxima] = maximum(dColumn2);
            %display(round(maxima));

            % 3. FFT
            [fft_value, pattern] = fft_func(dColumn2);
            if(pattern == 1)
                s = 'Repeating pattern found';
            else
                s = 'Repeating pattern not found';
            end
            % display(round(fft_value));
            % display(s);


            % 4. Regression Trees
            [rt_value] = regression_tree(dColumn1, dColumn2, next_window);
            %display(round(rt_value));

            % 5. Using libsvm library - Support Vector Machines
            [svm_value, accuracy, decision_values] = svm(dColumn1, dColumn2, next_window);
            %display(round(svm_value));

            %% The Weighted Majority Algorithm
            % sum up the prediction output in a row vector [mean, max, fft, reg_trees, libsvm]
            current_predictions = round([avg, maxima, fft_value, rt_value, svm_value]);
            display(current_predictions);

            real_value = data(data(:,1)==current_window,2); % The actual value for the current prediction window
            display(real_value);

            predict_accuracy = abs(previous_predictions - real_value); % The prediction accuracy
            display(predict_accuracy);
            [minpa_val, minpa_index] = min(predict_accuracy); % The more accurate algorithm

            % Initialize the weights of all predictions to 1 [mean, max, fft, reg_trees, libsvm]
            if (isempty(predicted_data))
                weights = ones(1,5);
                predicted_value = round(mean(current_predictions)); % Initially just take the mean of the current_predictions
            else
                % Penalize each mistaken prediction by multiplying its weight by 1/2
                fprintf('I was here...time to hit hard on the bad predictors!!');
                for i=1:length(predict_accuracy)
                    if i ~= minpa_index
                        weights([i]) = weights([i]) * 0.5;
                    end
                end
                [maxw_val, maxw_index] = max(weights); % Highest weight
                display(maxw_val);
                predicted_value = current_predictions(([maxw_index])); % prediction corresponding to the highest weight
            end

            predicted_row = [next_window, predicted_value];    % predicted row data
            predicted_data = [predicted_data; predicted_row];  % add to the predicted data
            previous_predictions = current_predictions;
            %==========Testing, should be removed===================
            i = 0;
            real_value = 300 + i;
            real_row = [next_window, real_value];
            data = [data; real_row];
            i = i + 25;
            %========================================================
            display(previous_predictions);
            display(predicted_value);
            display(predicted_data);
            display(data);
            display(weights);

        end
    %==============end of While Testing=====================
    again='n';
    again=input('\n\n Do you want to test again?(y==Yes, n==No): ','s');
    end
    %=======================================================
end

