sig=EEG(2000*2000:6000*2000,6);
[Pxx,F] = pwelch(sig,10000,5000,2048,2000);
figure
plot(log10(F(2:end)),log10(Pxx(2:end)));
grid on;
xlabel('log10(F)'); ylabel('log10(Pxx)');
title('Log-Log Plot of PSD Estimate')

% line regression
Xpred = [ones(length(F(2:end)),1) log10(F(2:end))];
b = lscov(Xpred,log10(Pxx(2:end)));
y = b(1)+b(2)*log10(F(2:end));
hold on;
plot(log10(F(2:end)),y,'r--');
title(['Estimated Slope is ' num2str(b(2))]);
% getting the exponent H from wavelet leader, alpha=2H+1

[dheeg,heeg,cpeeg] = dwtleader(sig);
fprintf('Wavelet leader estimate is %1.2f\n',-2*cpbrown(1)-1);
figure
plot(heeg,dheeg)