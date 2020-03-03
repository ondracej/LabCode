function [ eeg, time, dataname, selpath]=OpenEphys2MAT_load_save_Data(chnl_order, f_prename)
%  
% loading OpenEphys data
% important note: lines that you may change like file name, are commented
% with multiple percent signs (%%%%%%%%%%)
% f_prename is the firs part of file names, e.g.: 127_CH
selpath=uigetdir('G:\Hamed\zf','Select folder containing channels');
addpath(selpath);

fs=30000; %%%%%%%%%%%%%%%% sampling rate
d=15; % downsampling ratio
fs=fs/d;

% loading time stamps 
chn = chnl_order(1);
    filename =[ f_prename num2str(chn) '.continuous'];
    [~,time0, ~] = load_open_ephys_data(filename);
    time = downsample(time0,d); clear time0; % time in minutes

% preallocating space for channels and loadng the rest
eeg=zeros( length(time) , length(chnl_order ) );

% loading EEG channels
k=1; % loop var for channels
for chn = chnl_order
    filename =[ f_prename num2str(chn) '.continuous'];
    [signal,~, ~] = load_open_ephys_data(filename);
    [eeg(:,k)]=downsample(signal,d);  clear signal; k=k+1;
end

% prefiltering for power-line removal
% wo = 50/(fs/2);
% bw = wo/35;  [b,a] = iirnotch(wo,bw);
% eeg=filtfilt(b,a,eeg);
fname=split(selpath , "\");
dataname=[ fname{end-1} '__' fname{end}];
save([selpath '\'  dataname '.mat'], 'time','eeg', 'chnl_order','-v7.3','-nocompression');
end