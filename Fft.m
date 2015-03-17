% fs = 512 %sampling frequency
% t = 0:1/fs:1;
% n_fft = 2^(nextpow2(length(dColumn2)));
% fft_x = fft(dColumn2,n_fft);
% NumUniquePts = ceil((n_fft+1)/2);
% display(NumUniquePts);
% fft_x = fft_x(1:NumUniquePts);
% m_x = abs(fft_x);
% display(m_x);
% m_x = m_x/length(x);
% m_x = m_x.^2;
% m_x = m_x*2;
% m_x(1) = m_x(1)/2;
% if ~rem(n_fft,2)
%     m_x(end) = m_x(end)/2;
% end
% 
% [maxVal, index] = max(fft_x);
% maxFreq = m_x(index);
% display(maxFreq);
% display(maxVal);
% 
% 
% f = (0:NumUniquePts-1)*fs/n_fft;
% plot(f,m_x);
% title('Spectrum of a 50Hz Sine Wave & its 3rd & 5th Harmonics');
% xlabel('Frequency (HZ)');
% ylabel('Load');
%%
% Fs = 48000;
% x = dColumn2;            % 256 samples data set
% fftLength = length(x);  % Always make sure to be at least as long as your data. 
% xdft = fft(x,fftLength);
% maxAmp = max(abs(xdft));
% 
% freq = [0:fftLength-1].*(Fs/fftLength); % This is your total freq-axis
% freqsYouCareAbout = freq(freq < Fs/2);  % You only care about either the pos or neg 
%                                         frequencies, since they are redundant for
%                                         a real signal.
% 
% xdftYouCareAbout = abs(xdft(1:round(fftLength/2))); % Take the absolute magnitude.
% display(xdftYouCareAbout);
% 
% [maxVal, index] = max(xdftYouCareAbout); % maxVal is your (un-normalized) maximum amplitude
% 
% maxFreq = freqsYouCareAbout(index); % This is the frequency of your dominant signal.
% display(maxFreq);
%% Finding the dorminant frequency
%Fs = 1000; % sampling frequency 1 kHz
Fs = 10;
%t =  0 : 1/Fs : 0.296; % time scale
t = dColumn1;
f = 100; % Hz, embedded dominant frequency
%x = cos(2*pi*f*t) + randn(size(t)); % time series
x = dColumn2;
x = x - mean(x);
w = length(x); % length of your time series
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
display(z);
patternWindows = w/z;
