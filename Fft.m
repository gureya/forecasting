%% Finding the dorminant frequency
% Reference form this paper --- http://arxiv.org/pdf/1306.0103.pdf

%Fs = 1000; % sampling frequency 1 kHz
Fs = 10;
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
z = floor(z);
display(z);
pw = w/z; % number of pattern windows
pw = floor(pw);
display(pw);

% some variables needed to partition the time series dynamically
initial = 1;
last = z;
out = [];


%dummy = [300,100,300,200,300,235,90,456,123,300,300,300,257,258,300];
%dummy = dummy(:); % converting to a column vector
%display(dummy);

while last <= length(dColumn2)
   %eval(['A' num2str(i) '= dColumn2(initial:last)']);
   A = dColumn2(initial:last);    % What needs to be added
   out = horzcat(out,A);       % Do a horizontal concatenation
   initial = last + 1;
   last = last + z;
end

display(out);

csize = size(out,2);
% for i=1:csize
%     display(out(:,i));
% end

next = 1;
n = (csize - 1);
while 1i < csize
    for j=1:n
        %display(out(:,next));
        %display(out(:,next+j));
        C = cov(out(:,next),out(:,next+j));
        display(C);
        p = C(2)/std(out(:,next))*std(out(:,next+j));
        display(p);
    end
        next = next + 1;
        n = n - 1; 
end

