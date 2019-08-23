X=eeg_clean(1:10*fs,1);
tic
[imf,residual,info] = emd(X,'Interpolation','pchip');
toc
figure
for k=1:max(info.NumIMF)
    subplot(max(info.NumIMF),1,k);
    plot(imf(:,k))
end
