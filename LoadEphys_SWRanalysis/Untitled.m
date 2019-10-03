%% computing ratios
bandname={'\delta', '\theta', '\alpha', '\beta', '\gamma'};
t0=4300+1770;  plot_time=[0 60]; %%%%%%%%%%%
figure
chnls=5; %%%%%%%%%%%%
mm=1;
for kk=3:4 % from alpha to beta
    for jj=kk+1:5
        subplot(3,1,mm); 
        bands_=feats_(:,(kk-1)*chnls+1:kk*chnls)'./feats_(:,(jj-1)*chnls+1:jj*chnls)';
        bands=filloutliers(bands_,'nearest',2); % outliers are removed
        imagesc( (t_fit-t0)/60,1:chnls,zscore(bands')');
        colormap(jet); axis tight; 
        ylabel([bandname(kk) '/' bandname(jj)],'fontsize',12);  yticklabels({})
        xlim((plot_time)/60) %%%%%%%%%%%%%
        if mm==1
            title(['File: ' file '  ,  Time reference: ' num2str(t0) ' sec']);
        end
        mm=mm+1;
    end
end
xlabel('Time (min)')
