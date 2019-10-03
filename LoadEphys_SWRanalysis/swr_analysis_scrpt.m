% loading all channels of a recording
addpath('D:\github\LabCode\LoadEphys_SWRanalysis');
addpath('D:\github\matlab-plot-big-fast');
addpath('D:\github\CSD analysis\Laminar Timotty Olsen');
selpath=uigetdir('D:\Janie','Select folder containing channels');
% %%%%%%%%% select data directory through the popup menu
addpath(selpath);
chnl_order=[5     4     6     3     9    16    8    1    11    14    12    13    10    15     7     2];  %%%%%%%%%%%%% recording channels with their actual location in order
% this is the mapping of channels: [5     4     6     3     9    16     8  1    11    14    12    13    10    15     7     2], ...
% from most superficial to deepest
add_dir='D:\Janie\ZF-59-15\CSD_SPWtimes_plots'; %%%%%%%%%%%%%%%%%%%%%
fs=30000; %%%%%%%%%%%%%%%% sampling rate

% loading EEG channels
kk=1; % loop variable for loading channels
for chn = chnl_order
    filename =[ '106_CH' num2str(chn) '.continuous'];
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

%% LFP (<100Hz) plot of all channels
% preparation for plot
set(0,'units','pixels');
%Obtains this pixel information
pixls = get(0,'screensize');
figure('Position', pixls);
t0=100; % 18160;
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
print([add_dir '\' [fparts{end} '-RAW']],'-dpng')

%% spw detection by TEO
% Fig 1. Raw and SWR for channel 1
plot_time=100+[0 30.01]; %%%%%%%%%
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
save([add_dir '\' [fparts{end} '-spw_indx']],'spw_indx');

% repicking SPW events after time alignment
spw=zeros(2*fs_/5+1,N,length(spw_indx)); % initialization: empty spw matrix, length of spw templates is considered as 500ms
n=1;
while n <= length(spw_indx)
    spw(:,:,n)=spwsig(spw_indx(n)-fs_/5 : spw_indx(n)+fs_/5,:); n=n+1;  % spw in the 1st channel
end
save([add_dir '\' [fparts{end} '-spw']],'spw');

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
print([add_dir '\' [fparts{end} '-SPW']],'-dpng')

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
print([add_dir '\' [fparts{end} '-CSD']],'-dpng')

% save CSD matrix for further analysis
save([add_dir '\' [fparts{end} '-CSD']],'CSDoutput');

% %% analysisng spw peri-event times
%  % plotting all channels for at a spw event
%  figure
%  ind0=spw_indx(10);
% tlim=t_signal(ind0)+[-.2 .2];
% t_lim=round(tlim(1)*fs_:tlim(2)*fs_);
% for k=1:size(eeg,2)
% x=signal_raw(t_lim,k);
% plot(t_signal(t_lim),x+400*(k-1)); hold on
% xlim(plot_time);
% title([fparts{end}  ',  Time ref: ' num2str(ind0)]); 
% end
% line([t_signal(ind0)  t_signal(ind0)],[-200 16*400],'LineStyle','--');
% axis tight
% %% filtering signal for high frequencies
% % EEG
% eegFilt = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',.1,'HalfPowerFrequency2',3000,'SampleRate',fs);
% EEGfilt=filtfilt(eegFilt,data);
% 
% %% showing traces of filtered EEG
% figure('Position', pixls);
% t0=1; % 18160;
% plot_time=[0 30];
% tlim=t0+plot_time;
% t_lim=tlim(1)*fs:tlim(2)*fs;
% X=EEGfilt(t_lim,:);
% t=time(t_lim);
% plotredu(@plot,t-t0,X);
% ylabel({'EEG'; ['chnl' num2str(chnl)] });      xlim(plot_time);
% title([fparts{end}  ', chnl: ' num2str(chnl) ',  Time ref: ' num2str(t0)]);
% % then plotting EMG
% subplot(nn,1,n+1)
% plotredu(@plot,t-t0,Y);  xlim(plot_time);  ylabel({'EMG'; '(\muV)'});   xlabel('Time (sec)'); ylim([-220 220])
% 
% %% spike detection
% clear spwsig % no need any more
% % filtering for spike band
% SpkFilt = designfilt('bandpassiir','FilterOrder',4, 'HalfPowerFrequency1',300,'HalfPowerFrequency2',3000, 'SampleRate',fs);
% SpkSig=filtfilt(SpkFilt,signal0);
% thr=5*median(abs(SpkSig))/.674; % threshold for spike detection = 4STD of noise
% up_tresh=abs(SpkSig).*(abs(SpkSig)>thr);
% [~,spk_times] = findpeaks(up_tresh(fs/1000+1:end),'MinPeakDistance',fs/1000); % Finding spike peaks, while omitting 1st msec, and considering 1 msec recovery
% spk_times=spk_times+fs/1000; % shifting 1 msec to the right place
% spikes=zeros(length(spk_times),2*fs/1000+1); % empty spike matrix
% n=1;
% while n <= length(spk_times)
%     spikes(n,:)=SpkSig(spk_times(n)-fs/1000 : spk_times(n)+fs/1000); n=n+1;
% end
% 
% % deleting artefacts
% AmpOK_ind=max(spikes,[],2)<100; %%%% only accept the detected spikes that their peak is less than 100 uV
% spikes=spikes(AmpOK_ind,:);
% figure;
% plot((1:2*fs/1000+1)/fs*1000,spikes'); axis tight; xlabel('Time (ms)'); ylabel('Amplitude (\muV)')
% 
% 
% %% spike sorting
% X=spikes;
% Mx=mean(X);
% 
% XX=[];YY=[];
% for i=1:size(X,2)
%     XX(:,i)=X(:,i)-Mx(i);
% end
% [U,S,V]=svd(XX,'econ');
% % Performing PCA and reducting feature space dimension
% V=V(:,1:8);
% projpca=XX*V;
% units=2; %%%%%%%%%% number of putative neurons
% idx = kmeans(projpca(:,1:8),units); % clustering
% % plotting
% X=projpca(1:min(1000,size(spikes,1)),1:3);
% idx_plot=idx(1:min(1000,size(spikes,1)));
% figure;
% plot3(X(idx_plot==1,1),X(idx_plot==1,2),X(idx_plot==1,3),'r.','MarkerSize',12); hold on;
% plot3(X(idx_plot==2,1),X(idx_plot==2,2),X(idx_plot==2,3),'b.','MarkerSize',12)
% plot3(X(idx_plot==3,1),X(idx_plot==3,2),X(idx_plot==3,3),'g.','MarkerSize',12)
% plot3(X(idx_plot==4,1),X(idx_plot==4,2),X(idx_plot==4,3),'m.','MarkerSize',12)
% xlabel('PC1');ylabel('PC2');zlabel('PC3'); axis tight
% %% sorted spikes in one plot
% figure;
% subplot(1,units,1);   plot(((1:2*fs/1000+1)/fs*1000)-1,spikes(idx==1,:)','r'); axis([-1 1 -100 100 ]); xlabel('Time (ms)');    ylabel('Amplitude (\muV)');
% SpkMean(1,:)=mean(spikes(idx==1,:)); hold on, plot(((1:2*fs/1000+1)/fs*1000)-1,SpkMean(1,:),'k','linewidth',2);
% text(-.9,90,['#  ' num2str(sum(idx==1))]);
% if units>1
%     subplot(1,units,2);   plot(((1:2*fs/1000+1)/fs*1000)-1,spikes(idx==2,:)','b'); axis([-1 1 -100 100 ]); xlabel('Time (ms)');    end
% SpkMean(2,:)=mean(spikes(idx==2,:)); hold on, plot(((1:2*fs/1000+1)/fs*1000)-1,SpkMean(2,:),'k','linewidth',2);
% text(-.9,90,['#  ' num2str(sum(idx==2))]);
% if units>2
%     subplot(1,units,3);   plot(((1:2*fs/1000+1)/fs*1000)-1,spikes(idx==3,:)','g'); axis([-1 1 -100 100 ]); xlabel('Time (ms)');    end
% SpkMean(3,:)=mean(spikes(idx==3,:)); hold on, plot(((1:2*fs/1000+1)/fs*1000)-1,SpkMean(3,:),'k','linewidth',2);
% text(-.9,90,['#  ' num2str(sum(idx==3))]);
% if units>3
%     subplot(1,units,4);   plot(((1:2*fs/1000+1)/fs*1000)-1,spikes(idx==4,:)','m'); axis([-1 1 -100 100 ]); xlabel('Time (ms)');    end
% SpkMean(4,:)=mean(spikes(idx==4,:)); hold on, plot(((1:2*fs/1000+1)/fs*1000)-1,SpkMean(4,:),'k','linewidth',2);
% text(-.9,90,['#' num2str(sum(idx==4))]);
% colors={'r','b','g','m'}; % so the colors for future plots
% 
% spk_times_sort={};
% for unit=1:units
%     spk_times_sort{unit}=spk_times(idx==unit)/fs;
% end
% 
% %% Ripple detection
% uniRip=abs(RippSig); % ripple signal rectified for one-sided thresholding
% detRip=filtfilt(ones(1,fs/20)/(fs/20),1,uniRip); detRip=detRip/std(detRip); % one-sided signal smoothed and normalized
% figure % figure for sharp wave detection
% subplot(4,1,1);
% plot(time,signal);  title('Raw signal'); ylabel('(\muV)'); xlim(plot_time);
% subplot(4,1,2)
% plot(time,RippSig), title('Ripples'); ylabel('(\muV)');    xlim(plot_time);
% subplot(4,1,3)
% plot(time,detRip),  title('Detection signal');             xlim(plot_time);
% SD=median(detRip)/.67;  Tr=4*SD; % detection criteria is a factor of std of signal
% hold on; line(plot_time , [Tr Tr],'Color','red','LineStyle','--')
% % detection of sharp waves
% up_tresh=abs(detRip).*(abs(detRip)>Tr);
% [~,Rip_times] = findpeaks(up_tresh(fs+1:end-fs),'MinPeakDistance',fs/4); % Finding peaks, while omitting 1st sec, and considering minimum
% % 250 m sec interval between concequent sharp waves
% Rip_t=Rip_times+fs; % shifting 1 sec to the right place
% % adding detected ripple times to the last plot
% plot(Rip_t/fs,detRip(Rip_t),'rv'); xlim(plot_time);
% ylabel('SD');
% % Spike Train
% subplot(4,1,4)
% hold on
% for unit=1:units
%     spk_time=spk_times_sort{unit};
%     for i=1:length(spk_time)
%         y=units-unit;
%         line([spk_time(i) spk_time(i)],[y+.2 y+.8],'color',colors{unit},'linewidth',1);
%     end
% end
% set(gca,'yticklabels',''); set(gca,'ytick',[]);
% xlabel('Time (sec)','fontweight','normal');
% title('raster plot','fontweight','bold');
% xlim ([plot_time(1) plot_time(2)]); set(gca,'box','off'); ylim([0 units]);
% 
% %% Ripple-related raster plot
% clear edges N F_ T_ P_
% figure;
% subplot(9,1,1:4)
% spkRip=cell(units,1); % for keeping spike times occuring in the temporal vicinity of ripples, so for any ripple, we append spike times of any unit, to the corresponding row ...
% % of this variable
% nRip=length(Rip_times); % number of ripples to show spiking pattern for.
% T=.25; % Time around the SWR complex to analyze
% for k=1:nRip % first loop through ripples
%     t1=Rip_t(k)-T*fs;
%     t2=Rip_t(k)+T*fs;
%     for unit=1:units % second loop for units, each unit in different color
%         spk_time=spk_times_sort{unit};
%         Indx=(spk_time*fs>t1 & spk_time*fs<t2);
%         spk_t=spk_time(Indx)*fs-Rip_t(k);
%         plot(spk_t/fs,k*ones(1,length(spk_t)),'.','color',colors{unit},'markersize',5) ; hold on
%         spkRip{unit,:}=[spkRip{unit,:} , spk_t'/fs];
%     end
% end
% line([0 0], [0 nRip],'Color','black','LineStyle','--'); ylabel('Ripple #'); xticks([]); ylim([0 nRip])
% text(.05,nRip+10,'Ripple-triggered spike activity'); xlim([-T T+0.001]); box off
% 
% % firing rates
% subplot(9,1,5:6)
% for unit=1:units
%     % plot for histogram:
%     [N(unit,:),edges] = histcounts(spkRip{unit,:}, round(nRip*.8));  cntr=edges(1:end-1)+diff(edges); bin=edges(2)-edges(1);
%     h=bar(cntr,N(unit,:)/(bin*nRip),'FaceColor',colors{unit},'FaceAlpha',.4,'EdgeAlpha',0); hold on
%     % plot for fitted curves:
%     %      f=fit(cntr',N(unit,:)','smoothingspline');  plot(f);
% end
% line([0 0], [0 max(N(:)/(bin*nRip))],'Color','black','LineStyle','--');xticks([]);
% axis([-T T+0.001 0 max(N(:)/(bin*nRip))]); ylabel('spk/sec'); legend('off')
% text(0.18,max(N(:)/(bin*nRip))+5,'firing rates'); box off
% 
% % spiking distribution boxplot
% subplot(9,1,7) % we would like to add a boxplot of dispersion of spike times around SWR. First we shall determine how many spikes we have in eac time bin:
% datapoints=cell(units,1);
% for unit= 1:units
%     for bin=cntr
%         datapoints{unit,:}=[datapoints{unit,:} cntr(cntr==bin)*ones(1,N(unit,cntr==bin))];
%     end
%     % padding with NaN, why? Because the number of spikes are not the same for
%     % the different neurons, so this way, creation of boxplot is easier
%     datapoints{unit,:}=[datapoints{unit,:} NaN(1,sum(N(:))-length(datapoints{unit,:})  )];
% end
% line([0 0], [0 units+1],'Color','black','LineStyle','--'); hold on % zero line (start of SWR)
% boxplot(cell2mat(datapoints)','orientation','horizontal','color','rbgm','width',.7,'symbol','w','whisker',0);
% ylabel('units')
% xlim([-T T+0.001]); xticks([]); text(.05,units+.8,'temporal distribution of firings'); box off
% 
% % Time-Frequency spectrum of LFP surrounding ripple initiation
% for rip=1:10
%     t0=Rip_t(rip);
%     freq=4:10:270; %Frequencies we are interested in
%     % dertermining number of samples around the ripple onset to analyze:
%     min_freq=2;
%     nsmpl=round((1/min_freq)*2*fs);
%     n=2^(nextpow2(nsmpl)-1); %Number of points in moving window
%     indRip =t0-nsmpl:t0+nsmpl; % samples surrounding a ripple onset
%     [~,F_,T_,P_(:,:,rip)]=spectrogram(signal(indRip),n,round(.80*n),freq,fs,'yaxis');
%     maxDb=20; %Maximum on scale for decibels.
% end
% Prip=sum(P_,3);
% %Plot spectrogrm
% subplot(9,1,8:9)
% surf((T_-nsmpl/fs)*1000,F_,10*log10(Prip)); colormap('jet'); shading interp; view(0,90)
% axis([[-T T+.001]*1000, 0 max(freq)]); xlabel('Time (m sec)'); ylabel('Frequency (Hz)');  colorbar off
% hold on; plot3([0 0], F_([1 end]),max(Prip(:))*[1.1 1.1],'Color','black','LineStyle','--');
% text(75,max(freq)+12,'LFP spectrogram (SW-R)'), box off
