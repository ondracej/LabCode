 function [score_trace,percentages]= score( EEG, EMG, seg, sr, time )
% segmentation and feature extraction

EMG=EMG; EEG=EEG; %%%%%%%%%%
feature=EMG'; L=2; % L=feature segment length
counter=1; k=L*sr; % windows for scoring are 2 seconds
clear feature_seg labels
for t=1:k:length(feature)-k
    feat_part=feature(t:t+k-1,:);
    feature_seg(counter,:)=[ var(feat_part)  skewness(feat_part)];
    counter=counter+1;
end
samps1=ceil(seg.wake(1)/L):floor(seg.wake(2)/L);  % class 2
samps2=ceil(seg.rem(1)/L):floor(seg.rem(2)/L);   % class 0
samps3=ceil(seg.nrem(1)/L):floor(seg.nrem(2)/L);   % class 1

% classification
Training_inp=[feature_seg(samps1,:); feature_seg(samps2,:); feature_seg(samps3,:)]';
Training_out=[2*ones(length(samps1),1); 0*ones(length(samps2),1); 1*ones(length(samps3),1)]';

% kNN classification
Mdl = fitcknn(Training_inp',Training_out','NumNeighbors',8,'Standardize',1);
label = predict(Mdl,feature_seg);
labels=3*ones(L*sr*length(feature_seg),1);
for i=1:length(label)
    labels(i*L*sr-2000+1:i*L*sr)=ones(L*sr,1)*label(i);
end
% function outputs
score_trace=labels;
percentages.wake=sum(label==2)/length(label)
percentages.nrem=sum(label==1)/length(label)
percentages.rem=sum(label==0)/length(label)
% plot
samps_used=1:L*sr*length(feature_seg);
figure; plot(time(samps_used)/60,labels); hold on
plot(time(samps_used)/60,EEG(samps_used)/10-2,'k')
plot(time(samps_used)/60,EMG(samps_used)/2000-7,'r')
ylim([-10 3]); set(gca,'ytick',[-7 -3 0 1 2],'yticklabel',{'EMG','EEG','REM','NREM','Wake'})
xlabel('Time (min)')
 end



