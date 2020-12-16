% load EEG as .continuous
addpath(genpath('D:\github\Lab Code\Respiration VideoAnalysis'));
addpath(genpath('D:\github\Lab Code\P1_16chnl'));
addpath(genpath('D:\github\Lab Code\LoadEphys_SWRanalysis'));

dir_path_server='Z:\zoologie\HamedData\P1\72-94\29_05_2020\chronic_2020-05-29_19-26-15'; %%%%%%%%
dir_prefix='133'; %%%%%%%%%%%%%%
file_dev=10; %%%%%%%%%% which prtion of EEG file you want to read? 10 for ane tenth of the file
chnl_order=[1 2 3 4 5 6 8 7 10 9 11 12 13 16 14 15 ];

downsamp_ratio=16; %%%%%%%%% must be a power of 2, as the file reader reads blocks of 1024 samples each time
tic
[ EEG, time, ~]=OpenEphys2MAT_load_save_Data(chnl_order, [dir_prefix '_CH'], downsamp_ratio, file_dev,...
    dir_path_server);
toc

%%
%%%%%%%%%%%%%% plotting
fs=30000/downsamp_ratio;
sec=40; % the time for the start of plot
samps1=sec*fs+(1:10*fs);
samps=1:length(EEG);
figure

for k=1:16
plot(samps/fs,zscore(EEG(samps,k))+4*k); hold on
end
xlim([min(samps1) max(samps1)]/fs)

%%
%%%%%%%%%%%%%% plotting
fs=30000/downsamp_ratio;
samps1=sec*fs+(1:10*fs);
samps=1:length(EEG);
figure

meanEEG=mean(EEG,2);
EEG_=EEG-meanEEG;
for k=1:16
plot(samps/fs,zscore(EEG_(samps,k))+4*k); hold on
end
xlim([min(samps1) max(samps1)]/fs)

%%
%%%%%%%%%%%%%% plotting
fs=30000/downsamp_ratio;
samps1=sec*fs+(1:10*fs);
samps=1:length(EEG);
fc = 200;
[b,a] = butter(4,fc/(fs/2));
EEG_f=filtfilt(b,a,EEG);
figure

for k=1:16
plot(samps/fs,zscore(EEG_f(samps,k))+4*k); hold on
end
xlim([min(samps1) max(samps1)]/fs)