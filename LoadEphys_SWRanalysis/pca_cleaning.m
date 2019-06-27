%% filtering with PCA
samps=min(round(fs*3600/2),length(EMG)); % maximum number of data samples to estimate correlation matrix is limited to half an hour of data 
data=[EMG(1:samps) , EEG(1:samps,:)]; 
[eigenvec, ~ , vars] = pca(data); clear data;
plot_time=[5*3600 6*3600];
samps=plot_time(1)*fs : plot_time(2)*fs ;
data=[EMG(samps) , EEG(samps,:)];
PC=(eigenvec'*data')';
figure('Position', pixls);  
for n=1:nn 
subplot(nn,1,n)
plotredu(@plot,time(samps),PC(:,n)); 
ylabel({'PC ' num2str(n) });  xlim(plot_time);  xticks([]);
end

% PC-data correcfations
figure;
X=reshape(repmat(1:nn,nn,1),nn*nn,1);   
Y=reshape(repmat((1:nn)',1,nn),nn*nn,1); 
scatter(X,Y,100*(reshape(corr(PC,data),nn*nn,1)-min(min(corr(PC,data)))+eps),reshape(corr(PC,data),nn*nn,1)   ,'filled'); 
ylabel('PC'); xlabel('data'); colorbar ; colormap('jet')
title('correlation between PCs and channels')

emg_pc=[2 3];
PC(:, emg_pc)=zeros(length(PC),length(emg_pc));
data_cln=(eigenvec*PC')';
figure('Position', pixls);  
for n=1:nn 
subplot(nn,1,n)
plotredu(@plot,time(samps),data_cln(:,n)); 
ylabel({'chnl_n_e_w ' num2str(n) });  xlim(plot_time);  xticks([]);
end