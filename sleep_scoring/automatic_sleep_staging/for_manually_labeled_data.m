% load staged bin:
staged_bins=load('D:\github\Lab Code\sleep_scoring\result\72_94_29_05_2020'); %%%%%%%%

% extracting variables from the file: EEG, Movement, label, and time
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
        label{k}='nREM';
    end
    EEG(:,:,k)=staged_bins.sleep_scores(k).EEG(1:1171,:);
    movement(k,:)=staged_bins.sleep_scores(k).movement;
end


%% bar graph comparing movement across stages
stage={'Wake','IS','nREM','REM'};
move_Wake=zeros(1,60);
move_IS=zeros(1,60);
move_nREM=zeros(1,60);
move_REM=zeros(1,60);
for k=1:N
    switch label{k}
        case stage{1}
            move_Wake=[move_Wake; movement(k,:)];
        case stage{2}
            move_IS=[move_IS; movement(k,:)];
        case stage{3}
            move_nREM=[move_nREM; movement(k,:)];
        case stage{4}
            move_REM=[move_REM; movement(k,:)];
    end
end

figure
m=[mean(move_Wake(:)) mean(move_IS(:)) mean(move_nREM(:)) mean(move_REM(:))];
std_=[std(move_Wake(:)) std(move_IS(:)) std(move_nREM(:)) std(move_REM(:))];
size_=[size(move_Wake ,1) size(move_IS ,1) size(move_nREM ,1) size(move_REM ,1) ];
err=2*std_./sqrt(size_);
b=bar(1:4, m);
b(1).FaceColor = [.5 .6 0];

hold on
er=errorbar(1:4, m,err);
er.Color = [0 0 0];
er.LineStyle = 'none';
xticklabels({'Wake','IS','nREM','REM'})
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


%% dimentionality reduction
% two features of tSNE of EEG
selEEG=EEG(round(eegn/5:4*eegn/5),chnl,:);
eeg_sel=reshape(selEEG,length(round(eegn/5:4*eegn/5)),size(EEG,3));
[Y,loss] = tsne(eeg_sel','Perplexity',min(1000, round(.9*size(eeg_sel,2))));
figure
g=gscatter(Y(:,1),Y(:,2),label,colors,'.',10*ones(1,4)); % (x,y,g,clr,sym,siz) color clr, symbol sym, and size siz for each group.
xlabel('tSNE 1');  ylabel('tSNE 2')
% PCA of fft of movement (main frequncy in mody movement)
movement_f=abs(fft(movement')');
[~,move_f_reduced,~] = pca(movement_f) ;
Y(:,3)=move_f_reduced(:,1);

% 2D plot of feature
figure
subplot(1,2,1)
g=gscatter(Y(:,1),Y(:,3),label,colors,'.',10*ones(1,4)); % (x,y,g,clr,sym,siz) color clr, symbol sym, and size siz for each group.
ylim([-.1 .3]*1e5)
subplot(1,2,2)
g=gscatter(Y(:,2),Y(:,3),label,colors,'.',10*ones(1,4)); % (x,y,g,clr,sym,siz) color clr, symbol sym, and size siz for each group.
ylim([-.1 .3]*1e5)

% 3D plot of features
clr(strcmp(label,'Wake'),:)=repmat([1 .8 0],sum(strcmp(label,'Wake')),1);
clr(strcmp(label,'Drowsy'),:)=repmat([0 1 1],sum(strcmp(label,'Drowsy')),1);
clr(strcmp(label,'nREM'),:)=repmat([0 0 1],sum(strcmp(label,'nREM')),1);
clr(strcmp(label,'REM'),:)=repmat([1 0 0],sum(strcmp(label,'REM')),1);
figure
scatter3(Y(:,1),Y(:,2),Y(:,3),20,clr,'filled'); zlim([-.1 .03]*1e5)

%% feature extraction for classification
% variable definitions
L=length(EEG(:,4,1)); % length of EEG
feats=zeros(size(EEG,3),7);
% for excluding the artifact in EEG and defining the bins for entropy
alleeg=EEG(:,chnl,:); 
m=median(alleeg(:));
d=2*iqr(alleeg(:));
bins=m-d:2*d/50:m+d;
for n=1:size(EEG,3)
    x=reshape(EEG(:,chnl,n),L,1).*hann(L);
    bandp= bandpower(x,fs,[.5 50]); % power over all frequency ranges for normalizing
    feats(n,1) = bandpower(x,fs,[.5 4])./bandp; % delta
    feats(n,2) = bandpower(x,fs,[4 8])./bandp; % theta
    feats(n,3) = bandpower(x,fs,[8 13])./bandp; % alpha
    feats(n,4) = bandpower(x,fs,[13 30])./bandp; % beta
    feats(n,5) = bandpower(x,fs,[30 50])./bandp; % gamma
    h1=histogram(EEG(round(L/5:4*L/5),chnl,n),bins, 'Normalization', 'Probability');   p=h1.Values;
    feats(n,6)= entropy_sig(p); % entropy
    h1=histogram(abs(fft(EEG(round(L/5:4*L/5)),chnl,n)),bins, 'Normalization', 'Probability');   p=h1.Values;
    feats(n,7)= entropy_sig(p); % entropy
end
feats=zscore(feats);

%% extraction of the typical samples of each stage
indx_REM=find(strcmp(label,'REM'));
[gammas,indx_high_gamma]=sort(feats(indx_REM,5)-feats(indx_REM,2)-feats(indx_REM,1),'descend'); % pick the ones with highest gamma
indx_typical_REM=indx_REM(indx_high_gamma(1:100));

indx_nREM=find(strcmp(label,'nREM'));
[lowFreq,indx_low_freq]=sort(feats(indx_nREM,1),'descend'); % pick the ones with highest gamma
indx_typical_nREM=indx_nREM(indx_low_freq(1:100));

indx_Wake=find(strcmp(label,'Wake'));
ind_Wake=randsample(length(indx_Wake),100);
indx_typical_Wake=indx_Wake(ind_Wake);

%% classification with kNN
label_auto=cell(N,1);
ind_class=[indx_typical_nREM; indx_typical_REM];
Mdl = fitcknn(feats(ind_class,[1:5]),label(ind_class),'NumNeighbors',50); %  ,'Distance','mahalanobis','Cov',cov(feats(:,[1 5]))
sleep_ind=find(mean(movement,2)<1530);  % detection of sleep
% assigning the 'Wake' label
Wake_ind=find(mean(movement,2)>=1530);  % detection of sleep
for k=1:length(Wake_ind)
label_auto{Wake_ind(k)}='Wake';
end

% assigning the REM/nREM labels
[label_knn,score,~] = predict(Mdl,feats(sleep_ind,[1:5])); 
% (score) indicates the likelihood that a label comes from a particular class
thresh=1; % min TP for both classes 
elig_ind=score(:,1)>=thresh | score(:,2)>=thresh; % index to the label_knn when the score in one class is more than threshold, thresh
label_auto(sleep_ind(elig_ind))=label_knn(elig_ind);

IS_ind=sleep_ind(not(elig_ind));  % detection of IS bins
for k=1:length(IS_ind)
label_auto{IS_ind(k)}='IS';
end

agreement=sum(strcmp(label_auto,label))/length(label)
IS_percentage=sum(strcmp(label_auto,'IS'))/length(label)
REM_sensitivity=sum(strcmp(label_auto,'REM') & strcmp(label,'REM'))/sum(strcmp(label,'REM'))
nREM_sensitivity=sum(strcmp(label_auto,'nREM') & strcmp(label,'nREM'))/sum(strcmp(label,'nREM'))

%% plot of classified samples

figure
hp1 = uipanel('position',[0 0 .5 1]);
hp2 = uipanel('position',[.5 0 .5 1]);
cols=[1 .8 0; 1 0 0; 0 1 1;0 0 1];
scatterhist(feats(:,1),feats(:,5),'Group',label_auto,'Kernel','on','Location','SouthWest',...
    'Direction','out','Color',cols,'LineStyle',{'-','-.',':'},...
    'LineWidth',[2,2,2],'Marker','.','MarkerSize',[12,12,12],'Parent',hp1);
xlabel('Delta power'); ylabel('Gamma power'); title('Automatic scoring')
axes('Parent',hp2);
cols=[1 .8 0; 0 0 1; 1 0 0];
scatterhist(feats(:,1),feats(:,5),'Group',label,'Kernel','on','Location','SouthWest',...
    'Direction','out','Color',cols,'LineStyle',{'-','-.',':'},...
    'LineWidth',[2,2,2],'Marker','.','MarkerSize',[12,12,12]);
xlabel('Delta power'); ylabel('Gamma power'); title('Manual scoring')


% plot of time series samples of each stage
% selection of best 20 of each stage
indx_REM_=find(strcmp(label_auto,'REM'));
[gammas,indx_high_gamma]=sort(feats(indx_REM_,5),'descend'); % pick the ones with highest gamma
indx_typical_REM_=indx_REM_(indx_high_gamma(1:20));

indx_nREM_=find(strcmp(label_auto,'nREM'));
[lowFreq,indx_low_freq]=sort(feats(indx_nREM_,1),'descend'); % pick the ones with highest gamma
indx_typical_nREM_=indx_nREM_(indx_low_freq(1:20));

indx_Wake_=find(strcmp(label_auto,'Wake'));
ind_Wake_=randsample(length(indx_Wake_),20);
indx_typical_Wake_=indx_Wake_(ind_Wake_);

indx_IS_=find(strcmp(label_auto,'IS'));
ind_IS_=randsample(length(indx_IS_),20);
indx_typical_IS_=indx_Wake(ind_IS_);

figure
subplot(1,3,1)
for k=1:20
plot((1:round(.6*L))/fs,EEG(round(L/5:4*L/5),4,indx_typical_REM_(k))/2+k); hold on
end
title('sample detected REM'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20); ylabel('Sample #')
subplot(1,3,2)
for k=1:20
plot((1:round(.6*L))/fs,EEG(round(L/5:4*L/5),4,indx_typical_nREM_(k))/2+k); hold on
end
title('sample detected nREM'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20); ylabel('Sample #')
subplot(1,3,3)
for k=1:20
plot((1:round(.6*L))/fs,EEG(round(L/5:4*L/5),4,indx_typical_IS_(k))/2+k); hold on
end
title('sample detected IS'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20); ylabel('Sample #')


%% plot of time series of outliers of each stage 
% selection of worst 20 of each stage

indx_REM_=find(strcmp(label_auto,'REM'));
[gammas,indx_high_gamma]=sort(feats(indx_REM_,5),'ascend'); % pick the ones with highest gamma
indx_typical_REM_=indx_REM_(indx_high_gamma(1:20));

indx_nREM_=find(strcmp(label_auto,'nREM'));
[lowFreq,indx_low_freq]=sort(feats(indx_nREM_,1),'ascend'); % pick the ones with highest gamma
indx_typical_nREM_=indx_nREM_(indx_low_freq(1:20));

figure
subplot(1,2,1)
for k=1:20
plot((1:round(.6*L))/fs,EEG(round(L/5:4*L/5),4,indx_typical_REM_(k))/2+k); hold on
end
title('sample detected REM'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20); ylabel('Sample #')
subplot(1,2,2)
for k=1:20
plot((1:round(.6*L))/fs,EEG(round(L/5:4*L/5),4,indx_typical_nREM_(k))/2+k); hold on
end
title('sample detected nREM'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20); ylabel('Sample #')

%% apEntropy across classes
stage={'Wake','IS','nREM','REM'};
r=.2*std(EEG(:,chnl,:),0,'all'); % distance for AppEnt
apent=zeros(4,50);
for n=1:4
    stg_ind=find(strcmp(label_auto,stage{n})); % index to the epochs of current stage, e.g. 'Wake'
    ind_50=randsample(length(stg_ind),100);
    for k=1:50
        apent(n,k)=appent(2,r,EEG(:,4,stg_ind(k))); % approx_entropy(win_len,distance,data)
    end
end

figure
errorbar(mean(apent,2)*100/mean(apent(:))-100,(std(apent,0,2)/sqrt(50))*100/mean(apent(:)));
xlim([0 5]);   xticks(1:4);   xticklabels(stage); title('Approximate Entropy across stages (mean,conf interval)')
ylabel('% AppEntropy Change')

%% automatically separating Wake/REM based on movement statistics
% we feat a distribution and find the peak and std of the REM group
mov=mean(movement,2);
pd=fitdist(mov,'kernel'); 
x_vals=min(mov):range(mov)/500:mean(mov)+5*std(mov);
mov_pd=pdf(pd,x_vals);
figure
plot(x_vals,mov_pd,'color',[0 0 .7],'linewidth',1); hold on

histogram(mov,1000,'Normalization','pdf','edgecolor','none')
xlim([min(mov)-.3*std(mov)  mean(mov)+3*std(mov)])
[M,I] = max(mov_pd); mov_peack=x_vals(I);
threshold=mov_peack+iqr(mov); % threshold on movement to differentiate Wake/REM
line([threshold threshold],[0 1.5*M],'linestyle','--');  
ylim([0 1.3*M])
legend('movements pdf','movements histogram','threshold line')
xlabel('Movement (pixels)'); ylabel('pdf (probability)')

% computing the percentage of Wake/REM detections
move_correct=sum( mean(movement(strcmp(label,'Wake'),:),2)>=threshold)/ ...
    sum(strcmp(label,'Wake'))
REM_correct=sum( mean(movement(strcmp(label,'REM'),:),2)<threshold)/ ...
    sum(strcmp(label,'REM'))


%% 








