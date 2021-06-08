% code for the delay map of the dispersion of SWRs

%%%%%%%%%%%%%%%%%%%%%%%%%% The Recipe %%%%%%%%%%%%%%%%%%%%%%%%%%%

% We read SWRs (columns), one at a time, from variable SWRs. Within each
% SWR, we determine the valley of the SWR for each channel. Therefore we
% will have the time-of-ocurrance of SWR at each channel. Then we center
% all these times around the first one, so all will be either zero or
% positive numbers. When we finish this procress for all detected SWRs, we
% computer the average of that relative-time matrix and plot it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% add the data folder to the current path
clear
addpath(genpath('Z:\JanieData\JanieSliceSWRDetections\1431'));
data=load('detections');
SWRs=data.D.AllSWRDataOnChans; % each column of this cell is one SWR, rows correspond to channels
addpath(genpath('D:\github\Lab Code\SWR_delay_calculation')); % for accessing some already written...
% functions
%% reorganizing the data in matrices and SWR trough detection

% designing a filter for extraction of low frequenc ý component of each
% SWR, the sharp wave (e.g. 20-40 Hz)
fs=32000; % sampling rate
[b1,a1] = butter(2,[120 400]/(fs/2));
[b2,a2] = butter(2,[.2 20]/(fs/2));

% reading from the cell, filtering, and rearranging in a 3D matrix
for swr_count=1:size(SWRs,2)
    for chnl=1:size(SWRs,1)
        SWR(:,chnl)=SWRs{chnl,swr_count};
    end
    
    % we filter the data to just extract the low-frequency component,
    % the Sharp Wave, and to detect the trough based on it
    ripple=filtfilt(b1,a1,SWR);
    sharp_wave=filtfilt(b2,a2,SWR);
    
    ripples_mat(:,:,swr_count)=ripple;
    sharp_wave_mat(:,:,swr_count)=sharp_wave;
end

%% plotting one SWR for all channels
swr_count=6; %??????????????????????
dist=10; % distance between channels for the plottring %???????????????????
figure
for chnl=1:size(SWRs,1)
    subplot(1,2,1) % first subplot Sharp Wave
    plot((1:length(sharp_wave_mat(:,:,swr_count)))/fs,sharp_wave_mat(:,chnl,swr_count)-dist*chnl,...
        'color',[0 .4 .2]);
    hold on
    yticks(dist*(-chnl:4:-1));
    yticklabels(num2cell(1:4:chnl));
    xlim([.5 1.5])
    ylabel('channels')
    xlabel('Time (sec)');
    subplot(1,2,2) % second subplot Sharp wave and Ripples
    plot((1:length(ripples_mat(:,:,swr_count)))/fs,.5*ripples_mat(:,chnl,swr_count)-dist*chnl,...
        'color',[1 .5 .6]);
    plot((1:length(sharp_wave_mat(:,:,swr_count)))/fs,sharp_wave_mat(:,chnl,swr_count)-dist*chnl,...
        'color',[0 .4 .2]);
    hold on
    yticks(dist*(-chnl:4:-1));
    yticklabels({});
    xlim([.5 1.5])
    xlabel('Time (sec)');
    
end

%% extracting the trough times across channels
for chnl=1:size(SWRs_mat,2)
    [~,t_trough_ind(chnl)]=min(SWRs_mat(:,chnl,swr_count),[],'all','linear');
end
t_trough=(t_trough_ind-min(t_trough_ind,[],'all'))/fs;

%% ripple envelope and plot with sharp waves
hilb_len=round(fs/50) ; % length parameter for the Hilbert filter
[up,lo] = envelope(ripples_mat(:,:,swr_count),hilb_len,'analytic');

% plot
%% plotting one SW and ripple envelopes for all channels
swr_count=6; %??????????????????????
dist=10; % distance between channels for the plottring %???????????????????
samps=1:1:length(SWR);
t_plot=samps/(fs/1);
figure
for chnl=1:10%size(SWRs,1)
    subplot(1,2,1) % for the sharp wave and ripples envelope
    plot(t_plot,ripples_mat(samps,chnl,swr_count)-dist*chnl,'color',[0 .4 .2]);
    shade(t_plot,up(samps,chnl)-dist*chnl,t_plot,lo(samps,chnl)-dist*chnl,'FillType',[1 2],...
        'fillalpha',.5)

    hold on
    yticks(dist*(-chnl:4:-1));
    yticklabels(num2cell(1:4:chnl));
    xlim([.5 1.5])
    ylabel('channels')
    xlabel('Time (sec)');
    subplot(1,2,2) % for the sharp wave and the ripples
    plot(t_plot,.5*ripples_mat(samps,chnl,swr_count)-dist*chnl,'color',[1 .5 .6]);
    plot(t_plot,sharp_wave_mat(samps,chnl,swr_count)-dist*chnl,'color',[0 .4 .2]);
    hold on
    yticks(dist*(-chnl:4:-1));
    yticklabels({});
    xlim([.5 1.5])
    xlabel('Time (sec)');
    
end
%% visualization
% defining the electrode pad grid coordinates
k=100; % spacing between the contacts, in micro meter
x=k*[ones(1,5), 2*ones(1,8), 3*ones(1,8), 4*ones(1,8), 5*ones(1,8), 6*ones(1,8),...
    7*ones(1,8), 8*ones(1,6)];
y=k*[ones(1,6), 2*ones(1,8), 3*ones(1,8), 4*ones(1,8), 5*ones(1,8), 6*ones(1,8),...
    7*ones(1,8), 8*ones(1,6)];


















