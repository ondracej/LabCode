function [ EEG, EMG, time, eeg_chnl, dataname]=OpenEphys2MAT_load_save_Data()
%  
% loading OpenEphys data
% important note: lines that you may change like file name, are commented
% with multiple percent signs (%%%%%%%%%%)

selpath=uigetdir(cd,'Select folder containing channels');
addpath(selpath);
prompt = {'Enter EEG Channels (comma separated):','Enter EMG Channel:'};
title = 'Data Channels';
dims = [1 35];
eeg_emg = inputdlg(prompt,title,dims);
eeg_chnl=str2num(eeg_emg{1,1});
% selecting folder
fs=30000; %%%%%%%%%%%%%%%% sampling rate
d=15; % downsampling ratio
fs=fs/d;

% loading EMG channel and timestamps
filename =[ '100_CH' eeg_emg{2,1} '.continuous'];
[signal,time0, ~] = load_open_ephys_data(filename);
emg = downsample(signal,d);  clear signal;
time = downsample(time0,d); clear time0; % time in minutes

% preallocating space for channels and loadng the rest
eeg=zeros( length(time) , length( str2num(eeg_emg{1,:}) ) );

% loading EEG channels
k=1; % loop variable for loading channels
for chn = str2num(eeg_emg{1,:})
    filename =[ '100_CH' num2str(chn) '.continuous'];
    [signal,~, ~] = load_open_ephys_data(filename);
    [eeg(:,k)]=downsample(signal,d);  clear signal; k=k+1;
end

% prefiltering for power-line removal
wo = 50/(fs/2);
bw = wo/55;  [b,a] = iirnotch(wo,bw);
EEG=filtfilt(b,a,eeg);
EMG=filtfilt(b,a,emg);
fname=split(selpath , "\");
dataname=[ fname{end-1} '__' fname{end}];
save([selpath '\'  dataname '.mat'], 'time','EEG','EMG', 'eeg_chnl','-v7.3','-nocompression');
end