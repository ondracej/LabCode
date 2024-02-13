
fs=30000/64;
chnl=4; % non-noisy channel
% reshaping data in 3 sec windows, in case bins are 1.5 sec
if exist('EEG3sec','var')==0
    if exist('EEG_','var')==1
        EEG=EEG_;
    elseif exist('eeg_adc','var')
        EEG=eeg_adc;
    end
    if size(EEG,3)>27000
        new_len=floor(size(EEG,3)/2);
        EEG3sec=zeros(size(EEG,1)*2,size(EEG,2),new_len);
        for k=1:new_len
            EEG3sec(:,:,k)=[EEG(:,:,2*k-1);EEG(:,:,2*k)];
        end
        t_bins3sec=downsample(t_bins,2)+1.5/2;
        mov3sec=downsample((mov+circshift(mov,-1))/2, 2);
    else
        mov3sec=mov;
        EEG3sec=EEG;
        if exist('t_bins','var')
        t_bins3sec=t_bins;
        end
        % t_bins3sec=t_bins;
    end
else
    mov3sec=mov;
    
end

if length(EEG3sec)>=length(mov3sec) && exist('t_diff','var') % this is true if the synchronizing pulse has worked correctly
    EEG3sec=EEG3sec(:,:,round(t_diff/3)+1:end);
    EEG3sec=EEG3sec(:,:,1:length(mov3sec));
else
    mov3sec=mov3sec(1:size(EEG3sec,3));
end
if ~exist('t_bins3sec','var') % in case that there were no synchronizong ADC, we estimate the time samples
    t_bins3sec=1.5:3:1.5+(length(EEG3sec)*3);
end
t_bins3sec=t_bins3sec(1:length(EEG3sec));

%% finding the bins when the bird is not moving too much (is not wake) and EEG is without movement artefact  
eeg=reshape(EEG3sec(:,chnl,:),[1,size(EEG3sec,1)*size(EEG3sec,3)]);
thresh=150*iqr(eeg(round(3600*fs*[1 12])));
maxes_=max(abs(EEG3sec(:,chnl,:)),[],1);
maxes=reshape(maxes_,[1,length(maxes_)]);
if exist('t_diff','var') % in case that we dont have the synchronizing signal
    valid_inds=find(maxes<thresh );
    valid_inds_logic=(maxes<thresh );
else
    thresh_mov=median(mov3sec([1000 end-1000]))+200*iqr(mov3sec([1000 end-1000])); % threshold for separating wakes from sleep based on movement
    valid_inds=find(maxes<thresh & mov3sec'<thresh_mov & t_bins3sec>light_off_t & t_bins3sec<light_on_t);
    valid_inds_logic=(maxes<thresh & mov3sec'<thresh_mov);
end

%
figure
subplot(2,1,1)
plot(eeg(1:5:end)); hold on
line([1 length(eeg)/5],[ thresh thresh],'color','r'); title('eeg and 4 iqr')
ylim([-350 350]*iqr(eeg(round(3600*fs*[1 12]))))
% subplot(2,1,2)
% plot(mov3sec(1:5:end)); hold on
% line([1 length(mov3sec)/5] ,[thresh_mov thresh_mov]); title('mov and 4 iqr')
% ylim(median(mov3sec([1000 end-1000]))+[-70*iqr(mov3sec([1000 end-1000])) 300*iqr(mov3sec([1000 end-1000]))])

%% Sleep staging feature extraction
clear Delta_ref Gamma_ref feat_ref sleep_wake t_feat Delta Gamma feat bin_label bin_label
% for the reference channel and the other channel
[Delta, Gamma, Low, feat, t_feat]=sleep_feature_extract_(EEG3sec, t_bins3sec, fs);
beep; pause(.5); beep;
%%  clustering
sleep_wake=valid_inds_logic(2:end-1);
[bin_label, valid_bin_inds]=cluster_sleep_(feat, sleep_wake, Delta, Gamma );

Delta_=Delta(valid_bin_inds);
Gamma_=Gamma(valid_bin_inds);
t_bin_label=t_feat(valid_bin_inds);

% visualization of bins in the feature space
% colors for each stage

% color for each stage, might need to be updated each time 
%%%%%%%%%%%%%%
r=.8*[1 .4 .4]; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
w=[.9 .9 .3];
color_order=[r; i; w; s]; %%%%%%%%%%%%%%

% second plot for  chnl
figure
plot_inds=randsample(length(bin_label),2000);
x_vals=log10(Delta_(plot_inds))';
y_vals=log10(Gamma_(plot_inds))';
group_label=bin_label(plot_inds)';
scatterhist(x_vals,y_vals,'Group',group_label,'Kernel','on','Location','SouthEast',...
    'Direction','out','Color',color_order,'LineStyle',{'-','-.',':','--'},...
    'LineWidth',[2,2,2,2],'Marker','....','MarkerSize',.6*[10, 10, 10, 10]);
ylim(median(y_vals)+3*iqr(y_vals)*[-.9 1.5]); 
xlim(median(x_vals)+2.5*iqr(x_vals)*[-1 1.]);  
title('non-ref ref channel')
xlabel('log Delta'); ylabel('log Gamma')

%% scatter plot of bouts with true label
figure
plot_inds=randsample(length(bin_label),1000);
x_vals=log10(Delta_(plot_inds))';
y_vals=log10(Gamma_(plot_inds))';
group_label=bin_label(plot_inds)';
color_order=[r; s; i; w];

for bin=1:length(plot_inds)
    stage=strcmp(group_label{bin},{'REM','SWS','IS','Wake'});
    scatter(x_vals(bin),y_vals(bin),12,color_order(stage,:),'filled'); hold on
end
ylim(median(y_vals)+3*iqr(y_vals)*[-1 1]); 
xlim(median(x_vals)+2.5*iqr(x_vals)*[-1 1]); 
xlabel('log Delta'); ylabel('log Gamma')

%% visualization of a piece of EEG with stages indicated
% reconstructing the signal from the windows:
ephys=reshape(EEG3sec(:,chnl,:),1,size(EEG3sec,1)*size(EEG3sec,3));
% reconstructing time variable
% interpolating fine time steps from the time of bin centers
bin_centers=size(EEG3sec,1)*.5:size(EEG3sec,1):size(EEG3sec,1)*size(EEG3sec,3)-size(EEG3sec,1)*.5;
t_bin_centers=t_bins3sec;
fine_samples=1:length(ephys);
time = interp1(bin_centers,t_bin_centers,fine_samples);

t_lim=randsample(36000,1)+3600+[0 20]; % t lim for visualization

inds=time<t_lim(2) & time>t_lim(1); 
% filtering
downsamp_ratio=64;
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8,'HalfPowerFrequency1',1,'HalfPowerFrequency2',49,'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,ephys(inds));
h=figure('position',[ 100 300 1200 150]);
plot(time(inds),ephys_filt*100,'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-400 400]);


% adding colored shades indicating stage of sleep for any 2-sec bin 
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_bin_label    (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1));
label_plot=bin_label (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.4 t_bin_plot(bin)+1.4],-240+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
xlabel('Time (sec)');
ylabel('Amplitude (\muV)')

%% saving data
saving_name=[ 'sleep_stages_' fname(1:end-8)];
save(['G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\' saving_name], 'bin_label', 't_bin_label');






