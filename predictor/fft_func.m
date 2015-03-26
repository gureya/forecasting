function [ predicted_value, pattern ] = fft_func( dColumn2 )
% Employs Fast Fourier Transform (FFT) to calculate the dominant frequency
%   Returns the predicted value plus 1 if there is a repeating pattern
%   and 0 if no repeating pattern is found !!!
    %% Finding the dorminant frequency
    % Reference from this paper --- http://arxiv.org/pdf/1306.0103.pdf
    % let the sampling frequency be the length of time series
    Fs = length(dColumn2); % sampling frequency
    x = dColumn2; % time series
    x = x - mean(x);
    w = length(dColumn2); % length of your time series
    %nfft = 512; % next larger power of 2
    nfft = 2^(nextpow2(length(x)));
    y = fft(x,nfft); % Fast Fourier Transform
    y = abs(y.^2); % raw power spectrum density
    y = y(1:1+nfft/2); % half-spectrum
    [v,k] = max(y); % find maximum
    f_scale = (0:nfft/2)* Fs/nfft; % frequency scale
    fest = f_scale(k); % dominant frequency estimate

    %% check for repeating patterns
    z = (1/round(fest))*Fs;
    z = round(z);

    % Getting rid of weird numbers like infinities and NaNs
    z(z == inf) = w;  %for inf
    z(z == -inf) = w; %for -inf
    z(isnan(z)) = w;  %for NaN
    z(z == 0) = w; %for 0

    pw = floor(w/z); % number of pattern windows

    % some variables needed to partition the time series dynamically
    initial = 1;
    last = z;
    out = [];
    pValues = []; % Pearson correlation values
    mValues = []; % Mean values
    rValues = []; % Ratios of mean values

    while last <= length(dColumn2)
        A = dColumn2(initial:last);    % What needs to be added
        M = mean(A);                   % Get the mean of A
        mValues = [mValues; M]         % Add to the mean values
        out = horzcat(out,A);          % Do a horizontal concatenation
        initial = last + 1;
        last = last + z;
    end

    csize = size(out,2);

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
            a = out(:,next);   % first vector
            b = out(:,next+j); % second vector
            C = cov(a,b); % covariance
            r = mean(a)/mean(b); % ratio of their mean
            % D =
            % bsxfun(@minus,a,mean(a))'*bsxfun(@minus,b,mean(b))/(size(a,1)-1);
            % Another way to calculate covariance

            p = C(2)/(std(a)*std(b)); % Pearson correlation (pc). C(2) to only get the covariance
            %p = D/(std(a)*std(b));   % Another way to calculate the pc
            pValues = [pValues; p];
            rValues = [rValues; r];
        end
        next = next + 1;
        n = n - 1;
        i = i + 1;
    end

    % checking for similarities
    pMinimum = min(pValues);
    rMinrange = abs(1 - min(rValues));
    rMaxrange = abs(max(rValues) - 1);

    if (pMinimum > 0.85) && (rMinrange >=0 && rMinrange <= 0.05) && (rMaxrange >=0 && rMinrange <= 0.05)
        predicted_value = round(mean(mValues));
        pattern = 1;
    else
        predicted_value = round(mean(mValues));
        pattern = 0;
    end

end

