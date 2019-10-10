%% gives a plot of SPW occurrance along with power ratios
% this code shall be calculated afer 'band_freq_ratios.m'
bandname={'\delta', '\theta', '\alpha', '\beta', '\gamma'};
t0=18450;  plot_time=[0 30]; %%%%%%%%%%%
figure
chnls=c; 
mm=1;
for kk=1:feat_num-1 % from delta to beta
    for jj=kk+1:feat_num
        subplot(12,1,mm+2); 
        bands_=feats_(:,(kk-1)*chnls+1:kk*chnls)'.\feats_(:,(jj-1)*chnls+1:jj*chnls)';
        bands=filloutliers(bands_,'nearest'); % outliers are removed
        imagesc( (t_fit-t0),1:chnls,zscore(bands')',[-2.5 2.5]);
        colormap(jet); axis tight; 
        ylabel([bandname(jj) '/' bandname(kk)],'fontsize',12);  yticklabels({})
        xlim((plot_time));  %%%%%%%%%%%%%
        if kk<feat_num-1 
            xticks([])
        end
        
        mm=mm+1;
    end
end
xlabel('Time (sec)')

subplot(12,1,1:2)

tlim=t0+plot_time;
t_lim=tlim(1)*fs:tlim(2)*fs;
tt=time(t_lim);

plot(tt-t0,eeg(t_lim,k)); title('Raw signal ' );  ylabel('(\muV)'); 
hold on; plot(time(spw_indx)-t0,eeg(spw_indx,k),'+r');  xlim(plot_time)
            title(['File: ' file '  ,  Time reference: ' num2str(t0/60) ' min']);
