%% Loading EEG
clear all
addpath(genpath('D:\github\Lab Code\P1_16chnl'));
addpath(genpath('D:\github\Lab Code\Respiration VideoAnalysis'));
addpath(genpath('D:\github\Lab Code\LoadEphys_SWRanalysis'));

dir_path='G:\Hamed\zf\P1\72-00\18-03-2020'; %%%%%%%% ephys directory
folder_path='G:\Hamed\zf\P1\w0020 juv'; %%%%%%%%%% video folder
fname='converted_25_09_2020_00168'; %%%%%%%%%%%% video file name
dir_prefix='133'; %%%%%%%%% prefix of .continuous files, e.g. the '142' in 142_CH
roi_y=1:1024;  roi_x=1:1280; %%%%%%%%%%%%% ROI (starting from top left)
% position of recording sites on the photo:
xy=[103  201
    83   229
    62   200
    45   219
    48   166
    67   130
   114   112
   113   136
   167   136
   169   110
   210   133
   227   172
   215   207
   190   227
   220   227
   165   209]; 
image_layout='G:\Hamed\zf\P1\w0020 juv\w0020 layout.jpg'; %%%%%%% image indicating electrode sites
% Based on the 'default order', enter the chnls
chnl_order=[1 2 3 4 5 6 8 7 10 9 11 12 14 16 13 15];  %%%%%%%%%%%%% as compared to default mapping
t_off=[0 19 45];
t_on=[8 20 6];

%% loading OpenEphys file (EEG and ADC):
% downsample with a factor of 15
[ EEG,time,~]=OpenEphys2MAT_load_save_Data(chnl_order, [dir_prefix '_CH'],15,dir_path); 

% loading synchroniying ADC channel
[ ADC, time_adc, ~]=OpenEphys2MAT_load_save_Data(1, [dir_prefix '_ADC'],1,dir_path);
fs=2000;

%Extracting synchroniying times of frames
[peak_indx]=find(ADC.*(ADC>4));
jumps_to_new_frame_indx=[diff(peak_indx)>5; true];
unique_peak_indx=peak_indx(jumps_to_new_frame_indx);
t_frames=time_adc(unique_peak_indx);
clear ADC time_adc peak_indx unique_peak_indx

%% loading video data
vid=VideoReader([folder_path '\' fname '.avi']);

% selecting frame range for processig
% n=vid.NumFrames; % this is an estimation of number of frame, to be safe consider ...
% something like 500 fewer frames as the last frame
n=vid.NumFrames; % this is an estimation of number of frame, to be safe consider ...
f0=floor(1); % 1st frame %%%%%%%%%

fn=floor(n)-1000; % last frame %%%%%%%%%%
f_path=[folder_path '\' fname '.avi'];
frames=f0: fn; % frames to be analyzed
[r_dif,acc_dif, last_im, last_dif] = birdvid_move_extract(f_path,frames,roi_y,roi_x);
t_frame=t_frames(f0:fn);  clear t_frames;
r_dif=r_dif(f0:fn); % cut the zeroes at the beginning so it matches t_frame
r_dif_med_removed=movmean(r_dif-movmedian(r_dif,.5*20),.5*20); % smooth data for .5 sec

% load handel.mat;sound(y, Fs); % notifying the end of video computation

%%  raw plot of all channels 

figure;
set(gcf, 'Position',  [100, 50, 1700, 900])
t0=9100; %%%%%%%%%%  starting time for plot in secinds
t_limm=t0 + [0 30]; 
eegs=EEG((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs , :);
t_eegs=time((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs);
dist=.6*std( EEG(randi(length(EEG),1,10000),1));
for n=1:size(eegs,2)
plot(t_eegs,eegs(:,n)+(n-1)*dist);  hold on
if n==1
    title(['File: ' folder_path '\' ]);
end
end
t_limm=t0 + [0 30]; 

xlim(t_limm); ylim([-1 17]*dist)

%% Spectrogram values and band powers for Plots
clear sig_bandR sig_bandL
% Left and right hemisphere spectrogram and movement
addpath(genpath('D:\github\chronux_2_12'));
winstep=.5;
movingwin=[2 , winstep]; % [winsize winstep] 
params.tapers=[5 10]; % [W*T , (tapers < 2W*T-1)]
params.fpass=[.5 100];
params.Fs=fs;
t_lim=18500+[0 3000]; %%%%%%%%%%%%    time snippet for plottings
eegL=EEG((t_lim(1)-time(1))*fs+1:(t_lim(2)-time(1))*fs , 5); %%%%%%%%%
[SL,t,f] = mtspecgramc( eegL, movingwin, params );
eegR=EEG((t_lim(1)-time(1))*fs+1:(t_lim(2)-time(1))*fs , 13); %%%%%%%%%%
[SR,~,~] = mtspecgramc( eegR, movingwin, params );
t_eeg=time((t_lim(1)-time(1))*fs+1:(t_lim(2)-time(1))*fs);
% band powers
bands=[1,4; 4,8; 8,13; 13,30; 30,55];
for k=1:5    
    [b,a]= butter(2,bands(k,:)/fs);
    sig_bandR(:,k)=movmean(abs(filtfilt(b,a,eegR)),fs*5); %%%%%%%% smoothed for 5 sec
    sig_bandL(:,k)=movmean(abs(filtfilt(b,a,eegL)),fs*5); %%%%%%%% smoothed for 5 sec
end
delta=1; theta=2; alpha=3; beta=4; gamma=5;
%% plots of spectrogram, power ratioes and movement
figure; 
set(gcf, 'Position',  [100, 400, 1800, 500])
ax1 = axes('Position',[0.1 0.84 0.85 0.14]);
SL_plot=20*log10(abs(SL))';
color_range=median(SL_plot(:))+[-5*iqr(SL_plot(:)) 5*iqr(SL_plot(:))];
imagesc(ax1,'xdata',(t+t_lim(1))/3600,'ydata',f,'cdata',SL_plot,color_range); 
shading interp; 
ylabel(ax1,{'Power (dB)', 'Hz'}); xlim(t_lim/3600);  ylim([0 30]);  colormap('jet')
ax1.ActivePositionProperty = 'outerposition';
title(ax1,'L hemisphere spectrogram')

ax2 = axes('Position',[0.1 0.65 0.85 0.14]);
SR_plot=20*log10(abs(SR))';
imagesc(ax2,'xdata',(t+t_lim(1))/3600,'ydata',f,'cdata',SR_plot,color_range); 
shading interp; 
ylabel(ax2,{'Power (dB)', 'Hz'}); xlim(t_lim/3600);  ylim([0 30]); 
ax2.ActivePositionProperty = 'outerposition';
title(ax2,'R hemisphere spectrogram')

ax3 = axes('Position',[0.1 0.45 0.85 0.15]);
rat1=sig_bandL(:,theta)./sig_bandL(gamma);
plot( t_eeg/3600, rat1 ); xlim(t_lim/3600);
title(ax3,'L \theta / \gamma'); ylim(median(rat1)+iqr(rat1)*[-1.5 2.7])

ax4 = axes('Position',[0.1 0.25 0.85 0.15]);
rat2=sig_bandR(:,theta)./sig_bandR(gamma);
plot( t_eeg/3600, rat2 ); xlim(t_lim/3600);
title(ax4,'R \theta / \gamma'); ylim(median(rat2)+iqr(rat2)*[-1.5 2.7])

ax5=axes('Position',[0.1 0.05 0.85 0.15]); %%%%%%%%% smothed for 5 sec
plot(t_frame/3600,r_dif_med_removed); xlim(t_lim/3600); 
ylim(ax5,median(r_dif_med_removed)+[-20 200]);
title(ax5,'Movement'); xlabel('Time (h)')

% updating the previous plots indicating the inset time and raw plot of snippets
snippet_times=round([ .17 ]*3600)+t_lim(1);
winsize=30;
for k=1:length(snippet_times)
t_limm=snippet_times(k);
rectangle(ax5,'Position',[t_limm/3600, median(r_dif_med_removed)-95, winsize/3600,50],...
    'FaceColor','k')
rectangle(ax4,'Position',[t_limm/3600, 0.005 , winsize/3600,.05],'FaceColor','k')
rectangle(ax3,'Position',[t_limm/3600, 0.005, winsize/3600,0.03],'FaceColor','k')
end

% raw plot of all channels
for k=1:length(snippet_times)
figure;
set(gcf, 'Position',  [100, 50, 1700, 900])
t_limm=snippet_times(k)+[0 winsize]+60;
eegs=EEG((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs , :);
t_eegs=time((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs);
dist=5;%*std( eegL(randi(length(eegs),1,10000),1));
for n=1:16
plot(t_eegs,zscore(eegs(:,n))+(n-1)*dist);  hold on
if n==1
    scal=round(mean(std(eegs)));
    title(['EEG zscores (scaled by: ' num2str(scal) ')     File: ' folder_path  ]);
end
end
xlim(t_limm); ylim([-1 17]*dist)
end

% correlation matrix
figure;
snippet_times=round([ .168 ]*3600)+t_lim(1);
t_limm=snippet_times(k)+[0 60]
eeg_corr=zscore(EEG((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs , :));
rho(:,:,k)=corr(eeg_corr,'type','spearman');
imagesc(rho(:,:,k),[.2 1]); colorbar; axis square; colormap('parula')
xticks([4 12]); xticklabels({'L' , 'R'})
yticks([4 12]); yticklabels({'L' , 'R'})

%% correlation over time (calculation) averaged across all chnls in each hemisphere
clear ll_corr lr_corr rr_corr
for k=t_lim(1):1:t_lim(end)
    k
indx=time>k-5 & time<=k;
eeg_temp=zscore(EEG(indx,:));
rho_all=corr(eeg_temp,'type','spearman');
ll_corr(k)=(sum(rho_all(1:8,1:8),'All')-8)/56;
lr_corr(k)=sum(rho_all(1:8,9:16),'All')/64;
rr_corr(k)=(sum(rho_all(9:16,9:16),'All')-8)/56;
end
% correlation over time (plot)
figure
subplot(6,1,1)
plot([ zeros(1,t_lim(1)-1) t_lim(1):t_lim(end)]/3600,ll_corr); xlim(t_lim/3600); title('L-L Corr') 
ylim([.75 .9])
subplot(6,1,2)
plot([ zeros(1,t_lim(1)-1) t_lim(1):t_lim(end)]/3600,rr_corr); xlim(t_lim/3600); title('R-R Corr') 
ylim([.7 .9])
subplot(6,1,3)
plot([ zeros(1,t_lim(1)-1) t_lim(1):t_lim(end)]/3600,lr_corr); xlim(t_lim/3600); title('L-R Corr')
ylim([.2 .8])
subplot(6,1,4)
plot( t_eeg/3600, mean(sig_bandL(:,theta)./sig_bandL(gamma),2) ); xlim(t_lim/3600);
title('L \theta / \gamma'); ylim([0.2 1.4])
subplot(6,1,5)
plot( t_eeg/3600, mean(sig_bandR(:,theta)./sig_bandR(gamma),2) ); xlim(t_lim/3600);
title('R \theta / \gamma'); ylim([0.2 2])
subplot(6,1,6)
plot(t_frame/3600,r_dif_med_removed); xlim(t_lim/3600); 
title('Movement'); xlabel('Time (h)'); ylim([0 200])

%% correlation over time (calculation) just between 2 chnls
clear ll_corr_ lr_corr_ rr_corr_
for k=t_lim(1):1:t_lim(end)
    if rem(k,50)==0
         k
    end
indx=time>k-5 & time<=k;
eeg_temp=zscore(EEG(indx,:));
ll_corr_(k)=corr(eeg_temp(:,1),eeg_temp(:,8),'type','spearman');
lr_corr_(k)=corr(eeg_temp(:,8),eeg_temp(:,9),'type','spearman');
rr_corr_(k)=corr(eeg_temp(:,9),eeg_temp(:,16),'type','spearman');
end
%% correlation over time (plot)
figure
subplot(6,1,1)
plot([ zeros(1,t_lim(1)-1) t_lim(1):t_lim(end)]/3600,ll_corr_); xlim(t_lim/3600); title('L-L Corr') 
ylim([.5 1])
subplot(6,1,2)
plot([ zeros(1,t_lim(1)-1) t_lim(1):t_lim(end)]/3600,rr_corr_); xlim(t_lim/3600); title('R-R Corr') 
ylim([.4 1])
subplot(6,1,3)
plot([ zeros(1,t_lim(1)-1) t_lim(1):t_lim(end)]/3600,lr_corr_); xlim(t_lim/3600); title('L-R Corr')
ylim([.55 1])
subplot(6,1,4)
plot( t_eeg/3600, mean(sig_bandL(:,theta)./sig_bandL(gamma),2) ); xlim(t_lim/3600);
title('L \theta / \gamma'); ylim([0 .5])
subplot(6,1,5)
plot( t_eeg/3600, mean(sig_bandR(:,theta)./sig_bandR(gamma),2) ); xlim(t_lim/3600);
title('R \theta / \gamma'); ylim([0 .7])
subplot(6,1,6)
plot(t_frame/3600,r_dif_med_removed); xlim(t_lim/3600); ylim(median(r_dif_med_removed)+[-100 750]);
title('Movement'); xlabel('Time (h)')

%% extracting brain regional modules
%correlation matrix for long period
t_limm=floor(8.3*1.5*3600 : 9*1.5*3600); %%%%%%%% time snippet for correlation calc, sleep time coming ...
%from video


eeg_corr=zscore(EEG((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs , :));
c=corr(eeg_corr,'type','spearman');

s1=c>.75; % depict higher correlations
figure
subplot(1,2,1)
ncolor=(length(c)*(length(c)-1)/2); % extracting number of colors in the color map
imagesc(c,[0 1]); colorbar; axis square,  title('Correlation'); cmap=colormap(parula); 
xticks([4.5 12.5]); xticklabels({'L' , 'R'});  yticks([4.5 12.5]); yticklabels({'L' , 'R'})
% getting theindexes of colors in the imagesc plot for the graph that will follow
Cindex = ceil(c*length(cmap)); % index for each entry *****

subplot(1,2,2)
imagesc(s1.*c,[0 1]); colorbar; axis square, colormap(parula(ncolor)); title('Corr Coef > 0.75')
xticks([4.5 12.5]); xticklabels({'L' , 'R'});  yticks([4.5 12.5]); yticklabels({'L' , 'R'})
% displaying co-active clusters:

% reading and displaying the layout of electrode placements
im=imread(image_layout); %%%%%%%%%
im=.5*double(rgb2gray(im));
figure,
imshow(int8(im)); hold on

% differenct images (diff birds). Basically electrode sites shall difer
% just in a scale coefficient:
% 1.24 for 72-00

% for plotting the whole corr matrix as a graph:
C = graph(c,'lower','omitselfloops'); % graph object of c for plotting
for i=2:length(c)
    for j=1:i-1
        edgeij=subgraph(C,[i j]);
        % color for ij edge
        g=plot(edgeij,'EdgeAlpha',.99, 'EdgeColor',cmap(Cindex(i,j),:)); % ******
    g.XData=xy([i j],1);  g.YData=xy([i j],2);
    g.NodeLabel = {};     g.LineWidth = 1.5;
    
    end 
end

% % making the graph
% s=s1-diag(diag(s1)); % removing self loops
% Gcorr = graph(s,'lower','omitselfloops');
% [ MC ] = maximalCliques( s ); % extract fully-connected subgrapohs (brain modules)
% modules=MC(:,sum(MC)>2)
% for k =1:size(modules,2)
%     sub=subgraph(Gcorr,logical(modules(:,k)))
%     h=plot(sub,'EdgeAlpha',.6); 
%     XData=xy(logical(modules(:,k)),1);  YData=xy(logical(modules(:,k)),2);
%     h.XData=XData+randi([-6,6],size(XData));  h.YData=YData+randi([-6,6],size(YData));
%     h.NodeLabel = {};  
%     h.LineWidth = 7;
% 
% end
    
%% feature extraction for  sleep staging
clear t_feats se
t_limm=1800+[0 2*3600]; %%%%%%%% time snippet for plottings
eegsig=EEG((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs , 6);
tsig=time((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs);
win=10; %%%%%%%%% window size for extracting features (in seconds)
[ se, t_feats]=feature_sleep_staging(eegsig,tsig,win,fs);
% plots of features
figure
for k=1:1:size(se,2)/2
    subplot(size(se,2)/2,1,k)
plot(t_feats/3600,se(:,k));  ylim(median(se(:,k))+iqr(se(:,k))*[-2 2])
end

