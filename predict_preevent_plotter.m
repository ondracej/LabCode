figure
subplot(2,1,1)
plot((1:1650)/fs,[spw.pre(101:1000,:) spw.event(101:1000,:)])
hold on
plot((1:1500)/fs,mean(spw.pre(101:1000,:)),'k', 'linewidth',4)
ylim([-200 100])
xlim([0 1650/fs])
title('pre-SPW')

subplot(2,1,2)
plot((1:1650)/fs,[nonspw.pre(101:1000,:) nonspw.event(101:1000,:)])
hold on
plot((1:1500)/fs,mean(nonspw.pre(101:1000,:)),'k', 'linewidth',4)
ylim([-200 100])
xlim([0 1650/fs])
title('pre-nonSPW')
xlabel('Time(sec)')