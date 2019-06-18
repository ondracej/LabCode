%% loading data
% important note: lines that you may change like file name, are commented
% with multiple percent signs (%%%%%%%%%%)
clear ; clc; close all;
addpath('D:\github\matlab-plot-big'); % add library for faster large data plots 
% selecting folder
addpath(genpath('D:\zf\70-86\2019-05-24')); %%%%%%%%%
fs=30000; %%%%%%%%% sampling rate for single unit recordings
d=20; % downsampling ratio
fs=fs/d;
% loading 1st channel 
filename =[ '100_CH' num2str(2) '.continuous'];  %%%%%%%%%
[signal,time0, ~] = load_open_ephys_data(filename);
k=1; % loop variable for loading channels
signal0(:,k) = downsample(signal,d);  clear signal; k=k+1;
time = downsample(time0,d); clear time0; 
% preallocating space for channels
signal0(:,2:8)=zeros(length(time),7);
for chn = [ 4 5 6 8 12 14 16] %%%%%%%%%%%%
filename =[ '100_CH' num2str(chn) '.continuous'];  
[signal,~, ~] = load_open_ephys_data(filename);
[signal0(:,k)]=downsample(signal,d);  clear signal; k=k+1; 
end
% last chanle and TIME
save('7087_LFP_.mat','time','signal0','-v7.3','-nocompression');


