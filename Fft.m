%% Finding the dorminant frequency
% Reference form this paper --- http://arxiv.org/pdf/1306.0103.pdf
% let the sampling frequency be the length of time series
Fs = length(dColumn2);
display(Fs);
%Fs = 1000; % sampling frequency 1 kHz
%Fs = 100;
%t =  0 : 1/Fs : 0.296; % time scale
t = dColumn1;
f = 100; % Hz, embedded dominant frequency
%x = cos(2*pi*f*t) + randn(size(t)); % time series
x = dColumn2;
x = x - mean(x);
w = length(dColumn2); % length of your time series
plot(t,x), axis('tight'), grid('on'), title('Time series'), figure
%nfft = 512; % next larger power of 2
nfft = 2^(nextpow2(length(x)));
y = fft(x,nfft); % Fast Fourier Transform
y = abs(y.^2); % raw power spectrum density
y = y(1:1+nfft/2); % half-spectrum
[v,k] = max(y); % find maximum
f_scale = (0:nfft/2)* Fs/nfft; % frequency scale
plot(f_scale, y),axis('tight'),grid('on'),title('Dominant Frequency')
fest = f_scale(k); % dominant frequency estimate
fprintf('Dominant freq.: true %f Hz, estimated %f Hznn', f, fest)
fprintf('Frequency step (resolution) = %f Hznn', f_scale(2))

%% check for repeating patterns
z = (1/round(fest))*Fs;
z = round(z);

% Getting rid of weird numbers like infinities and NaNs
z(z == inf) = w;  %for inf
z(z == -inf) = w; %for -inf
z(isnan(z)) = w;  %for NaN
z(z == 0) = w; %for 0

%z = 10;
%z = floor(z);
display(z);
pw = w/z; % number of pattern windows
pw = floor(pw);
display(pw);

% some variables needed to partition the time series dynamically
initial = 1;
last = z;
out = [];
pValues = []; % Pearson correlation values
mValues = []; % Mean values
rValues = []; % Ratios of mean values


%dummy = [300,100,300,200,300,235,90,456,123,300,300,300,257,258,300];
%dummy = dummy(:); % converting to a column vector
%display(dummy);

while last <= length(dColumn2)
    %eval(['A' num2str(i) '= dColumn2(initial:last)']);
    A = dColumn2(initial:last);    % What needs to be added
    M = mean(A);                   % Get the mean of A
    mValues = [mValues, M]         % Add to the mean values
    out = horzcat(out,A);          % Do a horizontal concatenation
    initial = last + 1;
    last = last + z;
end

display(out);
display(mValues);

csize = size(out,2);
display(csize);


next = 1;
n = (csize - 1);
i = 1;

% Incase we only have one column vector to handle
if csize == 1
    pValues = (0);
    rValues = (0);
end

while i < csize
    for j=1:n
        a = out(:,next);
        b = out(:,next+j);
        % display(a);
        % display(b);
        C = cov(a,b); % covariance
        r = mean(a)/mean(b); % ratio of their mean
        % D =
        % bsxfun(@minus,a,mean(a))'*bsxfun(@minus,b,mean(b))/(size(a,1)-1);
        % Another way to calculate covariance
        % display(C);
        % display(D);
        
        p = C(2)/(std(a)*std(b)); % Pearson correlation (pc)
        %p = D/(std(a)*std(b));   % Another way to calculate the pc
        pValues = [pValues; p];
        rValues = [rValues; r];
        %display(p);
        %display(r);
    end
    next = next + 1;
    n = n - 1;
    i = i + 1;
end

display(pValues);
%display(length(pValues));
%display(min(pValues));
display(rValues);
%display(length(rValues))

% checking for similarities
pMinimum = min(pValues);
rMinrange = abs(1 - min(rValues));
rMaxrange = abs(max(rValues) - 1);

display(pMinimum);
display(rMinrange);
display(rMaxrange);

if (pMinimum > 0.85) && (rMinrange >=0 && rMinrange <= 0.05) && (rMaxrange >=0 && rMinrange <= 0.05)
    fprintf('Repeating pattern found')
    predictedValue = round(mean(mValues));
    display(predictedValue);
else
    fprintf('Repeating pattern not found')
    predictedValue = round(mean(mValues));
    display(predictedValue);
    % Execute alternative algorithm
end


