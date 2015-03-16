predictedValue = round(mean(dColumn2));

nextwindow = previousWindow + windowsize;
predictedRow = [nextwindow, predictedValue];

predictedData = [data; predictedRow];
pColumn1 = predictedData(:,1);
pColumn2 = predictedData(:,2);

% Mean absolute percentage error
err = vColumn2 - pColumn2;
errpct = abs(err)./vColumn2*100; % Absolute percentage error

% Getting rid of weird numbers like infinities and NaNs
errpct(errpct == inf) = 0;  %for inf
errpct(errpct == -inf) = 0; %for -inf
errpct(isnan(errpct)) = 0;  %for NaN

MAPE =   mean(errpct); 

display(err);
display(errpct);
display(MAPE);
fprintf('Mean Absolute Percent Error (MAPE) for histroical loads: %0.3f%%\n',MAPE);

% Compare forescated data and the actual data
plot(pColumn1, pColumn2); hold all;
plot(vColumn1, vColumn2); hold off;

legend('predicted load', 'Actual load');
title('Actual load VS predicted load (Average)','Fontsize', 12,'color','b');
ylabel('Load');   xlabel('Period');

display(predictedValue);
display(predictedData);
