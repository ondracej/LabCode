
clear; clc;
load('Y:\hameddata2\EEG-LFP-songLearning\Mat_files\w042_2022-01-12');


%% binning of data, feature extraction and clustering
lfp1_chnl=1; %%%%%%%%%%%%%% reorganize, if necesssary, so, these are 1:5 channels: LFP, R ant and post, L amnt and psot
r_a_chnl=2; %%%%%%%%%%%%%%
r_p_chnl=3; %%%%%%%%%%%%%%
l_a_chnl=4; %%%%%%%%%%%%%%
l_p_chnl=5; %%%%%%%%%%%%%%
chnl_names={'lfp','r_a','r_p','l_a','l_p'};
ref_chnl=l_a_chnl; % always left anterior EEG chnl;
t_dark_onset=10000/20; %%%%%%%%%%%%% light switching times in hameddata2\EEG-LFP-song learning, frame num /20  +time(1)
t_dark=data.time(1)+ t_dark_onset+[0 12]*3600;
downsamp_ratio=64;
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',4,'HalfPowerFrequency1',1,'HalfPowerFrequency2',48, ...
    'SampleRate',fs);
clear DG Delta Gamma MaxAmp

% binning
for chnl_to_bin=1 %%%%%%%%%%%% 4 or 5?
    
    chnl_filt=data.ephys(:,chnl_to_bin);
    ref_filt=data.ephys(:,ref_chnl);
    
    [b,a] = butter(3,30/(fs/2),'high');
    ref_over30=filtfilt(b,a,data.ephys(:,ref_chnl));
    win_len=floor(3*fs);
    for current_win=1: (length(chnl_filt)/win_len)
        inds=(current_win-1)*win_len +(1:win_len);
        wave_binned(current_win,:)=chnl_filt(inds);
        t_bin(current_win)=data.time(inds(round(fs*1.5))); % the middle time point of a bin
        pow_30hz(current_win)=rms(ref_over30(inds))^2; % power of high freq in the ref chnl for sleep/wake deliniation
    end
    
    move_artef_thresh=median(pow_30hz)+4*iqr(pow_30hz);
    % artefact windows:
    inds_sleep=pow_30hz<move_artef_thresh;
    n_bins=length(wave_binned);
    [DG(:,chnl_to_bin), Delta(:,chnl_to_bin) Gamma(:,chnl_to_bin) MaxAmp(:,chnl_to_bin) t_DG]=...
        DG_extract(wave_binned(inds_sleep,:), t_bin(inds_sleep), fs);
    chnl_to_bin
end

%% trying different thrsholds
chnl_to_score=1; %%%%%%%%%%%%%%%%%%%%% 1:5
DG_=DG(:,chnl_to_score);
windowLen=12; % smooting window length in minutes
median_DG= movingMedian(DG_, t_DG, windowLen);
clear inds_SWS inds_REM inds_IS
iqr_DG=movingIqr(DG_, t_DG, windowLen);
level=.1: .1: 1.4;
labels = cell(length(level),length(level),length(DG_) );
for SWS_count=1:length(level)
    for REM_count=1:length(level)
        SWS_thresh=median_DG+level(SWS_count)*iqr_DG;
        REM_thresh=median_DG-level(REM_count)*iqr_DG;
        inds_SWS=DG_>=SWS_thresh';
        inds_REM=DG_<=REM_thresh';
        inds_IS=DG_<SWS_thresh' & DG_>REM_thresh';
        labels(SWS_count,REM_count,inds_SWS)={'SWS'};
        labels(SWS_count,REM_count,inds_REM)={'REM'};
        labels(SWS_count,REM_count,inds_IS)={'IS'};
    end
end

%% visualization of the classification process
hh=figure;
set(hh,'position',[100 400 1000 300]);
plot(t_DG/1,DG_,'color',[.4 .4 .4]); hold on
ylim([0 400])

SWS_count=10; %%%%%%%%% 3: .3
REM_count=5; %%%%%%%%%%% 
SWS_thresh=median_DG+level(SWS_count)*iqr_DG;
REM_thresh=median_DG-level(REM_count)*iqr_DG;
r=[253 145 33 ]/255;
s=[.4 .4 1 ];
i=[.2 1 1 ];
plot(t_DG/1,median_DG,'linewidth',3,'color','k'); hold on
plot(t_DG/1,SWS_thresh,'linewidth',3,'color',s); hold on
plot(t_DG/1,REM_thresh,'linewidth',3,'color',r); hold on
xlim((3.2*60+[0 180])*60);
ylabel('Delta/Gamma');
xlabel('Time (min)')

%% visualization of the scored data in 3D
plot_inds=randsample(length(labels),2000); %%%%%%%%%%%
class_colors = containers.Map({
    'REM', 'IS', 'SWS'}, {r,i,s});
% Step 5: Create a 3D scatter plot with colored points based on labels
SWS_count=5; %%%%%%%%%%%%%%% .2
REM_count=5; %%%%%%%%%%%%%%%%% .3

figure;

% Set up the video file
videoFile = VideoWriter('3DSleepScoredData.mp4', 'MPEG-4');
videoFile.Quality = 100; % Adjust quality as needed
videoFile.FrameRate = 25; % Frames per second

open(videoFile);

% Create animation by rotating the view angle
numFrames = 6*25; % Number of frames for the animation
viewAngles = linspace(0, 180, numFrames);

% Color each point based on the corresponding class color
for i = 1:length(plot_inds)
    ind=plot_inds(i);
    color = class_colors(labels{SWS_count,REM_count,ind});
    scatter3(log10(Delta(ind,chnl_to_score)), log10(Gamma(ind,chnl_to_score)), MaxAmp(ind,chnl_to_score),...
        20, color, 'filled'); hold on
end

xlabel('log Delta');
ylabel('log Gamma');
zlabel('max amplitude');
zlim([100 700])
xlim([2.3 4.5])
ylim([1.2 2.7])
title('3D Visualization of scored bins');
view(-20,30)
%% animation
for i = 1:numFrames
    view([viewAngles(i), 30]); % Adjust the second angle (30 in this case) as needed
    drawnow;
    frame = getframe(gcf);
    writeVideo(videoFile, frame);
end

close(videoFile);
%% sample figure with labels
SWS_count=7; %%%%%%%%%%%%%%% .2
REM_count=2; %%%%%%%%%%%%%%%%% .3
t_lim=randsample(36000,1)+3600+[0 30]; % t lim for visualization
r=[253 145 33 ]/255;

s=[.4 .4 1 ];
i=[.2 1 1 ];
inds=data.time<t_lim(2) & data.time>t_lim(1); 
% filtering
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8,'HalfPowerFrequency1',1,'HalfPowerFrequency2',48,'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,data.ephys(inds,:));
h=figure;
set(h,'position',[100 600 1000 150]);
chnl_to_plot=chnl_to_score; %chnl_to_bin; %%%%%%%%%% determine the chnl number to be plotted
plot(data.time(inds),1*ephys_filt(:,chnl_to_plot),'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-370 350]);

% adding colored shades indicating stage of sleep for any 2-sec bin 

color_order_=[r; s; i; ];
color_order_=[color_order_ .7*ones(3,1)];
t_bin_plot=t_DG (t_DG>=(t_lim(1)-1) & t_DG<=(t_lim(2)+1));
label_plot=labels (SWS_count,REM_count,t_DG>=(t_lim(1)-1) & t_DG<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label_ref
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5],-300+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
ylabel('Amp (\muV)')
title('DVR')
xlabel('Time (sec)')
%% save the finalized classification results, for each channel separately
folder_add='Y:\zoologie\HamedData\LocalSWPaper\PaperData\new_scorings';
bird_name='w044'; %%%%%%%%
chnl_name=chnl_names{chnl_to_score}
Delta_=Delta(:,chnl_to_score);
Gamma_=Gamma(:,chnl_to_score);
DG_=DG(:,chnl_to_score);
labels_=reshape(labels(SWS_count,REM_count,:),1,length(labels));
save([folder_add '\' bird_name '_' chnl_name], 'SWS_count','REM_count','windowLen','Delta_','Gamma_',...
    'DG_','t_DG','labels_');









