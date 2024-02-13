function [ eeg, time, selpath]=OpenEphys2MAT_load_save_Data(...
    chnl_order, dir_prefix, f_postname, downsamp_ratio, file_dev, selpath)
%  
% loading OpenEphys data
% important note: lines that you may change like file name, are commented
% with multiple percent signs (%%%%%%%%%%)
% f_prename is the firs part of file names, e.g.: 127_CH
% selpath is the directory address containing data
addpath(selpath);
% loading time stamps 
chn = chnl_order(1);
    filename =[ dir_prefix num2str(chn) f_postname '.continuous'];
    [~,time, ~] = load_open_ephys_data_adv(filename,downsamp_ratio,file_dev);

% preallocating space for channels and loadng the rest
eeg=zeros( length(time) , length(chnl_order ) );

% loading EEG channels
k=1; % loop var for channels
if dir_prefix(end-2:end)~='ADC'
    % in case of .continuous channels
for chn = chnl_order
    tic
    filename =[ dir_prefix num2str(chn) f_postname '.continuous'];
    [new_sig,~, ~]=load_open_ephys_data_adv(filename,downsamp_ratio,file_dev);
    if length(new_sig)==length(eeg)
        eeg(:,k) = new_sig;
    elseif length(new_sig)<length(eeg)
        eeg(:,k)= [new_sig; zeros(length(eeg)-length(new_sig),1)];
    elseif length(new_sig)>length(eeg)
        eeg(:,k) = new_sig(1:length(eeg));
    end

    k=k+1; toc
end
% in case of ADC channel
else
    filename =[ dir_prefix num2str(1) '.continuous'];
    [eeg(:,k),~, ~] = load_open_ephys_data_adv(filename,downsamp_ratio,file_dev);
end

end