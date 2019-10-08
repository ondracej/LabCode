function [ EEG, time, dataname]=OpenEphys2MAT_load_save_Data(chnl_order)
%  
% loading OpenEphys data
% important note: lines that you may change like file name, are commented
% with multiple percent signs (%%%%%%%%%%)

selpath=uigetdir(cd,'Select folder containing channels');
addpath(selpath);

fs=30000; %%%%%%%%%%%%%%%% sampling rate
d=15; % downsampling ratio
fs=fs/d;

% loading time stamps 
chn = 1;
    filename =[ '106_CH' num2str(chn) '.continuous'];
    [~,time0, ~] = load_open_ephys_data(filename);
    time = downsample(time0,d); clear time0; % time in minutes

% preallocating space for channels and loadng the rest
eeg=zeros( length(time) , length(chnl_order ) );

% loading EEG channels

for chn = chnl_order
    filename =[ '106_CH' num2str(chn) '.continuous'];
    [signal,~, ~] = load_open_ephys_data(filename);
    [eeg(:,k)]=downsample(signal,d);  clear signal;
end

% prefiltering for power-line removal
wo = 50/(fs/2);
bw = wo/35;  [b,a] = iirnotch(wo,bw);
EEG=filtfilt(b,a,eeg);
fname=split(selpath , "\");
dataname=[ fname{end-1} '__' fname{end}];
save([selpath '\'  dataname '.mat'], 'time','EEG', 'chnl_order','-v7.3','-nocompression');
end