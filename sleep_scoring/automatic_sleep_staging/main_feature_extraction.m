% load staged bin:
staged_bins=load('D:\github\Lab Code\sleep_scoring\result\72_94_29_05_2020'); %%%%%%%%

% putting EEG and movement for each stage in a separate variable
% variable initiation:
fs=30000/128;
N=2740; % number of annotated bins
t_label=zeros(N,1);
label=cell(N,1);
EEG=zeros(1171,16,N);
movement=zeros(N,60);
for k=1:N % depending on the labeled data
t_label(k)=staged_bins.sleep_scores(k).time;
label{k}=staged_bins.sleep_scores(k).label;
if strcmp(label{k},'SWS')
    label{k}='nREM';
elseif strcmp(label{k},'IS')
    label{k}='Drowsy';
end
EEG(:,:,k)=staged_bins.sleep_scores(k).EEG(1:1171,:);
movement(k,:)=staged_bins.sleep_scores(k).movement;
end


%% bar graph comparing movement across stages
stage={'Wake','Drowsy','nREM','REM'};
move_Wake=zeros(1,60);
move_Drowsy=zeros(1,60);
move_nREM=zeros(1,60);
move_REM=zeros(1,60);
for k=1:N
    switch label{k}
                case stage{1}
        move_Wake=[move_Wake; movement(k,:)];
                case stage{2}
        move_Drowsy=[move_Drowsy; movement(k,:)];
                case stage{3}
        move_nREM=[move_nREM; movement(k,:)];
                case stage{4}
        move_REM=[move_REM; movement(k,:)];
    end
end
        
figure
m=[mean(move_Wake(:)) mean(move_Drowsy(:)) mean(move_nREM(:)) mean(move_REM(:))];
std_=[std(move_Wake(:)) std(move_Drowsy(:)) std(move_nREM(:)) std(move_REM(:))];
size_=[size(move_Wake ,1) size(move_Drowsy ,1) size(move_nREM ,1) size(move_REM ,1) ];
err=2*std_./sqrt(size_);
b=bar(1:4, m);
b(1).FaceColor = [.5 .6 0];

hold on
er=errorbar(1:4, m,err);
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
xticklabels({'Wake','Drowsy','nREM','REM'})
ylabel('Movement (pixel displacement)')
title('Body movement across stages in manually annotated data')
ylim([1000 2300])

%%  plot EEG to find and ignore noisy chnls
figure
bin_indx=find(strcmp(label,'REM')); % index to the first nREM bin
eegn=size(EEG,1);
for k=1:16
plot(round(0:3*eegn/5)/fs,(EEG(round(eegn/5:4*eegn/5),k,bin_indx(70)))+2.5*k); hold on
end
yticks(2.5*(1:16)), yticklabels(compose('%01d', 1:16));
ylabel('Channel number')
xlabel('Time (sec)')
chnls=[1:10 12:16]; %%%%%%%%%%%% non-noisy channels
%% spectrum across groups 
% for nREM
nwin=size(EEG,1);
nfft=2^(nextpow2(nwin));
TW=2.5; % 2W=1; % I want to have .5 Hz resoluted, so W=1, T=5, so 2TW constant=3
% for nREM
bin_indx=find(strcmp(label,'nREM')) ;
for k=1:length(bin_indx)
    [pxx_nREM(:,:,k),f] = pmtm(EEG(round(eegn/5:4*eegn/5),chnls,bin_indx(k)),TW,nfft,round(fs));
end

% for REM
bin_indx=find(strcmp(label,'REM')) ;
for k=1:length(bin_indx)
    [pxx_REM(:,:,k),f] = pmtm(EEG(round(eegn/5:4*eegn/5),chnls,bin_indx(k)),TW,nfft,round(fs));
end
% for wake
bin_indx=find(strcmp(label,'Wake')) ;
for k=1:length(bin_indx)
    [pxx_Wake(:,:,k),f] = pmtm(EEG(round(eegn/5:4*eegn/5),chnls,bin_indx(k)),TW,nfft,round(fs));
end

% for drowsy
bin_indx=find(strcmp(label,'Drowsy')) ;
for k=1:length(bin_indx)
    [pxx_Drowsy(:,:,k),f] = pmtm(EEG(round(eegn/5:4*eegn/5),chnls,bin_indx(k)),TW,nfft,round(fs));
end
% computing mean and STE
mean_spec_nREM=mean(pxx_nREM,3);
mean_spec_REM=mean(pxx_REM,3);
mean_spec_Wake=mean(pxx_Wake,3);
mean_spec_Drowsy=mean(pxx_Drowsy,3);

ste_spec_nREM=std(pxx_nREM,0,3)/sqrt(size(pxx_nREM,3));
ste_spec_REM=std(pxx_REM,0,3)/sqrt(size(pxx_REM,3));
ste_spec_Wake=std(pxx_Wake,0,3)/sqrt(size(pxx_Wake,3));
ste_spec_Drowsy=std(pxx_Drowsy,0,3)/sqrt(size(pxx_Drowsy,3));


figure
for k=1:length(chnls)
    subplot(4,4,k)
    plot(f,log10(mean_spec_nREM(:,k)),'b','linewidth',2);  hold on
    plot(f,log10(mean_spec_REM(:,k)),'r','linewidth',2)
    plot(f,log10(mean_spec_Wake(:,k)),'color',[1 .9 0],'linewidth',2)
    plot(f,log10(mean_spec_Drowsy(:,k)),'c','linewidth',2)
    xlim([0 40]); ylim([-3.5 -1.5]) %%%%%%%%
end
subplot(4,4,4)
legend('nREM','REM','Wake','Drowsy')

% just REM and nREM
std_spec_nREM=std(pxx_nREM,0,3);
std_spec_REM=std(pxx_REM,0,3);
std_spec_Wake=std(pxx_Wake,0,3);
std_spec_Drowsy=std(pxx_Drowsy,0,3);
figure
for k=1:length(chnls)
    subplot(4,4,k)
    plot(f,log10(mean_spec_nREM(:,k)),'b','linewidth',2);  hold on
    plot(f,log10(mean_spec_nREM(:,k)+std_spec_nREM(:,k)),'b');  
    plot(f,log10(mean_spec_nREM(:,k)-std_spec_nREM(:,k)),'b');  

    plot(f,log10(mean_spec_REM(:,k)),'r','linewidth',2)
    plot(f,log10(mean_spec_REM(:,k)+std_spec_REM(:,k)),'r');  
    plot(f,log10(mean_spec_REM(:,k)-std_spec_REM(:,k)),'r');
    xlim([0 40]); ylim([-3.5 -1.5]) %%%%%%%%
end

%% statistical moments for EEG across stages
chnl=4; %%%%%%%%%% channel of EEG to do the computations on
% Wake
bin_indx=find(strcmp(label,'Wake')) ;
for k=1:length(bin_indx)
    var_Wake(k)=var(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
    skew_Wake(k)=skewness(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
    kurto_Wake(k)=kurtosis(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
end 
% Drowsy
bin_indx=find(strcmp(label,'Drowsy')) ;
for k=1:length(bin_indx)
    var_Drowsy(k)=var(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
    skew_Drowsy(k)=skewness(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
    kurto_Drowsy(k)=kurtosis(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
end 
% nREM
bin_indx=find(strcmp(label,'Wake')) ;
for k=1:length(bin_indx)
    var_nREM(k)=var(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
    skew_nREM(k)=skewness(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
    kurto_nREM(k)=kurtosis(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
end 
% REM
bin_indx=find(strcmp(label,'Wake')) ;
for k=1:length(bin_indx)
    var_REM(k)=var(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
    skew_REM(k)=skewness(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
    kurto_REM(k)=kurtosis(EEG(round(eegn/5:4*eegn/5),chnl,bin_indx(k)));
end 
% violin plot
mom1{:,1}=var_Wake;
mom1{:,2}=var_Drowsy;
mom1{:,3}=var_nREM;
mom1{:,4}=var_REM;

mom2{:,1}=skew_Wake;
mom2{:,2}=skew_Drowsy;
mom2{:,3}=skew_nREM;
mom2{:,4}=skew_REM;

mom3{:,1}=kurto_Wake;
mom3{:,2}=kurto_Drowsy;
mom3{:,3}=kurto_nREM;
mom3{:,4}=kurto_REM;

colors=[1 .8 0; 0 1 1; 0 0 1; 1 0 0];
xlabels={'Wake','Drowsy','nREM','REM'};
figure
subplot(1,3,1)
[h,l]=violin(mom1,'facecolor',colors,'mc','','medc','k','edgecolor',''); ylim([-.1 1.6])
xticks(1:4);xticklabels(xlabels); l.Visible='off'; title('EEG variance')

subplot(1,3,2)
[h,l]=violin(mom2,'facecolor',colors,'mc','','medc','k','edgecolor',''); ylim([-1.7 2.5])
xticks(1:4);xticklabels(xlabels); l.Visible='off'; title('EEG skewness')

subplot(1,3,3)
[h,l]=violin(mom3,'facecolor',colors,'mc','','medc','k','edgecolor',''); ylim([1 17.5])
xticks(1:4);xticklabels(xlabels); l.Visible='off'; title('EEG kurtosis')

%% dimentionality reduction
selEEG=EEG(round(eegn/5:4*eegn/5),chnl,:);
eeg_sel=reshape(selEEG,length(round(eegn/5:4*eegn/5)),size(EEG,3));
figure    
Y = tsne(eeg_sel(:,1:1000)','Perplexity',700);
g=gscatter(Y(:,1),Y(:,2),label(1:1000),colors,'.',10*ones(1,4)); % (x,y,g,clr,sym,siz) color clr, symbol sym, and size siz for each group.
