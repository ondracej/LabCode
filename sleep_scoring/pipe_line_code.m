fs=30000/64;
chnl=4;
if exist('EEG_','var')
    EEG=EEG_;
end
% reshaping data in 3 sec windows, in case bins are 1.5 sec
if length(mov)>27000
new_len=floor(size(EEG,3)/2);
EEG3sec=zeros(size(EEG,1)*2,size(EEG,2),new_len);
for k=1:new_len
    EEG3sec(:,:,k)=[EEG(:,:,2*k-1);EEG(:,:,2*k)];
end
t_bins3sec=downsample(t_bins,2)+1.5/2;
mov3sec=downsample((mov+circshift(mov,-1))/2, 2);
else
mov3sec=mov;
EEG3sec=EEG;
t_bins3sec=t_bins;
end
mov3sec=mov3sec(1:size(EEG3sec,3));
clear t_bins mov k feats EEG auto_label

%%  plot EEG3sec_ to find and ignore noisy chnls
figure
bin_indx=9501; %randsample(size(EEG3sec_,3)-1000,1)+500; % index to the first nREM bin
EEG3sec_n=size(EEG3sec,1);
dist=1; % in std
for k=1:16
    plot(round(1:EEG3sec_n)/fs,(EEG3sec(:,k,bin_indx))+dist*k); hold on
end
yticks(2*(1:16)), yticklabels(compose('%01d', 1:16));
ylabel('Channel number')
xlabel('Time (sec)')
title(fname);

% defining a threshold for removing the EEG samples with artefact
eeg=reshape(EEG3sec(:,chnl,:),[1,size(EEG3sec,1)*size(EEG3sec,3)]);
thresh=4*iqr(eeg);
maxes_=max(abs(EEG3sec(:,chnl,:)),[],1);
maxes=reshape(maxes_,[1,length(maxes_)]);
thresh_mov=median(mov3sec)+5*iqr(mov3sec); % threshold for separating wakes from sleep based on movement
valid_inds=find(maxes<thresh & mov3sec'<thresh_mov);
valid_inds_logic=(maxes<thresh & mov3sec'<thresh_mov);
% add the threshold line to the EEG plot
line([1/fs,EEG3sec_n/fs],[dist*chnl+thresh dist*chnl+thresh],'linestyle','--');
line([1/fs,EEG3sec_n/fs],[dist*chnl-thresh dist*chnl-thresh],'linestyle','--');
print(['Z:\zoologie\HamedData\CorrelationPaper\BirdsOverview\eeg ' fname],'-dpng')
%% extracting low/high ratio (LH)
fs=30000/64;
LH=NaN(1,size(EEG3sec,3)); % low/high freq ratio
for k=1:size(EEG3sec,3)
    % settings for multitaper
    nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
    [pxx,f]=pmtm(EEG3sec(:,chnl,k),TW,nfft,round(fs));
    px_low=norm(pxx(f<8 & f>1.5));
    px_high=norm(pxx(f<49 & f>30));
    LH(k)=px_low/px_high;
end

%  connectivity measure: corr matrix fore each bin
% corr_mat_=NaN(size(EEG3sec,2),size(EEG3sec,2),size(EEG3sec,3));
% conn_mat_=NaN(size(EEG3sec,2),size(EEG3sec,2),size(EEG3sec,3));
% mean_conn=NaN(1,size(EEG3sec,3));
% 
% for k=valid_inds
%     [conn_mat_(:,:,k),~,~,~] = infer_network_correlation_analytic(EEG3sec(:,:,k));
%     corr_mat_(:,:,k)=corr(EEG3sec(:,:,k),'type','spearman');
%     mean_conn(k)=mean(tril(corr_mat_(:,:,k),-1),'all');
% end
% plot of movement, low/high and connectivity
t_plot=[0 t_bins3sec(end)-60]; %%%%%%%%%%% t_lim for plot in seconds
ind=t_bins3sec<t_plot(2) & t_bins3sec>t_plot(1);
mov_valid=NaN(size(mov3sec));
mov_valid(valid_inds)=mov3sec(valid_inds);
LH_valid=NaN(size(LH));
LH_valid(valid_inds)=LH(valid_inds);
%% plot of smoothed data (movement, low/high)
figure
title(fname);
win=20; % win length for smoothing
subplot(2,1,1)
plot(t_bins3sec(ind)/60,mov_avg_nan(mov3sec(ind),win),'color',0.3*[1 1 1],'linewidth',1.2); hold on
xlim(t_plot/60);
 xticklabels({}); hold on
max_y=max(mov_avg_nan(mov3sec(ind),win),[],'all');
min_y=min(mov_avg_nan(mov3sec(ind),win),[],'all');
area([t_plot(1) light_off_t]/60,[max_y max_y],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
area([light_on_t t_plot(2)]/60,[max_y max_y]+10,'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);

ylim([min_y-100 max_y+100]);
ylabel({'Movement';'(pixlel)'});  
subplot(2,1,2)
plot((t_bins3sec(ind))/3600,mov_avg_nan(LH_valid(ind),win),'linewidth',1.2,'color',[0 0 .9]);
max_y=max(mov_avg_nan(LH_valid(ind),win),[],'all');
xlim(t_plot/3600);   ylim([0 max_y]); 
hold on
area([t_plot(1) light_off_t]/3600,[max_y max_y]+10,'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
area([light_on_t t_plot(2)]/3600,[max_y max_y]+10,'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
ylabel('\bf	(\delta+\theta) / \gamma'); ylim([0 max_y+10]);
xlabel('Time (h)');

% defining and adding the line of deliniating wake/sleep
% we feat a distribution and find the peak and std of the REM group
pd=fitdist(mov3sec,'kernel');
x_vals=min(mov3sec):range(mov3sec)/2000:mean(mov3sec)+5*std(mov3sec);
mov_pd=pdf(pd,x_vals);
[M,I] = max(mov_pd); mov_peack=x_vals(I);
threshold=mov_peack+1*iqr(mov3sec); % threshold on movement to differentiate Wake/REM
subplot(2,1,1)
line(t_plot/60,[threshold threshold],'linestyle','--');
print(['Z:\zoologie\HamedData\CorrelationPaper\BirdsOverview\depth ' fname],'-dpng')

