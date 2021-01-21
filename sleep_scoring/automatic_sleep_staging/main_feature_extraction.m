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
feats=zeros(length(label),7);
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
%% automatic classification with a perceptron ANN
% Use tapped delay lines with 10 delays for the input and 5 for the output.
% Create the series-parallel NARX network using the function narxnet. Use 10 neurons in the hidden layer and use
% trainlm for the training function, and then prepare the data
y(1,strcmp(label,'Wake'))=4*ones(1,sum(strcmp(label,'Wake')));
y(1,strcmp(label,'Drowsy'))=3*ones(1,sum(strcmp(label,'Drowsy')));
y(1,strcmp(label,'nREM'))=2*ones(1,sum(strcmp(label,'nREM')));
y(1,strcmp(label,'REM'))=1*ones(1,sum(strcmp(label,'REM')));
u=feats'; % input
u_train=con2seq(u(:,1:round(size(u,2)*.5)));      u_test=con2seq(u(:,round(size(u,2)*.5)+1:end));
y_train=con2seq(y(:,1:round(size(y,2)*.5)));      y_test=con2seq(y(:,round(size(y,2)*.5)+1:end));
clear y

% clear xcor
% i=0; 
% for j=1:10
% n=3;
%         d1 = [0:i]; % input delay
%         d2 = [1:j]; % output delay
%         % preparing input and output
%         narx_net = narxnet(d1,d2,n); % number of neurons in the hidden layer
%         narx_net.divideFcn = ''; % as time matters, no division of data
%         narx_net.trainParam.min_grad = 1e-10;
%         narx_net.trainParam.epochs=5000;
%         [p,Pi,Ai,t] = preparets(narx_net,u_train,{},y_train); % frame the input and output
%         net.trainFcn = 'trainlm';
%         narx_net = train(narx_net,p,t,Pi);
%         
%         % test
%         narx_net_closed = closeloop(narx_net); % closing the loop, so its not seroes-parallel anymore and receives the real
%         % output in the input as the y feedback
%         % view(narx_net_closed)
%         
%         [p_test,Pi_test,Ai_test,t_test] = preparets(narx_net_closed,u_test,{},y_test); % frame the input and output
%         
%         y_test_estimate = round(cell2mat(narx_net_closed(p_test,Pi_test,Ai_test)));
%         
%         figure
%         plot(1:size(y_test,2),cell2mat(y_test),'sb',1+d1(end):size(y_test_estimate,2)+d1(end),y_test_estimate,'or')
%         legend('true labeld','estimated')
%         xx=corrcoef(y_test_estimate,cell2mat(y_test(1,max(d1(end),d2(end))+1:end)));
%         xcor(1,j)=xx(1,2);
        % title(num2str(xcor));
%      end

X = feats(1:1400,:);    
Y = label(1:1400); 
Mdl = fitcknn(X,Y,'NumNeighbors',20);
rloss = resubLoss(Mdl);
flwrClass = predict(Mdl,feats(1401:end,:));
sum(strcmp(flwrClass,label(1401:end)))/length(label(1401:end))

%% extraction of the typical samples of each stage
indx_REM=find(strcmp(label,'REM'));
[gammas,indx_high_gamma]=sort(feats(indx_REM,5),'descend'); % pick the ones with highest gamma
indx_typical_REM=indx_REM(indx_high_gamma(1:100));

indx_nREM=find(strcmp(label,'nREM'));
[lowFreq,indx_low_freq]=sort(feats(indx_nREM,1),'descend'); % pick the ones with highest gamma
indx_typical_nREM=indx_nREM(indx_low_freq(1:100));

indx_Wake=find(strcmp(label,'Wake'));
ind_Wake=randsample(length(indx_Wake),100);
indx_typical_Wake=indx_Wake(ind_Wake);

%% classification with kNN
feats_=zscore(feats);
label_auto=cell(N,1);
ind_class=[indx_typical_nREM; indx_typical_REM];
Mdl = fitcknn(feats_(ind_class,[1:5]),label(ind_class),'NumNeighbors',50); %  ,'Distance','mahalanobis','Cov',cov(feats(:,[1 5]))
sleep_ind=find(mean(movement,2)<1530);  % detection of sleep
% assigning the 'Wake' label
Wake_ind=find(mean(movement,2)>=1530);  % detection of sleep
for k=1:length(Wake_ind)
label_auto{Wake_ind(k)}='Wake';
end

% assigning the REM/nREM labels
[label_knn,score,~] = predict(Mdl,feats_(sleep_ind,[1:5])); 
% (score) indicates the likelihood that a label comes from a particular class
thresh=.7; % min TP for both classes 
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
