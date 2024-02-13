
clear;

fname='73-03_09_03_scoring';
load(fname);
light_off_t=31000/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=889160/20;  %%%%%%%%%%% frame number devided by rate of acquisition

% fname='w0020_25_09_scoring'; 
% load(fname);
% light_off_t=35580/20; %%%%%%%%%%% frame number devided by rate of acquisition
% light_on_t=900200/20;  %%%%%%%%%%% frame number devided by rate of acquisition

fs=30000/64;

chnl=4; % non-noisy channel
% reshaping data in 3 sec windows, in case bins are 1.5 sec
if exist('EEG3sec','var')==0
    if exist('EEG_','var')==1
        EEG=EEG_;
    elseif exist('eeg_adc','var')
        EEG=eeg_adc;
    end
    if size(EEG,3)>27000
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
        % t_bins3sec=t_bins;
    end
else
    mov3sec=mov;
    
end

if length(EEG3sec)>=length(mov3sec) && exist('t_diff','var') % this is true if the synchronizing pulse has worked correctly
    EEG3sec=EEG3sec(:,:,round(t_diff/3)+1:end);
    EEG3sec=EEG3sec(:,:,1:length(mov3sec));
else
    mov3sec=mov3sec(1:size(EEG3sec,3));
end

clear t_bins mov k feats EEG auto_label

% finding the bins when the bird is not moving too much (is not wake) and EEG is without movement artefact  
eeg=reshape(EEG3sec(:,chnl,:),[1,size(EEG3sec,1)*size(EEG3sec,3)]);
thresh=4*iqr(eeg);
maxes_=max(abs(EEG3sec(:,chnl,:)),[],1);
maxes=reshape(maxes_,[1,length(maxes_)]);
if exist('t_diff','var') % in case that we dont have the synchronizing signal
    valid_inds=find(maxes<thresh );
    valid_inds_logic=(maxes<thresh );
else
    thresh_mov=median(mov3sec)+5*iqr(mov3sec); % threshold for separating wakes from sleep based on movement
    valid_inds=find(maxes<thresh & mov3sec'<thresh_mov);
    valid_inds_logic=(maxes<thresh & mov3sec'<thresh_mov);
end

% defining a threshold for removing the EEG samples with artefact and wake
% snippets
eeg=reshape(EEG3sec(:,chnl,:),[1,size(EEG3sec,1)*size(EEG3sec,3)]);
thresh=4*iqr(eeg);
maxes_=max(abs(EEG3sec(:,chnl,:)),[],1);
maxes=reshape(maxes_,[1,length(maxes_)]);
thresh_mov=median(mov3sec)+3*iqr(mov3sec); % threshold for separating wakes from sleep based on movement
valid_inds=find(maxes<thresh & mov3sec'<thresh_mov);
valid_inds_logic=(maxes<thresh & mov3sec'<thresh_mov);
% add the threshold line to the EEG plot
line([1/fs,EEG3sec_n/fs],[dist*chnl+thresh dist*chnl+thresh],'linestyle','--');
line([1/fs,EEG3sec_n/fs],[dist*chnl-thresh dist*chnl-thresh],'linestyle','--');

%% extracting low/high ratio (continuous depth of sleep index)
fs=30000/64; % initial sampling rate devided by downsampling factor
LH=NaN(1,size(EEG3sec,3)); % low/high freq ratio
for k=1:size(EEG3sec,3)
    % settings for multitaper
    nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
    [pxx,f]=pmtm(EEG3sec(:,chnl,k),TW,nfft,round(fs));
    px_low=norm(pxx(f<8 & f>1.5)); % delta and theta power (below 1.5 could me polluted with noise artefacts [Rattenborg, 2019, Sleep])
    px_high=norm(pxx(f<49 & f>30)); % (low) gamma
    LH(k)=px_low/px_high;
end

%% Fig. 1B     plot of movement, low/high 
t_plot=[.62 4.05]*3600; %%%%%%%%%%% t_lim for plot in seconds
ind=t_bins3sec<t_plot(2) & t_bins3sec>t_plot(1);
mov_valid=NaN(size(mov3sec));
mov_valid(valid_inds)=mov3sec(valid_inds);
LH_valid=NaN(size(LH));
LH_valid(valid_inds)=LH(valid_inds);
% plot of smothed data (movement, low/high and connectivity)
figure
title(fname);
win=20; % win length for smoothing
subplot(2,1,1)
plot(t_bins3sec(ind),mov_avg_nan(mov3sec(ind),win),'color',0.3*[1 1 1],'linewidth',1.2); hold on

xlim(t_plot); ylim([700 3000]);  xticklabels({}); hold on
area([t_plot(1) light_off_t]/60,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
area([light_on_t t_plot(2)]/60,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
ylabel({'Movement';'(pixlel)'});  
subplot(2,1,2)
plot((t_bins3sec(ind))/60,mov_avg_nan(LH_valid(ind),win),'linewidth',1.2,'color',[0 0 0]);
xlim(t_plot/60); ylim([0 200]); 
hold on
area([t_plot(1) light_off_t]/3600,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
area([light_on_t t_plot(2)]/3600,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
ylabel('\bf	(\delta+\theta) / \gamma');  
xlabel('Time (h)')


% defining and adding the line of deliniating wake/sleep
% we feat a distribution and find the peak and std of the REM group
pd=fitdist(mov3sec,'kernel');
x_vals=min(mov3sec):range(mov3sec)/2000:mean(mov3sec)+5*std(mov3sec);
mov_pd=pdf(pd,x_vals);
[M,I] = max(mov_pd); mov_peack=x_vals(I);
threshold=mov_peack+1*iqr(mov3sec); % threshold on movement to differentiate Wake/REM
subplot(2,1,1)
line(t_plot/60,[threshold threshold],'linestyle','--');
print(['mov and depth' fname],'-painters','-depsc');
%% Fig. 1D   depth of sleep for all channels
t_plot=[0 5]*3600; %%%%%%%%%%% t_lim for plot in seconds
ind=find(t_bins3sec<t_plot(2) & t_bins3sec>t_plot(1));

LH_t_plot=NaN(16,length(ind)); % low/high freq ratio, first filled with NaN, and then in the indeces that are in the t_plot and valid ...
% (artefact-free) we put the corresponding value of the LH
ind_valid_t_plot=intersect(valid_inds,ind); % indeces that are in the t_plot and valid (artefact-free)
for ch=1:16
for k=ind_valid_t_plot % only for the tplot time compute the LH
    % settings for multitaper
    nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
    [pxx,f]=pmtm(EEG3sec(:,ch,k),TW,nfft,round(fs));
    px_low=norm(pxx(f<8 & f>1.5));
    px_high=norm(pxx(f<49 & f>30));
    LH_t_plot(ch,k-(ind(1)-1))=px_low/px_high; 
end
end
% figure for the sleep depth across channels
t_plot=[0 5]*3600; %%%%%%%%%%% t_lim for plot in seconds
ind=find(t_bins3sec<t_plot(2) & t_bins3sec>t_plot(1));

figure
title(fname);
dist=1; % spacing between the channels on the EEG plot 
win=20; % win length for smoothing
for ch=[2 7 11 16]
HL_ch=mov_avg_nan(LH_t_plot(ch,:),win);
HL_toplot=NaN(size(HL_ch));
HL_toplot(~isnan(HL_ch))=(HL_ch(~isnan(HL_ch))-mean(HL_ch(~isnan(HL_ch))))/std(HL_ch(~isnan(HL_ch)));
plot((t_bins3sec(ind))/3600,HL_toplot+dist*ch,'linewidth',1,'color',[0*(1-ch/16) 1*(1-ch/16) 1*(ch/16) .8]); % 
hold on
end

xlim(t_plot/3600); ylim([-3 24]);
area([t_plot(1) light_off_t]/3600,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
ylabel('normalized \bf	(\delta+\theta) / \gamma'); 
xlabel('Time (h)');
print(['depth 4 channel adult' fname],'-painters','-depsc');
% statistics of DOS from different channels
nonnan=~isnan(sum(LH_t_plot));
cc16=corrcoef(LH_t_plot(:,nonnan)');
cc16_nondiag=cc16(find(tril(cc16,-1)));
mean(cc16_nondiag)
std(cc16_nondiag)
%% Fig. 1C    plotting EEG3sec example for high  

% low-pass filtering the EEG 
smoother = designfilt('lowpassiir','FilterOrder',4, ...
    'PassbandFrequency',100,'PassbandRipple',0.5, ...
    'SampleRate',fs);

t_spot=126.45*60; % time of the snippet
bin_indx=find(abs(t_bins3sec-t_spot)==min(abs(t_bins3sec-t_spot)));
figure('position',[200 300 350 250])
title(fname);
dist=.3; % between channels in the plot , instd
EEG3sec_n=size(EEG3sec,1);

for k=1:16
    plot((round(1:EEG3sec_n)/fs),(eeg_to_plot(:,k))-dist*k,'color',.1*[1 1 1]); hold on
end
xlabel('Time (sec)')
yticklabels({}); ylim([ -16*dist-.5 0]);  xticks([0 .5 1 1.5 2 2.5 3])


