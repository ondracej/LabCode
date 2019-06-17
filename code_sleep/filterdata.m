function [ EEG, EMG ] = filterdata( sr, ch1, ch2 )

[b1_eeg,a1_eeg] = butter(4,30/(sr/2)); %%%%%%% low pass EEG
[b2_eeg,a2_eeg] = butter(4,.5/(sr/2),'high'); %%%%%%% high pass EEG
[b_emg,a_emg] = butter(2,[5 450]/(sr/2)); %%%%%%%
EEG=filtfilt(b1_eeg,a1_eeg,ch1);
EEG=filtfilt(b2_eeg,a2_eeg,EEG)/1;
EMG=filtfilt(b_emg,a_emg,ch2)/1;

end

