function moving_median_x = movingMedian(x, t, window_length_minutes)
    window_length_seconds = window_length_minutes * 60;
    moving_median_x1 = median(x)*ones(1,size(x,1));
    moving_median_x2 = median(x)*ones(1,size(x,1));

    for i = 1:length(t)
        window_start = t(i);
        window_end = window_start + window_length_seconds;

        % Find indices of values within the current window
        indices_in_window = find(t >= window_start & t <= window_end);

        % Compute the median for the values within the current window
        if ~isempty(indices_in_window)
            moving_median_x1(i) = median(x(indices_in_window));
        end
    end
    %
    x_=flipud(x);
    t_=fliplr(t);
        for i = 1:length(t_)
        window_end = t_(i);
        window_start = window_start - window_length_seconds;

        % Find indices of values within the current window
        indices_in_window = find(t >= window_start & t <= window_end);

        % Compute the median for the values within the current window
        if ~isempty(indices_in_window)
            moving_median_x2(i) = median(x_(indices_in_window));
        end
        end
    moving_median_x=(moving_median_x1+fliplr(moving_median_x2))/2;

end
