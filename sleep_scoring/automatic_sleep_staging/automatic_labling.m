%%  plot EEG to find and ignore noisy chnls
figure
bin_indx=randsample(size(EEG,3)-1000,1)+500; % index to the first nREM bin
eegn=size(EEG,1);
for k=1:16
    plot(round(1:eegn)/fs,(EEG(:,k,bin_indx))+.5*k); hold on
end
yticks(2*(1:16)), yticklabels(compose('%01d', 1:16));
ylabel('Channel number')
xlabel('Time (sec)')

chnl=4; %%%%%%%%%%
%% feature extraction for classification
% variable definitions
L=length(EEG(:,4,1)); % length of EEG
feats=zeros(size(EEG,3),5);
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
%     h1=histogram(EEG(round(L/5:4*L/5),chnl,n),bins, 'Normalization', 'Probability');   p=h1.Values;
%     feats(n,6)= entropy_sig(p); % entropy
%     h1=histogram(abs(fft(EEG(round(L/5:4*L/5)),chnl,n)),bins, 'Normalization', 'Probability');   p=h1.Values;
%     feats(n,7)= entropy_sig(p); % entropy
end
feats=zscore(feats);

%% automatically separating Wake/REM based on movement statistics
% we feat a distribution and find the peak and std of the REM group
mov=mean(r_dif,2);
pd=fitdist(mov,'kernel');
x_vals=min(mov):range(mov)/2000:mean(mov)+5*std(mov);
mov_pd=pdf(pd,x_vals);
figure
plot(x_vals,mov_pd,'color',[0 0 .7],'linewidth',1); hold on

histogram(mov,2000,'Normalization','pdf','edgecolor','none')
xlim([min(mov)-.3*std(mov)  median(mov)+2*std(mov)])
[M,I] = max(mov_pd); mov_peack=x_vals(I);
threshold=mov_peack+1*iqr(mov); % threshold on movement to differentiate Wake/REM
line([threshold threshold],[0 1.5*M],'linestyle','--');
ylim([0 1.3*M])
legend('movements pdf','movements histogram','threshold line')
xlabel('Movement (pixels)'); ylabel('pdf (probability)')

auto_label=cell(size(EEG,3),1);
Wake_ind=find(mov>=threshold);  % detection of Wake bins
nonWake_ind=find(mov<threshold);  % detection of Wake bins

for k=1:length(Wake_ind)
    auto_label{Wake_ind(k)}='Wake';
end

%% extraction of the typical samples of each stage (REM/nREM)
% calculate the max val for each snippet of EEG
vals=reshape( max( max(EEG(:,:,nonWake_ind) ,[],1) ,[],2),[1,length(nonWake_ind)]); 
valid_inds=nonWake_ind(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
% pick the ones with highest gamma, lowest delta+theta
[~,indx_high_gamma]=sort(feats(valid_inds,5)-feats(valid_inds,2)/2-feats(valid_inds,1)/2,'descend'); 
indx_typical_REM=valid_inds(indx_high_gamma(1:100));
indx_typical_nREM=valid_inds(indx_high_gamma(end-99:end));

%% classification with kNN
ind_class=[indx_typical_nREM; indx_typical_REM];
% making labels for the classifier
labels=cell(200,1);
for k=1:100
    labels{k}='SWS';
    labels{k+100}='REM';
end

Mdl = fitcknn(feats(ind_class,[1:5]),labels,'NumNeighbors',80); %  ,'Distance','mahalanobis','Cov',cov(feats(:,[1 5]))

% assigning the REM/nREM labels
[label_knn,score,~] = predict(Mdl,feats(nonWake_ind,[1:5]));
% (score) indicates the likelihood that a label comes from a particular class
thresh=1.00; % min TP for both classes
elig_ind=score(:,1)>=thresh | score(:,2)>=thresh; % index to the label_knn when the score in one class is more than threshold, thresh
auto_label(nonWake_ind(elig_ind))=label_knn(elig_ind);

IS_ind=nonWake_ind(not(elig_ind));  % detection of IS bins
for k=1:length(IS_ind)
    auto_label{IS_ind(k)}='IS';
end

% imposing a transition condition for Wake-->REM
replaces=0;
for k=2:length(auto_label)
    if strcmp(auto_label{k},'REM') & strcmp(auto_label{k-1},'Wake')
        auto_label{k}='Wake';  replaces=replaces+1;
    end
end
sum(strcmp(auto_label,'REM'))/length(auto_label)
sum(strcmp(auto_label,'SWS'))/length(auto_label)
sum(strcmp(auto_label,'IS'))/length(auto_label)
%% plot of classified samples

figure
cols=[ 0 0 1; 1 0 0; 1 .8 0; 0 1 1; ];
scatterhist(feats(:,1),feats(:,5),'Group',auto_label,'Kernel','on','Location','SouthWest',...
    'Direction','out','Color',cols,'LineStyle',{'-','-.',':'},...
    'LineWidth',[2,2,2],'Marker','.','MarkerSize',[4,4,4]); axis([-2.5 5 -1.5 6]);
xlabel('Delta z-score'); ylabel('Gamma z-score'); title('Automatic scoring')

%% plot of time series samples of each stage
% selection of best 20 of each stage
indx_REM_=find(strcmp(auto_label,'REM'));
[~,indx_high_gamma]=sort(feats(indx_REM_,5),'descend'); % pick the ones with highest gamma
indx_typical_REM_=indx_REM_(indx_high_gamma(1:20));

indx_SWS_=find(strcmp(auto_label,'SWS'));
[~,indx_low_freq]=sort(feats(indx_SWS_,1),'descend'); % pick the ones with highest gamma
indx_typical_SWS_=indx_SWS_(indx_low_freq(1:20));

indx_Wake_=find(strcmp(auto_label,'Wake'));
ind_Wake_=randsample(length(indx_Wake_),20);
indx_typical_Wake_=indx_Wake_(ind_Wake_);

indx_IS_=find(strcmp(auto_label,'IS'));
ind_IS_=randsample(length(indx_IS_),20);
indx_typical_IS_=indx_IS_(ind_IS_);

figure
subplot(1,4,1)
for k=1:20
    plot(round(1:eegn)/fs,EEG(:,chnl,indx_typical_REM_(k))/1.5+k); hold on
end
title('sample REM'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20); ylabel('Sample #')
subplot(1,4,2)
for k=1:20
    plot(round(1:eegn)/fs,EEG(:,chnl,indx_typical_SWS_(k))/1.5+k); hold on
end
title('sample SWS'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20); 
subplot(1,4,3)
for k=1:20
    plot(round(1:eegn)/fs,EEG(:,chnl,indx_typical_IS_(k))/1.5+k); hold on
end
title('sample IS'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20);
subplot(1,4,4)
for k=1:20
    plot(round(1:eegn)/fs,EEG(:,chnl,indx_typical_Wake_(k))/1.5+k); hold on
end
title('sample Wake'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20); 
%% plot of time series of outliers of each stage
% selection of worst 20 of each stage

indx_REM_=find(strcmp(auto_label,'REM'));
[~,indx_high_gamma]=sort(feats(indx_REM_,5),'ascend'); % pick the ones with highest gamma
indx_typical_REM_=indx_REM_(indx_high_gamma(1:20));

indx_nREM_=find(strcmp(auto_label,'SWS'));
[~,indx_low_freq]=sort(feats(indx_nREM_,1),'ascend'); % pick the ones with highest gamma
indx_typical_nREM_=indx_nREM_(indx_low_freq(1:20));

figure
subplot(1,2,1)
for k=1:20
    plot(round(1:eegn)/fs,EEG(:,chnl,indx_typical_REM_(k))/2+k); hold on
end
title('sample outlier REM'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20); ylabel('Sample #')
subplot(1,2,2)
for k=1:20
    plot(round(1:eegn)/fs,EEG(:,chnl,indx_typical_nREM_(k))/2+k); hold on
end
title('sample outlier SWS'); ylim([0 21]); xlabel('Time (sec)'); yticks(1:5:20); ylabel('Sample #')

%% saving data
save('juv_w0021_23_08_scoring','EEG','mov','feats','auto_label','t_bins','-v7.3') ; %%%%%%%%%%%
%% apEntropy across classes
stage={'Wake','IS','SWS','REM'};
r=.2*std(EEG(:,chnl,:),0,'all'); % distance for AppEnt
for n=1:4
    stg_ind=find(strcmp(auto_label,stage{n})); % index to the epochs of current stage, e.g. 'Wake'
    ind_100=randsample(length(stg_ind),200);
    for k=1:200
        apent(n,k)=appent(2,r,EEG(:,5,ind_100(k))); % approx_entropy(win_len,distance,data)
    end
end

figure
errorbar(mean(apent,2)*100/mean(apent(:))-100,(1.96*std(apent,0,2)/sqrt(200))*100/mean(apent(:)));
xlim([0 5]);   xticks(1:4);   xticklabels(stage); title('Approximate Entropy across stages (mean,conf interval)')
ylabel('% AppEntropy Change')


%% spectrum across groups
% for nREM
nwin=size(EEG,1);
nfft=2^(nextpow2(nwin));
TW=2.5; % 2W=1; % I want to have .5 Hz resoluted, so W=1, T=5, so 2TW constant=3
clear pxx_SWS pxx_REM pxx_IS pxx_Wake

% for SWS
bin_indx=find(strcmp(auto_label,'SWS')) ;
ind_stage=randsample(length(bin_indx),500);
n=1;
for k=1:500
    if max(EEG(:,chnl,bin_indx(ind_stage(k))))<4 % EEG less than 3 std
        [pxx_SWS(:,n),f] = pmtm(EEG(:,chnl,bin_indx(ind_stage(k))),TW,nfft,round(fs)); n=n+1
    end
end

% for REM
bin_indx=find(strcmp(auto_label,'REM')) ;
ind_stage=randsample(length(bin_indx),500);
n=1;
for k=1:500
    if max(EEG(:,chnl,bin_indx(ind_stage(k))))<4 % EEG less than 3 std
        [pxx_REM(:,n),f] = pmtm(EEG(:,chnl,bin_indx(ind_stage(k))),TW,nfft,round(fs)); n=n+1
    end
end

% for wake
bin_indx=find(strcmp(auto_label,'Wake')) ;
ind_stage=randsample(length(bin_indx),500);
n=1;
for k=1:500
    if max(EEG(:,chnl,bin_indx(ind_stage(k))))<4 % EEG less than 3 std
        [pxx_Wake(:,n),f] = pmtm(EEG(:,chnl,bin_indx(ind_stage(k))),TW,nfft,round(fs)); n=n+1
    end
end

% for IS
bin_indx=find(strcmp(auto_label,'IS')) ;
ind_stage=randsample(length(bin_indx),500);
n=1;
for k=1:500
    if max(EEG(:,chnl,bin_indx(ind_stage(k))))<4 % EEG less than 3 std
        [pxx_IS(:,n),f] = pmtm(EEG(:,chnl,bin_indx(ind_stage(k))),TW,nfft,round(fs)); n=n+1
    end
end
% computing mean and STE
mean_spec_SWS=mean(pxx_SWS,2);
mean_spec_REM=mean(pxx_REM,2);
mean_spec_Wake=mean(pxx_Wake,2);
mean_spec_IS=mean(pxx_IS,2);

figure
plot(f,log10(mean_spec_SWS),'b','linewidth',2);  hold on
plot(f,log10(mean_spec_REM),'r','linewidth',2)
plot(f,log10(mean_spec_Wake),'color',[1 .8 0],'linewidth',2)
plot(f,log10(mean_spec_IS),'c','linewidth',2)
xlim([0 100]); ylim([-4.0 -1.5]) %%%%%%%%
ylabel('Log of power')
legend('SWS','REM','Wake','IS')
xlabel('Freequency (Hz)')