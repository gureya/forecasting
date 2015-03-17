%importing data from text files

data = csvread('Data/data.txt');        % training data
valdata = csvread('Data/valdata.txt');  % validation data

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


%% Initial Exploration of Data
x=input('Do you want to visualize the data?(y == yes else ==no): ','s');
if (x=='y' || x=='Y')
    plot(dColumn1, dColumn2);
    title('Period VS Load','Fontsize', 12,'color','r');
    xlabel('Period'); ylabel('Load');
end


%% forecasting models menu
again='y';
while (again =='y' || again=='Y')
clc;
display('**********************************************************');
display(' (1) Naive');
display(' (2) Average');
display(' (3) Maximum');
display(' (4) Minimum');
display('**********************************************************');
model=0;
while (model<1 || model>7),
    model = input('Choose the desired model from the menu above:  ');
end

switch(model)
    case 1 
        run('Naive');
    case 2 
        run('Average');        
    case 3 
        run('Maximum');   
    case 4 
        run('Minimum');
    case 5
        run('Fft');
    case 6 
       % run('Average_model');            
    otherwise 
        display('!Error');
        return;
end
 
again=input('\n\n Do you want to use another model?(y==Yes, n==No): ','s');

end



