function [] = swr_analysis_fun(selpath)
% loading all channels of a recording
addpath('D:\github\LabCode\LoadEphys_SWRanalysis');
addpath('D:\github\matlab-plot-big-fast');
addpath('D:\github\CSD analysis\Laminar Timotty Olsen');
% %%%%%%%%% select data directory through the popup menu
addpath(selpath);
chnl_order=[5     4     6     3     9    16    8    1    11    14    12    13    10    15     7     2];  %%%%%%%%%%%%% recording channels with their actual location in order
% this is the mapping of channels: [5     4     6     3     9    16     8  1    11    14    12    13    10    15     7     2], ...
% from most superficial to deepest
save_dir='D:\Janie\ZF-60-88\zf-60-88-CSD_SPWtimes_plots';  % directory to save results
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

%% downsampling for SW and Ripples detection, fromm 30000 to 3000
signal_raw=downsample(eeg,10);
t_signal=downsample(time,10);
fs_=fs/10;

% filtering for SWR and figures
% filtering for sharp wave:
ShFilt = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',1,'HalfPowerFrequency2',40, 'SampleRate',fs_);
spwsig=filtfilt(ShFilt,signal_raw);
% for ripples
RippFilt = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',40,'HalfPowerFrequency2',300, 'SampleRate',fs_);
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
tt=time(t_lim);
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
print([save_dir '\' [fparts{end} '-RAW']],'-dpng')

%% spw detection , TEO
% Fig 1. Raw and SWR for channel 1
plot_time=1+[0 30.01]; %%%%%%%%%
figure,
subplot(4,1,1); o1=plotredu(@plot,t_signal,signal_raw(:,1)); title(['Raw signal  ' fparts{end}  '  Time ref: ' num2str(t0) ' sec'])
ylabel('(\muV)'); xlim(plot_time); ylim([-400 270])
% Fig 1 (SW & R)
subplot(4,1,2); plotredu(@plot, t_signal,spwsig(:,1),'k');
title('Filtered 1-100Hz (SPW)' ); ylabel('(\muV)'); xlim(plot_time); ylim([-400 270])
subplot(4,1,3); o3=plotredu(@plot,t_signal,RippSig(:,1),'r');
title('Filtered 40-300Hz (Ripples)' ); ylabel('(\muV)');
xlim(plot_time);

% Fig 3 ( ShR )
% here we extract a threshold for spw detection using Teager enery 
subplot(4,1,4);
tig=teager(spwsig,[fs_/20]);
[~,k]=max(var(spwsig)); % channel to show TEO and spw detection for  %%%%%%%%%%%%%
plotredu(@plot,t_signal,tig(:,k),'b'); title('TEO ' ); ylabel('(\muV^2)'); xlabel('Time (Sec)'); xlim(plot_time);
thr=median(tig)+8*iqr(tig); % threshold for detection of spw
% plotting distribution of TEO values and the threshold for spw detection
figure % distribution of TEO values for channel k  %%%%%%%%%%%%%%%
hist(tig(:,k),300); y=ylim;  hold on; line([thr(k) thr(k)],y,'LineStyle','--')

% plot for raw data + spw detection threshold
figure;
subplot(2,1,1); 
plotredu(@plot,t_signal,spwsig(:,k)); title(['LFP (1-100 Hz)  ' fparts{end}  '  Time ref: ' num2str(t0) ' sec']);  ylabel('(\muV)');   xlim(plot_time)
subplot(2,1,2); 
plotredu(@plot,t_signal,tig(:,k),'b'); hold on; line(plot_time,[thr(k) thr(k)],'LineStyle','--');  title('TEO ' ); 
ylabel('(\muV^2)'); xlabel('Time (Sec)'); xlim(plot_time); axis tight

%% making template of spws based on spw detection
up_tresh=tig.*(tig>thr);
[~,spw_indices1] = findpeaks(up_tresh(fs_+1:end-fs,k)); % Finding peaks in the channel with max variance, omitting the 1st and last sec ...

% Now we remove concecutive detected peaks with less than .1 sec interval 
spw_interval=[1; diff(spw_indices1)]; % assigning the inter-SPW interval to the very next SPW. If it is longer than a specific time, that SPW is accepted.
% of course the first SPW is alway accepted so w assign a long enough
% interval to it (1).
spw_indices=spw_indices1(spw_interval>.3*fs_);

spw_indices=spw_indices+fs_; % shifting 1 sec to the right place for the corresponding time (removal of 1st second is compensared)
spw1=zeros(2*fs_/5+1,N,length(spw_indices)); % initialization: empty spw matrix, length of spw templates is considered as 500ms
n=1;
while n <= length(spw_indices)
    spw1(:,:,n)=spwsig(spw_indices(n)-fs_/5 : spw_indices(n)+fs_/5,:); n=n+1;  % spw in the 1st channel
end

% removing upward detected-events
indx=spw1(round(size(spw1,1)/2),k,:)<mean(spw1([1 end],k,:),1); % for valid spw, middle point shall occur below the line connecting the two sides
spw_=spw1(:,:,indx);
spw_indx1=spw_indices(indx); % selected set of indices of SPWs that are downward 
% correcting SPW times, all detected events will be aligned to their
% minimum:
[~,min_point]=min(spw_(:,k,:),[],1); % extracting index of the minimum point for any detected event 
align_err1=min_point-ceil(size(spw_,1)/2); % Error = min_point - mid_point
align_err=reshape(align_err1,size(spw_indx1)); 
spw_indx=spw_indx1+align_err; % these indices are time-corrected
save([save_dir '\' [fparts{end} '-spw_indx']],'spw_indx');

% repicking SPW events after time alignment
spw=zeros(2*fs_/5+1,N,length(spw_indx)); % initialization: empty spw matrix, length of spw templates is considered as 500ms
n=1;
while n <= length(spw_indx)
    spw(:,:,n)=spwsig(spw_indx(n)-fs_/5 : spw_indx(n)+fs_/5,:); n=n+1;  % spw in the 1st channel
end
save([save_dir '\' [fparts{end} '-spw']],'spw');

% plotting all spws and the average shape, for channel k which is the one
% with maximum variance
figure('Position', [460 100 600 600]);
subplot(1,2,1)
for i=1:size(spw,3)
plot((-fs_/5:fs_/5)/fs_*1000,spw(:,k,i)); hold on
end; axis tight; xlabel('Time (ms)'); ylabel('Amplitude (\muV)')
axis([-200 200 -750 150]);
title('SPWs in max variance chnl')

% plot of average SPWs across channels
subplot(1,2,2)
hold on
for chnl=1:N
plot((-fs_/5:fs_/5)/fs_*1000,mean(spw(:,chnl,:),3), ...
    'color',[220 chnl*255/N 255-chnl*255/N]/255); % color coded based on channel
end
axis([-200 200 -400 50]); xlabel('Time (ms)');  
title({'mean SPW accross chnls'; ['rate: ' num2str( round(size(spw,3) / max(time)*60 ,1)) '/min  ' fparts{end}]}); ylabel('Amplitude (\muV)')
print([save_dir '\' [fparts{end} '-SPW']],'-dpng')

figure;
subplot(2,1,1); 
plotredu(@plot,t_signal,signal_raw(:,1)); title('Raw signal ' );  ylabel('(\muV)'); 
hold on; plot(t_signal(spw_indx),signal_raw(spw_indx),'+r');  xlim(plot_time)
subplot(2,1,2); 
plotredu(@plot,t_signal,tig(:,k),'b'); hold on; line(plot_time,[thr(k) thr(k)],'LineStyle','--');  title('TEO ' ); 
ylabel('(\muV^2)'); xlabel('Time (Sec)'); xlim(plot_time); axis tight

% garbage cleaning
 clear spw_times up_tresh spw1 align_err align_err1

 %% Current Sourse Density Analysis
avg_spw=mean(spw,3)*10^-6; % for further use in ''SCD'' analysis, data turns to Volts instead of uV
spacing=100*10^-6; %%%%%%%%%%% spacing between neiboring electrodes
CSDoutput = CSD(avg_spw,fs_,spacing,'inverse',5*spacing)';
figure;

subplot(1,3,1) % CSD
t_peri=(-fs_/5:fs_/5)./fs_*1000; % peri-SPW time
y_peri=(1-.5:N-.5)'; % y values for CSD plot, basically electrode channels , we centered the y cvalues so ...
% they will be natural numbers + .5
imagesc(t_peri,y_peri,CSDoutput, [-8 7]); yticks(.5:1:N-.5);  yticklabels(num2cell(chnl_order)); 
ylabel(' ventral <--                    Electrode                    --> dorsal');  colormap(flipud(jet)); % blue = sink; red = sourse
xlabel('peri-SPW time (ms)');      title('CSD (\color{red}sink, \color{blue}source\color{black})');

subplot(1,3,2) % smoothed CSD (spline), we interpolate CSD values in a finer grid
t_grid=repmat(t_peri,length(y_peri)+2,1); % grid for current t values, to extra rows for beginning (zero), and the last natural full number, just ...
% greater than last row which includes a .5 portion
y_grid=repmat([0 ; y_peri ; N] , 1,length(t_peri)); % grid for current y values
t_grid_ext=repmat(t_peri,10*N,1); % new fine t grid
y_grid_ext=repmat((.1:.1:N)',1,size(t_grid,2)); % new fine y grid
[csd_smoo]=interp2( t_grid , y_grid ,[CSDoutput(1,:) ; CSDoutput ; CSDoutput(end,:)],t_grid_ext,y_grid_ext, 'spline'); % interpolation of CSD in a finer grid
imagesc((-fs_/5:fs_/5)./fs_*1000,(.1:.1:N)',csd_smoo,  [-8 7]); % fixing the color range for comparing different data
yticks(.5:1:N-.5);  yticklabels(num2cell(chnl_order)); 
ylabel('Electrode');  colormap(flipud(jet)); % blue = source; red = sink
xlabel('peri-SPW time (ms)');      title('smoothed CSD (\color{red}sink, \color{blue}source\color{black})');

subplot(1,3,3) % LFP
s=imagesc((-fs_/5:fs_/5)./fs_*1000,1:N,flipud(avg_spw)', [-60 6]*1e-5); yticks(1:1:N); yticklabels(num2cell(fliplr(chnl_order))); 
ylabel('Electrode');  colormap(flipud(jet));
xlabel('peri-SPW time (ms)');   title(['LFP' fparts{end}])
print(['C:\Users\Spike Sorting\Desktop\Chicken\' [fparts{end} '-CSD']],'-dpng'); % save the plot
print([save_dir '\' [fparts{end} '-CSD']],'-dpng')

% save CSD matrix for further analysis
save([save_dir '\' [fparts{end} '-CSD']],'CSDoutput');
