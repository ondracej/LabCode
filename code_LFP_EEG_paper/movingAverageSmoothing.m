function smoothedX = movingAverageSmoothing(X, T, windowSize)
    % Check if the input sizes match
    if numel(X) ~= numel(T)
        error('Input sizes do not match. X and T must have the same number of elements.');
    end
    
    % Check if the window size is valid
    if windowSize <= 0 || mod(windowSize, 2) == 0
        error('Window size must be a positive odd number.');
    end
    
    % Initialize smoothedX
    smoothedX = zeros(size(X));
    
    % Perform moving average smoothing
    halfWindowSize = floor(windowSize / 2);
    
    for i = 1:numel(X)
        lowerBound = max(1, i - halfWindowSize);
        upperBound = min(numel(X), i + halfWindowSize);
        
        % Use only available data for the current window
        currentWindow = X(lowerBound:upperBound);
        
        % Exclude NaN values from the current window
        currentWindow = currentWindow(~isnan(currentWindow));
        
        % Compute the moving average
        smoothedX(i) = mean(currentWindow);
    end
        
end
