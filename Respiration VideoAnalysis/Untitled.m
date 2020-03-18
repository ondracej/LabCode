x=r_dif(frames(2:end));
[b,a] = butter(2,5/(20/2)); % filter for smoothing the extracted respiration ...
y=filtfilt(b,a,x);
subplot(2,1,1)
plot(x), ylim([1000 4000])
subplot(2,1,2)
plot(y),  ylim([1000 4000])