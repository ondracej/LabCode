

%% Reading the EEG

% load EEG as .continuous
downsamp_ratio=64; %%%%%%%%% must be a power of 2, as the file reader reads blocks of 1024 samples each time
[ EEG_, time, ~]=OpenEphys2MAT_load_save_Data(chnl_order, [dir_prefix '_CH'], downsamp_ratio, file_dev,...
    dir_path_ephys);
EEG=zscore(EEG_);
clear EEG_

% putting the EEG samples in a matrix of rows corresponding to epoches
fs=30000/downsamp_ratio;
eeg_len=ceil(length(EEG)/round(3*fs));
eeg_=zeros(round(3*fs),length(chnl_order),eeg_len);
k=1;  
while round(k*3*fs)<length(EEG)
EEG_part=EEG(floor((k-1)*3*fs)+1:ceil(k*3*fs),:); 
eeg_(:,:,k) = EEG_part(1:round(3*fs),:);
k=k+1;
end

% EEGs with video
EEG3sec=eeg_(:,:,1:eeg_len);

%% save the output variables
save(['G:\Hamed\zf\P1\labled sleep\' saving_name],'EEG3sec','f0','fn','mov','-v7.3','-nocompression');
