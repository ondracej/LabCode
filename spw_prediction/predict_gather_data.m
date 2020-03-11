function [eegsig,time] = predict_gather_data(dirname,chnls,prename,downsamp,fs)

[eeg0,time0, ~] = load_open_ephys_data([dirname '\' [num2str(prename) num2str(chnls(1))  '.continuous']]); % first reading the 1st channel
% downsampling:
eeg1=downsample(eeg0,downsamp);
time=downsample(time0,downsamp);

eeg=[eeg1 , zeros(length(eeg1) , length(chnls)-1)];

if length(chnls)>1
    
    for k=2:length(chnls)
        [sig,~, ~] = load_open_ephys_data([dirname '\' [num2str(prename) num2str(chnls(1))  '.continuous']]);
        % downsampling:
        eeg(:,k)=downsample(sig,downsamp);
    end
end


% Filtering for SPW-R

ShFilt = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',2,'HalfPowerFrequency2',200, 'SampleRate',fs);
eegsig=filtfilt(ShFilt,eeg);

end

