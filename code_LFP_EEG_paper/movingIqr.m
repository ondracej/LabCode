function moving_iqr_x = movingIqr(x, t, window_length_minutes)
    window_length_seconds = window_length_minutes * 60;
    moving_iqr_x = iqr(x)*ones(1,size(x,1));;

    for i = 1:length(t)
        window_start = t(i);
        window_end = window_start + window_length_seconds;

        % Find indices of values within the current window
        indices_in_window = find(t >= window_start & t <= window_end);

        % Compute the iqr for the values within the current window
        if length(indices_in_window)>1
            moving_iqr_x(i) = iqr(x(indices_in_window));
        end
    end
end
