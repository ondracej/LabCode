function [ma_nan] = mov_avg_nan(x, win_length)
% moving average filter for input with NaN
ma_nan=NaN(1,length(win_length));
for k=1:length(x)
    x_part=x(k:min(k+win_length-1,length(x)));
    data_part=x_part(~isnan(x_part));
    if isempty(data_part)
        ma_nan(k)=NaN;
    else
        ma_nan(k)=mean(data_part);
    end
end

