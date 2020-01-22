selpath='D:\Janie\chick10\Chick10_2019-04-27_21-58-36';
% loading all channels of a recording
addpath('D:\github\LabCode\LoadEphys_SWRanalysis');
addpath('D:\github\matlab-plot-big-fast');
% %%%%%%%%% select data directory through the popup menu
addpath(selpath);
chnl_order=[5     4     6     3     9    16    8    1    11    14    12    13    10    15     7     2];  %%%%%%%%%%%%% recording channels with their actual location in order
% this is the mapping of channels: [5     4     6     3     9    16     8  1    11    14    12    13    10    15     7     2], ...
% from most superficial to deepest
fs=30000; %%%%%%%%%%%%%%%% sampling rate

% loading EEG channels
kk=1; % loop variable for loading channels
for chn = chnl_order
    filename =[selpath '\' '100_CH' num2str(chn) '.continuous'];
    [eeg(:,kk),~, ~] = load_open_ephys_data(filename);     kk=kk+1;
end
% for time stamp
[~,time, ~] = load_open_ephys_data(filename);
time=time-time(1);
disp(['Data len: ' num2str(max(time/60)) ' min' ])
fparts=split(selpath,'\'); % extracting file name from full path name
N=length(chnl_order); % number of electrode for further frequent use

%% downsampling for SW and Ripples detection, fromm 30000 to 3000, and then filtering
signal_raw=downsample(eeg,10);
t_signal=downsample(time,10);
fs_=fs/10;

% filtering for SWR and figures
% for sharp wave:
ShFilt = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',1,'HalfPowerFrequency2',40, 'SampleRate',fs_);
spwsig=filtfilt(ShFilt,signal_raw);
% for ripples:
RippFilt = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',50,'HalfPowerFrequency2',300, 'SampleRate',fs_);
RippSig=filtfilt(RippFilt,signal_raw);

%% LFP  plot 
% preparation for plot
set(0,'units','pixels');
%Obtains this pixel information
pixls = get(0,'screensize');
figure('Position', pixls);
t0=1; % 18160;
plot_time=[0 30.01];
tlim=t0+plot_time;
t_lim=tlim(1)*fs_:tlim(2)*fs_;
for chnl=1:N
x=spwsig(t_lim,chnl);
plot(t_signal(t_lim),x-500*(chnl-1),'color',[160 chnl*255/N 255-chnl*255/N]/255); % color coded based on channel
hold on; 
title([fparts{end}  ', chnl: ' num2str(chnl) ',  Time ref: ' num2str(t0)]); 
end
ylabel('channels'); yticks((-N+1:1:0)*500);  yticklabels(num2cell(fliplr(chnl_order)));  xlabel('Time (sec)');
% since yticks are going upwards, the ytick labels also shall start from
% buttom to up so they are flipped
axis tight

% slect the best channel for event detection by probpting a dialogbox
% prompt = 'Which channel looks best for even detection?';
% dlgtitle = 'Input';
% dims = [1 35];
% definput = {'2','hsv'};
% dinp = inputdlg(prompt,dlgtitle,dims,definput);   k=str2num(dinp{1});
k=5;

%% Ripple detection
uniRip=abs(RippSig(:,k)); % ripple signal rectified for one-sided thresholding
detRip=filtfilt(ones(1,fs/50)/(fs/50),1,uniRip); detRip=detRip/std(detRip); % one-sided signal smoothed and normalized with a 20ms moving average filt

Tr=median(detRip)+3*median(abs(detRip-median(detRip)))/.67; % detection criteria is a factor of std of signal
% detection of sharp waves
up_tresh=abs(detRip).*(abs(detRip)>Tr);
[~,Rip_times] = findpeaks(up_tresh(fs+1:end-fs),'MinPeakDistance',fs/10); % Finding peaks, while omitting 1st sec, and considering minimum
% 100 m sec interval between concequent sharp waves
Rip_indx_=Rip_times+fs; % shifting 1 sec to the right place


% correcting Ripple times, all detected events will be aligned to their
ripps1=zeros(2*fs_/5+1,N,length(Rip_indx_)); % initialization: empty spw matrix, length of spw templates is considered as 400ms
n=1;
while n <= length(Rip_indx_)
    ripps1(:,:,n)=RippSig(Rip_indx_(n)-fs_/5 : Rip_indx_(n)+fs_/5,:); n=n+1;  % spw in the 1st channel
end
% minimum:
[~,min_point]=min(ripps1(:,k,:),[],1); % extracting index of the minimum point for any detected event 
align_err1=min_point-ceil(size(ripps1,1)/2); % Error = min_point - mid_point
align_err=reshape(align_err1,size(Rip_indx_)); 
Rip_indx_=Rip_indx+align_err; % these indices are time-corrected
rippT=time(Rip_indx);

% repicking Ripples events after time alignment
ripps=zeros(2*fs_/5+1,N,length(Rip_indx)); % initialization: empty ripple matrix, length of ripple templates is considered as 400ms
n=1;
while n <= length(Rip_indx)
    ripps(:,:,n)=RippSig(Rip_indx(n)-fs_/5 : Rip_indx(n)+fs_/5,:); n=n+1;  % spw in the 1st channel
end

% plots of detection process:
figure % figure for sharp wave detection
subplot(3,1,1);
plot(t_signal,signal_raw(:,k));  title('Raw signal'); ylabel('(\muV)'); xlim(plot_time);
subplot(3,1,2)
plot(t_signal,RippSig(:,k)), title('Ripple-filtered dange (50-300Hz)'); ylabel('(\muV)');    xlim(plot_time);
subplot(3,1,3)
plot(t_signal,detRip),  title('Detection signal');        xlim(plot_time); hold on
% adding detected ripple times to the last plot
plot(rippT,detRip(Rip_indx),'bv'); xlim(plot_time);
ylabel('SD');

% final figure: Sharp waves + Ripples on LFP (all channels)
figure
for chnl=1:N
plot(t_signal,signal_raw(:,chnl)-500*(chnl-1),'color',[160 chnl*255/N 255-chnl*255/N]/255); % color coded based on channel
hold on; 
if chnl==k % overlay sharp waves and ripple times on the plot
% plot(spwT,signal_raw(spw_indx,chnl)-500*(chnl-1),'+r');  
plot(rippT,signal_raw(Rip_indx,chnl)-500*(chnl-1),'bv');
end
xlim(plot_time)
title(['SPW+Ripples' fparts{end} ],'fontweight','bold'); 
end
ylabel('channels'); yticks((-N+1:1:0)*500);  yticklabels(num2cell(fliplr(chnl_order)));  xlabel('Time (sec)');
% since yticks are going upwards, the ytick labels also shall start from
% buttom to up so they are flipped
