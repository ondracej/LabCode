function [t_bin, light_on, band_power, corr_mat ]=frq_band_and_corr_mat_builder(...
     t_off, t_on, fs, EEG, time)

% EEG shall be inputed as a columnar matrix, each channel a column
% this functuion is computing band powers and corr matrix at different bands
bin_len=3; %%%%%%%% in seconds, length of bib
% outputs:
        % t_bin is the time point at the center of the bin, light-on is a 0/1 label, indicating ...
        % the state of lights being on/off, band_power is a structure
        % containing power of EEG at different bands, corr_mat is a
        % structure containing the corr_mat off EEG channels filtered at
        % different frequncy bands
        
        % defines filters that we need for EEG: delta, theta, ... range:
        [b1,a1] = butter(2,[.75  4]/(fs/2)) ; % delta
        [b2,a2] = butter(2,[4    8]/(fs/2)) ; % theta
        [b3,a3] = butter(2,[8   13]/(fs/2)) ; % alpha
        [b4,a4] = butter(2,[13  30]/(fs/2)) ; % beta
        [b5,a5] = butter(2,[30  48]/(fs/2)) ; % low gamma
        [b6,a6] = butter(2,[48 100]/(fs/2)) ; % high gamma

    % center time of each bin:    
    t_bin=min(time)+bin_len-1:bin_len-1:max(time)-bin_len-1;
    % initializing variables that will be generated in the loop:
    band_power=zeros(6,(size(EEG,2)),length(t_bin));
    light_on=10*ones(1,length(t_bin));
    corr_mat.delta=zeros(size(EEG,2),size(EEG,2),length(t_bin));
    corr_mat.theta=zeros(size(EEG,2),size(EEG,2),length(t_bin));
    corr_mat.alpha=zeros(size(EEG,2),size(EEG,2),length(t_bin));
    corr_mat.beta=zeros(size(EEG,2),size(EEG,2),length(t_bin));
    corr_mat.gamma_l=zeros(size(EEG,2),size(EEG,2),length(t_bin));
    corr_mat.gamma_h=zeros(size(EEG,2),size(EEG,2),length(t_bin));

    k=1; % loop counter
    for bin_center=t_bin
        bin_indices=(time>bin_center-bin_len/2 & time<bin_center+bin_len/2); % indices for the ...

        % current bin 
        eeg_part=zscore(EEG(bin_indices)); % binned EEG
        tw = tukeywin(length(bin_indices)); % Tukey window with coeff r = 0.5 to smooth the edges
        eeg_bin=eeg_part.*tw;
        % computing PSD for each frequency band, each channel, for this bin
        % of time:
                
        filt_eeg1=filtfilt(b1,a1,eeg_bin);
        band_power(1,:,k).delta=pwelch(filt_eeg1);
        filt_eeg2=filtfilt(b2,a2,eeg_bin);
        band_power(2,:,k).theta=pwelch(filt_eeg2);
        filt_eeg3=filtfilt(b3,a3,eeg_bin);
        band_power(3,:,k).alpha=pwelch(filt_eeg3);
        filt_eeg4=filtfilt(b4,a4,eeg_bin);
        band_power(4,:,k).beta=pwelch(filt_eeg4);
        filt_eeg5=filtfilt(b5,a5,eeg_bin);
        band_power(5,:,k).gamma_l=pwelch(filt_eeg5);
        filt_eeg6=filtfilt(b6,a6,eeg_bin);
        band_power(6,:,k).gamma_h=pwelch(filt_eeg6);
        
        % computing inter-channel correlation
        corr_mat.delta(:,:,k)=corr(filt_eeg1);
        corr_mat.theta(:,:,k)=corr(filt_eeg2);
        corr_mat.alpha(:,:,k)=corr(filt_eeg3);
        corr_mat.beta(:,:,k)=corr(filt_eeg4);
        corr_mat.gamma_l(:,:,k)=corr(filt_eeg5);
        corr_mat.gamma_h(:,:,k)=corr(filt_eeg6);
        
        light_on(k)=bin_center<t_off | bin_center>t_on; % light status
        
        k=k+1;
    
    end
end

