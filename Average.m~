predictedValue = round(mean(dColumn2));

nextwindow = previousWindow + windowsize;
predictedRow = [nextwindow, predictedValue];

predictedData = [data; predictedRow];
pColumn1 = predictedData(:,1);
pColumn2 = predictedData(:,2);

% Mean absolute percentage error
err = vColumn2 - pColumn2;
errpct = abs(err)./vColumn2*100; % Absolute percentage error
MAPE =   mean(errpct(~isinf(errpct))); 

display(err);
display(errpct);
display(MAPE);


% Compare forescated data and the actual data
plot(pColumn1, pColumn2); hold all;
plot(vColumn1, vColumn2); hold off;

legend('predicted load', 'Actual load');
title('Actual load VS predicted load (Average)','Fontsize', 12,'color','b');
ylabel('Load');   xlabel('Period');

display(predictedValue);
display(predictedData);
