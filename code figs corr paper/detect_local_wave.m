function [local_wave_per_chnl,local_wave] = detect_local_wave(EEG3sec,fs,thresh,valid_inds)
min_chnl=round(size(EEG3sec,2)/4); % min num of channels with a simultaneous wave to consider a local wave
max_chnl=round(size(EEG3sec,2)*3/4); % max num of channels with a simultaneous wave to consider a local wave
a=EEG3sec;
%% local wave detection
% first designing a filter for smooting the data just to avoid detecting
% multiple redundant peaks when we do peak finding:
smoother = designfilt('lowpassiir','FilterOrder',4, ...
    'PassbandFrequency',20,'PassbandRipple',0.5, ...
    'SampleRate',fs);
local_wave_per_chnl=zeros(size(EEG3sec,2),1);
% go through all the data, find the suprathreshold peaks in all channels:
local_wave=NaN; % initial value
for epoch=1:length(valid_inds)
    local_wave(epoch)=0; n_loc_wav=0; % n is number of all detected paired peaks, ...
    % that could be redundant
    peak_position=[]; % peak_position contains the index to the peaks of local waves
    all_peaks=[]; % contains all the candidate peaks for local wave
    % find the times of all the supra-threshold peakes in all channels:
    for ch=1:size(EEG3sec,2)
        smoothedEEG=filtfilt(smoother, EEG3sec(:,ch,epoch));
        supra_thresh=abs(smoothedEEG)>1*thresh/4; % (thresh is 4iqr(eeg))
        [~,peak_inds{ch}]=findpeaks(smoothedEEG.*supra_thresh,'MinPeakDistance',40);
        % at least 90 m sec (40/fs) time diff between consequtive peaks
    end
    
    % find the simultaneous peaks in different channels:
    for ch1=1:size(EEG3sec,2)-1
        all_peaks_ch1=peak_inds{ch1};
        for k=1:length( all_peaks_ch1 )
            peak=all_peaks_ch1(k);
            for ch2=ch1+1:size(EEG3sec,2)
                if min(abs(peak_inds{ch2}-peak),[],'all')<=4 % peaks within 10 ms (4 samples)
                    n_loc_wav=n_loc_wav+1;  all_peaks(n_loc_wav)=peak;
                end
            end
        end
    end
    % now we have all the synchronusly-ocurring peaks, that may be redundant.
    % Therefore now we have to remove the redundancies. For this purpose,
    % we sort all the detected synchronous peaks, and count the number of jumps
    % (diff>2) +1
    sorted_peaks=sort(all_peaks);
    while(length(sorted_peaks)>min_chnl)
        % find the first group of simultaneous peaks:
        jump_ind=find(diff(sorted_peaks)>4,1);  % end of the first group of peaks
        if isempty(jump_ind) % if this is the last group of peaks
            break;
        end
        if length(sorted_peaks(1:jump_ind))>=min_chnl & length(sorted_peaks(1:jump_ind))<=max_chnl
            % if there are at least 25% chnls with that peak but not more
            % than 75% of chnls
            local_wave(epoch)=local_wave(epoch)+1;
            peak_position(local_wave(epoch))=mean(sorted_peaks(1:jump_ind));
        end
        sorted_peaks=sorted_peaks(jump_ind+1:end); % remove the first group and repeat the ...
        % process for the rest
    end
    local_wave(epoch)=local_wave(epoch)/3; % divided by duration of window
    
    % computing abundance of local waves in each channel
    for ch=1:size(EEG3sec,2)
        if isempty(peak_position)
            break;
        end
        peak_inds_ch=peak_inds{ch};
        for pk=1:length(peak_inds_ch)
            ch_peak=peak_inds_ch(pk);
            if min(abs(peak_position-ch_peak),[],'all')<=8
                local_wave_per_chnl(ch,:)=local_wave_per_chnl(ch,:)+1;
            end
        end
    end
    local_wave_position{epoch}=peak_position;
    clear   peak_inds
    
end
local_wave_per_chnl=(local_wave_per_chnl/length(valid_inds))/3;
end