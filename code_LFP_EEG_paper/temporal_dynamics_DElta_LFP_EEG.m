%% visualization of the temporal dynamics of congruence duirng SWS between DVR and base channel
t_lim=[1*3600 1.3*3600]; % 5 minutes before and after for the window that counts the bins fro congruence calculation

g=figure
set(g,'position',[100 100 1400 250]);
plot(t_bin_label/60,zscore(Delta_), 'color',[0 0 1 .5],'linewidth',1,'marker','.'); hold on
ylabel('p(SWS) front L')
plot(t_bin_label_ref/60,zscore(Delta_ref_), 'color',[0 .5 1 .5],'linewidth',1,'marker','.'); hold on
ylabel('p(SWS) DVR')

ylim([-4 4])
xlim(t_lim/60)
xlabel('Time (min)');

