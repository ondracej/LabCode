function [ma_nan] = mov_iqr_nan(x, win_length)
% moving average filter for input with NaN
ma_nan=NaN(1,length(x)-win_length);
for k=1:length(x)
    x_part=x(max(k-round(win_length/2)-1,1):min(k+round(win_length/2)-1,length(x)));
    data_part=x_part(~isnan(x_part));
    if isempty(data_part)
        ma_nan(k)=NaN;
    else
        ma_nan(k)=iqr(data_part);
    end
end

