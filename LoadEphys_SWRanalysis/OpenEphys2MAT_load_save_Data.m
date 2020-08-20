function [ eeg, time, selpath]=OpenEphys2MAT_load_save_Data(...
    chnl_order, f_prename, downsamp_ratio, selpath)
%  
% loading OpenEphys data
% important note: lines that you may change like file name, are commented
% with multiple percent signs (%%%%%%%%%%)
% f_prename is the firs part of file names, e.g.: 127_CH
% selpath is the directory address containing data
addpath(selpath);
fs=30000; %%%%%%%%%%%%%%%% sampling rate
d=downsamp_ratio; % downsampling ratio
% loading time stamps 
chn = chnl_order(1);
    filename =[ f_prename num2str(chn) '.continuous'];
    [~,time0, ~] = load_open_ephys_data(filename);
    time = downsample(time0,d); clear time0; % time in minutes

% preallocating space for channels and loadng the rest
eeg=zeros( length(time) , length(chnl_order ) );

% loading EEG channels
k=1; % loop var for channels
if f_prename(end-2:end)~='ADC'
    % in case of .continuous channels
for chn = chnl_order
    filename =[ f_prename num2str(chn) '.continuous'];
    [signal,~, ~] = load_open_ephys_data(filename);
    [eeg(:,k)]=downsample(signal,d);  clear signal; k=k+1;
end
% in case of ADC channel
else
    filename =[ f_prename num2str(1) '.continuous'];
    [signal,~, ~] = load_open_ephys_data(filename);
    [eeg(:,k)]=downsample(signal,d);  clear signal; k=k+1;
end

% prefiltering for power-line removal
% wo = 50/(fs/2);
% bw = wo/35;  [b,a] = iirnotch(wo,bw);
% eeg=filtfilt(b,a,eeg);
% fname=split(selpath , "\");
% dataname=[ fname{end-1} '__' fname{end}];
% save([selpath '\'  dataname '.mat'], 'time','eeg', 'chnl_order','-v7.3','-nocompression');
end