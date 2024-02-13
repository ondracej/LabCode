function [bin_label,valid_inds]=cluster_sleep(feat, t_feat, sleep_wake, Delta, Gamma, t_dark, arte_factor )
% removing the faulty bins (val=inf) or outlier value in features
m=median(feat);
d=arte_factor*iqr(feat);
comp1=repmat(m+d,length(feat),1);
in_range_ind=sum(feat<comp1 ,2)==size(feat,2);
valid_inds=~isinf(sum(feat,2)) & in_range_ind & t_feat'<t_dark(2) & t_feat'>t_dark(1);

feat=feat(valid_inds,:);
sleep_wake=sleep_wake(valid_inds);
Delta=Delta(valid_inds);
Gamma=Gamma(valid_inds);

sleep_ind=logical(sleep_wake);
% first clustering, for SWS/nSWS
SWS_nSWS = kmeans(zscore(feat(sleep_ind,[1 3 4 5 6 7])),2);  % clustering only for sleep bins
% comparing Dlta across clusters to find the SWS one
sleep_delta=Delta(sleep_ind);
delta_class_1=mean(sleep_delta(SWS_nSWS==1));
delta_class_2=mean(sleep_delta(SWS_nSWS==2));
if delta_class_1>delta_class_2
    SWS_label=1; % label of cluster 1 indicates SWS
    nSWS_label=2;
else
    SWS_label=2; % label of cluster 2 indicates nSWS
    nSWS_label=1;
end

% second clustering, for REM/nREM

REM_nREM = kmeans(zscore(feat(sleep_ind,[2 3 4 5 7])),2);  % clustering only for sleep bins
% comparing Gamma across clusters to find the REM one
sleep_gamma=Gamma(sleep_ind);
gamma_class_1=mean(sleep_gamma(REM_nREM==1));
gamma_class_2=mean(sleep_gamma(REM_nREM==2));
if gamma_class_1>gamma_class_2
    REM_label=1; % label of cluster 1 indicates REM
    nREM_label=2;
else
    REM_label=2; % label of cluster 2 indicates nREM
    nREM_label=1;
end

% assigning labels based on these 2 clusterings results
bin_label=cell(1);
sleep_bin=1; % counter for only sleep bins among all bins
for k=1: length(sleep_ind)
    % if wake
    if sleep_wake(k)==0
        bin_label{k}='Wake'; % wake
        continue;
        % so bin k is a sleep one, therefore:
        % if REM=1, and SWS=0
    elseif REM_nREM(sleep_bin)==REM_label & SWS_nSWS(sleep_bin)==nSWS_label
        bin_label{k}='REM'; % REM
        sleep_bin=sleep_bin+1;
        
        % if REM=1, and SWS=1
    elseif REM_nREM(sleep_bin)==REM_label & SWS_nSWS(sleep_bin)==SWS_label
        bin_label{k}='a'; % artefact
        sleep_bin=sleep_bin+1;
        
        % if REM=0, and SWS=1
    elseif REM_nREM(sleep_bin)==nREM_label & SWS_nSWS(sleep_bin)==SWS_label
        bin_label{k}='SWS'; % SWS
        sleep_bin=sleep_bin+1;
        
        % if REM=0, and SWS=0
    elseif REM_nREM(sleep_bin)==nREM_label & SWS_nSWS(sleep_bin)==nSWS_label
        bin_label{k}='IS'; % IS
        sleep_bin=sleep_bin+1;
        
    end
end

% correcting for the artefacts
% determining how many artefacts occured
c=0;
for k=1:length(bin_label)
    if bin_label{k}=='a'
        c=c+1;
    end
end
artefact_proportion=c/length(bin_label)

% correction
for k=6:length(bin_label)
    if bin_label{k}=='a'
        score=[];
        for neighbor=1:5
            label=bin_label{k-neighbor};
            
            if strcmp(label,'Wake')
                score(neighbor)=-100;
            elseif strcmp(label,'REM')
                score(neighbor)=0;
            elseif strcmp(label,'IS')
                score(neighbor)=1;
            elseif strcmp(label,'SWS')
                score(neighbor)=2;
            end
        end
        
        neighbours_consent=round(mean(score));
        
        if neighbours_consent==0
            bin_label{k}='REM';
        elseif neighbours_consent==1
            bin_label{k}='IS';
        elseif neighbours_consent==2
            bin_label{k}='SWS';
        elseif neighbours_consent<0
            bin_label{k}='Wake';
        end
    end
end
for k=1:5
    if bin_label{k}=='a'
        bin_label{k}='IS';
    end
end