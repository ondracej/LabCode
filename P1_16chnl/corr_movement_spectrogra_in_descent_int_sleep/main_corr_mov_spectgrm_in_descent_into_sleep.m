%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this code makes the figure for the change at the initiation of sleep. It
% includes total body dispositions, spectrogram of EEG, and correlation
% between channels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% body movement

% loading the video
folder_path='Y:\HamedData\P1\72-00\02_04_2020'; %%%%%%%%%%
fname='02_04_2020_00115_converted'; %%%%%%%%%%%%
f_path=[folder_path '\' fname '.avi']; 
vid=VideoReader(f_path);

% selecting frame range for processig
f0=1; % 1st frame 
fn=20*60*30; % 30 min %%%%%%%%%%

frames=f0: fn; % frames to be analyzed
roi_y=1:1024;  roi_x=1:1280; % where is the region of interest?
[r_dif,acc_dif, last_im, last_dif] = birdvid_move_extract(f_path,frames,roi_y,roi_x);

figure
subplot(3,1,1)
plot(frames(2:end)/20,r_dif(frames(2:end))); xlabel('Time (s)') ;  
ylabel('body dispositions (pixel)')
ylim([0 mean(r_dif)+20*iqr(r_dif)]) ;

%% wavelet spectrogram
% plot EEG chnnels and pick one
Fs=2000;
chnl=4; %%%%%%%%% which channel to pick
DownRat=8; %%%%%%%%% down sampling ratio
fs=Fs/DownRat; 
eeg=downsample(EEG(1:30*60*fs,chnl),DownRat); % as we just focus on < 50Hz 
t=downsample(time(1:30*60*fs),DownRat);
[cfs,frq] = cwt(eeg,fs);

subplot(3,1,2)
imagesc(t/60,flipud(frq),abs((cfs)),median(abs(cfs(:)))+10*[-iqr(abs(cfs(:)))  iqr(abs(cfs(:)))])
colormap('parula')
axis tight
xlabel('Time (min)')
ylabel('Frequency (Hz)')
set(gca,'yscale','log')
ylim([0 50])


