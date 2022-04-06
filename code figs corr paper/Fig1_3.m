
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
%%  plot EEG3sec_ to find and ignore noisy chnls
figure
bin_indx=12501; %randsample(size(EEG3sec_,3)-1000,1)+500; % index to the first nREM bin
EEG3sec_n=size(EEG3sec,1);
dist=1.5; % in std
for k=1:16
    plot(round(1:EEG3sec_n)/fs,(EEG3sec(:,k,bin_indx))+dist*k); hold on
end
yticks(2*(1:16)), yticklabels(compose('%01d', 1:16));
ylabel('Channel number')
xlabel('Time (sec)')
title(fname);
%
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

%  connectivity measure: corr matrix fore each bin
% corr_mat_=NaN(size(EEG3sec,2),size(EEG3sec,2),size(EEG3sec,3));
% conn_mat_=NaN(size(EEG3sec,2),size(EEG3sec,2),size(EEG3sec,3));
% mean_conn=NaN(1,size(EEG3sec,3));

% for k=valid_inds
%     [conn_mat_(:,:,k),~,~,~] = infer_network_correlation_analytic(EEG3sec(:,:,k));
%     corr_mat_(:,:,k)=corr(EEG3sec(:,:,k),'type','spearman');
%     mean_conn(k)=mean(tril(corr_mat_(:,:,k),-1),'all');
% end
%% plot of movement, low/high 
t_plot=[.4 4.9]*3600; %%%%%%%%%%% t_lim for plot in seconds
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
plot(t_bins3sec(ind)/60,mov_avg_nan(mov3sec(ind),win),'color',0.3*[1 1 1],'linewidth',1.2); hold on

xlim(t_plot/60); ylim([700 3000]);  xticklabels({}); hold on
area([t_plot(1) light_off_t]/60,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
area([light_on_t t_plot(2)]/60,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
ylabel({'Movement';'(pixlel)'});  
subplot(2,1,2)
plot((t_bins3sec(ind))/3600,mov_avg_nan(LH_valid(ind),win),'linewidth',1.2,'color',[0 0 .9]);
xlim(t_plot/3600); ylim([0 200]); 
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
%% depth of sleep for all channels
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
%% plotting EEG3sec and corr matrix for peak and through times
t_spot=2.978*3600; % time of the snippet
bin_indx=find(abs(t_bins3sec-t_spot)==min(abs(t_bins3sec-t_spot)));
figure
title(fname);
dist=.5; % between channels in the plot , instd
EEG3sec_n=size(EEG3sec,1);
for k=1:16
    plot(round(1:EEG3sec_n)/fs,(EEG3sec(:,k,bin_indx))-dist*k,'color',.5*[1 1 1]); hold on
end
xlabel('Time (sec)')
yticklabels({}); ylim([ -16*dist-.5 0]);  xticks([0 .5 1 1.5 2 2.5 3])

% figure
% title(fname);
% 
% bin_indx=find(abs(t_bins3sec-t_spot)==min(abs(t_bins3sec-t_spot)));
% EEG3sec_n=size(EEG3sec,1);


% to find the EEG amplitude range for the color range:
% low-pass filtering the EEG to have less points
smoother = designfilt('lowpassiir','FilterOrder',4, ...
    'PassbandFrequency',100,'PassbandRipple',0.5, ...
    'SampleRate',fs);
for k=1:16
    eeg_piece=EEG3sec(:,k,bin_indx); c_min=min(eeg_piece(:)); c_max=max(eeg_piece(:));
    y=EEG3sec(:,k,bin_indx)-dist*k;
    col=y+dist*k;
    multicolorloine(round(1:EEG3sec_n)/fs,y,col,[c_min c_max],.7*jet(20),.8); hold on
end
xlabel('Time (sec)')
yticklabels({}); ylim([ -17*dist dist])
xticks([0 .5 1 1.5 2 2.5 3])
% save the vector version of the figure
print(['EEG sample ' fname],'-painters','-depsc');

% figure
% title(fname);
% corr_mat_samp=corr(EEG3sec(:,:,bin_indx),'type','spearman');
% imagesc(corr_mat_samp,[-.25 1]); axis equal; axis tight; yticks([]); xticks([]);
% colorbar; colormap(parula)

%% box plots for the correlation values
% L-L
corr_LL=corr_mat_samp(1:8,1:8);
corr_LL_vals=corr_LL(logical(tril(corr_LL,-1)));
corr_RR=corr_mat_samp(9:16,9:16);
corr_RR_vals=corr_RR(logical(tril(corr_RR,-1)));
corr_LR=corr_mat_samp(1:8,9:16);
corr_LR_vals_=corr_LR(:);
inds_LR=randsample(length(corr_LR_vals_),length(corr_RR_vals));
corr_LR_vals=corr_LR_vals_(inds_LR);
figure
title(fname);
boxplot([corr_LL_vals corr_RR_vals corr_LR_vals],'colors','kkk'); hold on
plot(1+.05*randn(size(corr_LL_vals)),corr_LL_vals,'.','color',[255 200 0]/255,...
    'markersize',17);
plot(2+.05*randn(size(corr_LL_vals)),corr_RR_vals,'.','color',[.3 .4 .9],...
    'markersize',17);
plot(3+.05*randn(size(corr_LL_vals)),corr_LR_vals,'.','color',[.2 .9 .2],...
    'markersize',17);
xticklabels({'Left intrahemisphere','Right intrahemisphere',...
    'Interhemispheric'});
ylabel('Inter-channel correlation')
ylim([-.25 1]);

%% local wave detection
% first designing a filter for smooting the data just to avoid detecting
% multiple redundant peaks when we do peak finding:
smoother = designfilt('lowpassiir','FilterOrder',4, ...
    'PassbandFrequency',20,'PassbandRipple',0.5, ...
    'SampleRate',fs);
local_wave_per_chnl=zeros(size(EEG3sec,2),size(EEG3sec,3));
% go through all the data, find the suprathreshold peaks in all channels:
for epoch=1:size(EEG3sec,3)

    if sum(epoch==valid_inds)==0
        local_wave(epoch)=NaN; continue;
    end
    local_wave(epoch)=0; n=0; % n is number of all detected paired peaks, ...
    % that could be redundant
    peak_position=[]; % peak_position contains the index to the peaks of local waves
    all_peaks=[]; % contains all the candidate peaks for local wave
    % find the times of all the supra-threshold peakes in all channels:
    for ch=1:size(EEG3sec,2)
        smoothedEEG=filtfilt(smoother, EEG3sec(:,ch,epoch));
        supra_thresh=abs(smoothedEEG)>1*thresh/4; % (thresh is 4iqr(eeg))
        [~,peak_inds{ch}]=findpeaks(smoothedEEG.*supra_thresh,'MinPeakDistance',40);
        % at least 90 m sec (40/fs) time diff between consequtive peaks
    end
    
    % find the simultaneous peaks in different channels:
    for ch1=1:size(EEG3sec,2)-1
        all_peaks_ch1=peak_inds{ch1};
        for k=1:length( all_peaks_ch1 )
            peak=all_peaks_ch1(k);
            for ch2=ch1+1:size(EEG3sec,2)
                if min(abs(peak_inds{ch2}-peak),[],'all')<=4 % peaks within 10 ms
                    n=n+1;  all_peaks(n)=peak;
                end
            end
        end
    end
    % now we have all the synchronusly-ocurring peaks, that may be redundant.
    % Therefore now we have to remove the redundancies. For this purpose,
    % we sort all the detected synchronous peaks, and count the number of jumps
    % (diff>2) +1
    sorted_peaks=sort(all_peaks);
    while(length(sorted_peaks)>4)
        % find the first group of simultaneous peaks:
        jump_ind=find(diff(sorted_peaks)>4,1);  % end of the first group of peaks
        if isempty(jump_ind) % if this is the last group of peaks
            break;
        end
        if length(sorted_peaks(1:jump_ind))>=4 & length(sorted_peaks(1:jump_ind))<=12
            % if there are at least 25% chnls with that peak but not more
            % than 75% of chnls
            local_wave(epoch)=local_wave(epoch)+1;
            peak_position(local_wave(epoch))=mean(sorted_peaks(1:jump_ind));
        end
        sorted_peaks=sorted_peaks(jump_ind+1:end); % remove the first group and repeat the ...
        % process for the rest
    end
    local_wave(epoch)=local_wave(epoch)/3; % divided by duration of window
    
    % computing abundance of local waves in each channel
    for ch=1:size(EEG3sec,2)
        if isempty(peak_position)
            break;
        end
        peak_inds_ch=peak_inds{ch};
        for pk=1:length(peak_inds_ch)
            ch_peak=peak_inds_ch(pk);
            if min(abs(peak_position-ch_peak),[],'all')<=8
                local_wave_per_chnl(ch,epoch)=local_wave_per_chnl(ch,epoch)+1;
            end
        end
    end
    local_wave_position{epoch}=peak_position;
    clear   peak_inds
end

%% plot of a sample of detected local waves
% plot of a sample of filtered EEG epoch and the detected local waves and the
% threshold of local wave detection

t_spot=3.537*3600; % time of a peak of the low/high ratio
bin_indx=find(abs(t_bins3sec-t_spot)==min(abs(t_bins3sec-t_spot)));
figure
dist=.4;
title(fname);
EEG3sec_n=size(EEG3sec,1);
for k=1:16
    smoothedEEG=filtfilt(smoother, EEG3sec(:,k,bin_indx));
    plot(round(1:EEG3sec_n)/fs,smoothedEEG-dist*k,'color',.5*[1 1 1]); hold on
end
line([0 3],(-thresh/4-dist)*[1 1],'linestyle','--','color',[.3 .3 1]);
xlabel('Time (sec)')
yticklabels({}); ylim([-17*dist 0]);  xticks([0 .5 1 1.5 2 2.5 3])

t_local_waves=local_wave_position{bin_indx}/fs;
for k=1:length(t_local_waves)
    line([t_local_waves(k) t_local_waves(k)],[-dist*17 0],'linestyle','-','color',[1 .0 .2 .3],'linewidth',2);
end
%% local wave frequency per cannel
figure
title(fname);
im=imread(image_layout);
im=.6*double(rgb2gray(imresize(im,.3)));
imshow(int8(im)); hold on
[x,y]=ginput(16);
xy(:,1)=x; xy(:,2)=y;
cm=autumn(200)*1; % colormap: parula
max_val=max(mean(local_wave_per_chnl(:,valid_inds),2));
for ch=1:size(EEG3sec,2)
    rel_val=mean(local_wave_per_chnl(ch,valid_inds))/max_val;
    scatter1 = scatter(x(ch),y(ch),300,'o','MarkerFaceColor',...
        cm(round(rel_val*200),:),'MarkerEdgeColor',cm(round(rel_val*200),:));
    scatter1.MarkerFaceAlpha = 1; scatter1.MarkerEdgeAlpha =.9;
    hold on
end
set(gcf, 'Position',[200 , 200, 600, 500]);

%% a figure of depth-of-sleep, and local wave abundancy rate

% plot of smOothed data (movement, low/high and connectivity)
figure('position',[680   726   700   250])
title(fname);
t_plot=[0 12.7]*3600; %%%%%%%%%%% t_lim for plot in seconds
ind=t_bins3sec<t_plot(2) & t_bins3sec>t_plot(1);
if length(ind)~=length(valid_inds_logic)
    valid_inds_logic=[valid_inds_logic 0];
end
inds=(ind & valid_inds_logic); % considering the plotting interval and the noise free time points
win=20;

subplot(2,1,1)
plot((t_bins3sec(inds))/60,mov_avg_nan(LH(inds),win),'color',[.5 .5 1],...
    'linewidth',1);
xlim(t_plot/60); ylim([0 max(mov_avg_nan(LH(inds),win),[],'all')+5]); xticklabels({});
hold on
area([t_plot(1) light_off_t]/60,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
ylabel('\bf	(\delta+\theta) / \gamma');  xticks([]);
area([light_on_t t_plot(2)]/60,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
subplot(2,1,2)
plot((t_bins3sec(inds))/3600,mov_avg_nan(local_wave(inds),win),'color',[.2 .2 1 ],...
    'linewidth',1);
xlim(t_plot/3600);
hold on
area([t_plot(1) light_off_t]/3600,[100 100],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);  xticks([]);
area([light_on_t t_plot(2)]/3600,[100 100],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);  xticks([]);
ylabel({'local wave / sec'});  ylim([0 3.5]);
xticks([0:12])
xlabel('Time (h)');
print(['sleep depth and local wave incidence ' fname],'-painters','-depsc');

%% save the figure
print(['fig 1 supplementary depth variable accross channels' ],'-dsvg');

%% correlational plots
y1=mov_avg_nan(local_wave(valid_inds)',win)';
x=LH(valid_inds)';
x_=x(1:10:end);  y1_=y1(1:10:end); 
f1=fit(x_, y1_, 'poly1', 'Exclude', x_ > 4*iqr(x_));
figure
title(fname);
plot(f1,x_,y1_)
xlim([0 4*iqr(x_)]);   xlabel('\bf	(\delta+\theta) / \gamma')
ylabel('Local wave / sec');

figure
title(fname);
plot(f1,x_)
xlim([0 4*iqr(x_)]);
xlabel('\bf	(\delta+\theta) / \gamma')
ylabel('Network Density');

%% EEG plot of snapshots of wave spread
% 
t_win=1.848*3600; % time of the 3-sec EEG window
t_samp=0.65; % sample time in that window
t1sec=1/fs:1/fs:1;
t_samp_ind=find(abs(t1sec-t_samp)==min(abs(t1sec-t_samp)));
bin_indx=find(abs(t_bins3sec-t_win)==min(abs(t_bins3sec-t_win)));
EEG3sec_n=round(size(EEG3sec,1)/3);
wave_samps=t_samp_ind:t_samp_ind+round(fs/10); % the sample indices in 100 ms of wave
    min_col=min(EEG3sec(wave_samps,:,bin_indx),[],'all');
    max_col=max(EEG3sec(wave_samps,:,bin_indx),[],'all');
figure
title(fname);
cm=(hot(40))*.9; % colormap
for k=1:16
    y_=EEG3sec(:,k,bin_indx)-.6*k;
    t_=round(1:EEG3sec_n)/fs;
    col=y_+.6*k;
    multicolorloine(t_,y_,col,[min_col max_col],cm,1.5); hold on
    plot((1:t_samp_ind-1)/fs,(EEG3sec(1:t_samp_ind-1,k,bin_indx))-.6*k,'color',...
        .7*[1 1 1]);
    plot((t_samp_ind+48:EEG3sec_n)/fs,(EEG3sec(t_samp_ind+48:EEG3sec_n,...
        k,bin_indx))-.6*k,'color',.7*[1 1 1], 'linewidth',1);
end
line([t_samp t_samp],[-17*.6 0],'color',.3*[1 1 1],'linestyle','--');
line([t_samp+47/fs t_samp+47/fs],[-17*.6 0],'color',.3*[1 1 1],'linestyle','--');

line('linestyle','-')
xlabel('Time (sec)')
yticklabels({}); ylim([ -16*.6-.5 0]); xlim(t_samp+[-.05 .15])  

%% snapshot plot
figure
title(fname);
im=imread(image_layout);
im=.6*double(rgb2gray(imresize(im,.3)));
imshow(int8(im)); hold on
% [x11,y11]=ginput(2);
figure
title(fname);
set(gcf, 'Position', .8*[50,50,1400,800]);

bin_indx=find(abs(t_bins3sec-t_win)==min(abs(t_bins3sec-t_win)));
im=imread(image_layout);
im=.7*double(rgb2gray(imresize(im,.3)));
m=min(EEG3sec(wave_samps,:,bin_indx),[],'all');
r=range(EEG3sec(wave_samps,:,bin_indx),'all');

for k=1:48 % number of snapshots in 100 ms
    subplot(6,8,k)
    imshow(int8(im)); 
    hold on
    for ch=1:size(EEG3sec,2)
        volt=EEG3sec(t_samp_ind+k-1,ch,bin_indx);
        scatter1 = scatter(x(ch),y(ch),40,'o','MarkerFaceColor',...
            cm(ceil(40*(volt-m+eps)/(r+10*eps)),:),'MarkerEdgeColor',...
            cm(ceil(40*(volt-m+eps)/(r+10*eps)),:));
    end
    if rem(k-1,8)==0
            text(20,275,[num2str(round((t_(k)-t_(1))*10000)/10) ' ms']);
    else
            text(20,275,[num2str(round((t_(k)-t_(1))*10000)/10)]);
    end
end
% removing the spacing between subplots
h=get(gcf,'children');
for k=1:48
 set(h(k),'position',.8*[.7-.07*rem(k-1,8) .1+.18*floor((k-1)/8) .15 .135])
end
% saving the figure as vector format image
f_name='C:\Users\Spike Sorting\Desktop\Fig. 3\ snapshot';
print( '-depsc', '-r300', '-painters', f_name);
%% mean traveling wave trajectory
% t_win=86.02*60; % time of the 3-sec EEG window
% t_samp=0; % sample time in that window
n_sample=round(fs/10); % number of data samples to plot
cmap=parula;
figure
title(fname);
hold on

% computing of the mean trajectory point at each time point
clear x_meanl y_meanl x_meanr y_meanr
for k=1:round(fs/10)
        volt=EEG3sec(t_samp_ind+k-1,:,bin_indx);
        x_meanl(k)=volt(1:8)*x(1:8)/sum(volt(1:8));
        y_meanl(k)=volt(1:8)*y(1:8)/sum(volt(1:8));
        volt_meanl(k)=sum(volt(1:8));
        x_meanr(k)=volt(9:16)*x(9:16)/sum(volt(9:16));
        y_meanr(k)=volt(9:16)*y(9:16)/sum(volt(9:16));
        volt_meanr(k)=sum(volt(9:16));
end


% mapping out recording sites layout
for ch=1:size(EEG3sec,2)
        scatter1 = scatter(x(ch),y(ch),400,'o','MarkerFaceColor',[.5 .6 .8],...
            'MarkerEdgeColor',.5*[1 1 1],'MarkerFaceAlpha',.3,...
            'MarkerEdgeAlpha',.2);
end
axis ij

% adding the smoothed trajectory line
% picking the points that are not outlier
n_valid_r=find( (x_meanr<median(x_meanr)+2*iqr(x_meanr) & ...
    x_meanr>median(x_meanr)-2*iqr(x_meanr)) & ...
(y_meanr<median(y_meanr)+2*iqr(y_meanr) & ...
    y_meanr>median(y_meanr)-2*iqr(y_meanr)) );
n_valid_l=find( (x_meanl<median(x_meanl)+2*iqr(x_meanl) & ...
    x_meanl>median(x_meanl)-2*iqr(x_meanl)) & ...
(y_meanl<median(y_meanl)+2*iqr(y_meanl) & ...
    y_meanl>median(y_meanl)-2*iqr(y_meanl)) );

% interpolating to find the smoothed curve
[x_meanr_interp, ~, ~] = fit(n_valid_r',x_meanr(n_valid_r)',...
    'smoothingspline');
[y_meanr_interp, ~, ~] = fit(n_valid_r',y_meanr(n_valid_r)',...
    'smoothingspline');
plot(x_meanr_interp(1:1:n_sample),y_meanr_interp(1:1:n_sample),'linewidth',2);

[x_meanl_interp, ~, ~] = fit(n_valid_l',x_meanl(n_valid_l)',...
    'smoothingspline');
[y_meanl_interp, ~, ~] = fit(n_valid_l',y_meanl(n_valid_l)',...
    'smoothingspline');

% plotting the interpolated smoothed trajectory
multicolorloine(x_meanl_interp(1:1:n_sample),y_meanl_interp(1:1:n_sample),...
    1:n_sample,[1 n_sample], cmap,3,'none','-',.1); 
multicolorloine(x_meanr_interp(1:1:n_sample),y_meanr_interp(1:1:n_sample),...
    1:n_sample,[1 n_sample], cmap,3,'none','-',.1); 
% saving the figure as vector format image
axis equal
colormap(cmap)
colorbar
f_name='C:\Users\Spike Sorting\Desktop\Fig. 3\ mean_volt_trajec 3sec';
print( '-depsc', '-r300', '-painters', f_name);

