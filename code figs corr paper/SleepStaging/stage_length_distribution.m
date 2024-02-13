% loading the stage lengths from all birds, and putting them together
clear; clc;
% predifining variables
IS_bouts_len.l_a=[];
SWS_bouts_len.l_a=[];
REM_bouts_len.l_a=[];
Wake_bouts_len.l_a=[];

IS_bouts_len.r_a=[];
SWS_bouts_len.r_a=[];
REM_bouts_len.r_a=[];
Wake_bouts_len.r_a=[];

IS_bouts_len.l_p=[];
SWS_bouts_len.l_p=[];
REM_bouts_len.l_p=[];
Wake_bouts_len.l_p=[];

IS_bouts_len.r_p=[];
SWS_bouts_len.r_p=[];
REM_bouts_len.r_p=[];
Wake_bouts_len.r_p=[];

IS_bouts_len.lfp=[];
SWS_bouts_len.lfp=[];
REM_bouts_len.lfp=[];
Wake_bouts_len.lfp=[];

data_folder='Z:\zoologie\HamedData\LocalSWPaper\PaperData';

% LFP channels in all birds
fname='w025_LFP1_2021-08-04_22-02-26'
bird_lfp=load([data_folder '\' fname '.mat']);
IS_bouts_len.lfp=[IS_bouts_len.lfp  bird_lfp.bouts_IS_len];
SWS_bouts_len.lfp=[SWS_bouts_len.lfp  bird_lfp.bouts_SWS_len];
REM_bouts_len.lfp=[REM_bouts_len.lfp  bird_lfp.bouts_REM_len];
Wake_bouts_len.lfp=[Wake_bouts_len.lfp  bird_lfp.bouts_Wake_len];
fname='w027LFP1_2021-08-17_21-47-03'
bird_lfp=load([data_folder '\' fname '.mat']);
IS_bouts_len.lfp=[IS_bouts_len.lfp  bird_lfp.bouts_IS_len];
SWS_bouts_len.lfp=[SWS_bouts_len.lfp  bird_lfp.bouts_SWS_len];
REM_bouts_len.lfp=[REM_bouts_len.lfp  bird_lfp.bouts_REM_len];
Wake_bouts_len.lfp=[Wake_bouts_len.lfp  bird_lfp.bouts_Wake_len];
fname='w038LFP1_2021-09-19_22-10-06'
bird_lfp=load([data_folder '\' fname '.mat']);
IS_bouts_len.lfp=[IS_bouts_len.lfp  bird_lfp.bouts_IS_len];
SWS_bouts_len.lfp=[SWS_bouts_len.lfp  bird_lfp.bouts_SWS_len];
REM_bouts_len.lfp=[REM_bouts_len.lfp  bird_lfp.bouts_REM_len];
Wake_bouts_len.lfp=[Wake_bouts_len.lfp  bird_lfp.bouts_Wake_len];
fname='w042lfp_eeg_2022-01-12_21-39-12'
bird_lfp=load([data_folder '\' fname '.mat']);
IS_bouts_len.lfp=[IS_bouts_len.lfp  bird_lfp.bouts_IS_len];
SWS_bouts_len.lfp=[SWS_bouts_len.lfp  bird_lfp.bouts_SWS_len];
REM_bouts_len.lfp=[REM_bouts_len.lfp  bird_lfp.bouts_REM_len];
Wake_bouts_len.lfp=[Wake_bouts_len.lfp  bird_lfp.bouts_Wake_len];
fname='w044lfp_2022-01-13_21-57-16'
bird_lfp=load([data_folder '\' fname '.mat']);
IS_bouts_len.lfp=[IS_bouts_len.lfp  bird_lfp.bouts_IS_len];
SWS_bouts_len.lfp=[SWS_bouts_len.lfp  bird_lfp.bouts_SWS_len];
REM_bouts_len.lfp=[REM_bouts_len.lfp  bird_lfp.bouts_REM_len];
Wake_bouts_len.lfp=[Wake_bouts_len.lfp  bird_lfp.bouts_Wake_len];

% l_a channels in all birds
fname='w025_ref2021-08-04_22-02-26'
bird_l_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_a=[IS_bouts_len.l_a  bird_l_a.bouts_IS_len_ref];
SWS_bouts_len.l_a=[SWS_bouts_len.l_a  bird_l_a.bouts_SWS_len_ref];
REM_bouts_len.l_a=[REM_bouts_len.l_a  bird_l_a.bouts_REM_len_ref];
Wake_bouts_len.l_a=[Wake_bouts_len.l_a  bird_l_a.bouts_Wake_len_ref];
fname='w027_ref2021-08-17_21-47-03'
bird_l_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_a=[IS_bouts_len.l_a  bird_l_a.bouts_IS_len_ref];
SWS_bouts_len.l_a=[SWS_bouts_len.l_a  bird_l_a.bouts_SWS_len_ref];
REM_bouts_len.l_a=[REM_bouts_len.l_a  bird_l_a.bouts_REM_len_ref];
Wake_bouts_len.l_a=[Wake_bouts_len.l_a  bird_l_a.bouts_Wake_len_ref];
fname='w038_ref2021-09-19_22-10-06'
bird_l_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_a=[IS_bouts_len.l_a  bird_l_a.bouts_IS_len_ref];
SWS_bouts_len.l_a=[SWS_bouts_len.l_a  bird_l_a.bouts_SWS_len_ref];
REM_bouts_len.l_a=[REM_bouts_len.l_a  bird_l_a.bouts_REM_len_ref];
Wake_bouts_len.l_a=[Wake_bouts_len.l_a  bird_l_a.bouts_Wake_len_ref];
fname='w042_ref2022-01-12_21-39-12'
bird_l_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_a=[IS_bouts_len.l_a  bird_l_a.bouts_IS_len_ref];
SWS_bouts_len.l_a=[SWS_bouts_len.l_a  bird_l_a.bouts_SWS_len_ref];
REM_bouts_len.l_a=[REM_bouts_len.l_a  bird_l_a.bouts_REM_len_ref];
Wake_bouts_len.l_a=[Wake_bouts_len.l_a  bird_l_a.bouts_Wake_len_ref];
fname='w044_ref2022-01-13_21-57-16'
bird_l_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_a=[IS_bouts_len.l_a  bird_l_a.bouts_IS_len_ref];
SWS_bouts_len.l_a=[SWS_bouts_len.l_a  bird_l_a.bouts_SWS_len_ref];
REM_bouts_len.l_a=[REM_bouts_len.l_a  bird_l_a.bouts_REM_len_ref];
Wake_bouts_len.l_a=[Wake_bouts_len.l_a  bird_l_a.bouts_Wake_len_ref];

% r_a channels in all birds
fname='w025_r_a_EEG_2021-08-04_22-02-26';
bird_r_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_a=[IS_bouts_len.r_a  bird_r_a.bouts_IS_len];
SWS_bouts_len.r_a=[SWS_bouts_len.r_a  bird_r_a.bouts_SWS_len];
REM_bouts_len.r_a=[REM_bouts_len.r_a  bird_r_a.bouts_REM_len];
Wake_bouts_len.r_a=[Wake_bouts_len.r_a  bird_r_a.bouts_Wake_len];
fname='w027_r_a_EEG2021-08-17_21-47-03';
bird_r_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_a=[IS_bouts_len.r_a  bird_r_a.bouts_IS_len];
SWS_bouts_len.r_a=[SWS_bouts_len.r_a  bird_r_a.bouts_SWS_len];
REM_bouts_len.r_a=[REM_bouts_len.r_a  bird_r_a.bouts_REM_len];
Wake_bouts_len.r_a=[Wake_bouts_len.r_a  bird_r_a.bouts_Wake_len];
fname='w042r_a_eeg_2022-01-12_21-39-12';
bird_r_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_a=[IS_bouts_len.r_a  bird_r_a.bouts_IS_len];
SWS_bouts_len.r_a=[SWS_bouts_len.r_a  bird_r_a.bouts_SWS_len];
REM_bouts_len.r_a=[REM_bouts_len.r_a  bird_r_a.bouts_REM_len];
Wake_bouts_len.r_a=[Wake_bouts_len.r_a  bird_r_a.bouts_Wake_len];
fname='w044r_a_eeg_2022-01-13_21-57-16';
bird_r_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_a=[IS_bouts_len.r_a  bird_r_a.bouts_IS_len];
SWS_bouts_len.r_a=[SWS_bouts_len.r_a  bird_r_a.bouts_SWS_len];
REM_bouts_len.r_a=[REM_bouts_len.r_a  bird_r_a.bouts_REM_len];
Wake_bouts_len.r_a=[Wake_bouts_len.r_a  bird_r_a.bouts_Wake_len];

% l_p channels in all birds
fname='w025l_p_eeg_2021-08-04_22-02-26';
bird_l_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_p=[IS_bouts_len.l_p  bird_l_p.bouts_IS_len];
SWS_bouts_len.l_p=[SWS_bouts_len.l_p  bird_l_p.bouts_SWS_len];
REM_bouts_len.l_p=[REM_bouts_len.l_p  bird_l_p.bouts_REM_len];
Wake_bouts_len.l_p=[Wake_bouts_len.l_p  bird_l_p.bouts_Wake_len];
fname='w027_l_p_EEG2021-08-17_21-47-03';
bird_l_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_p=[IS_bouts_len.l_p  bird_l_p.bouts_IS_len];
SWS_bouts_len.l_p=[SWS_bouts_len.l_p  bird_l_p.bouts_SWS_len];
REM_bouts_len.l_p=[REM_bouts_len.l_p  bird_l_p.bouts_REM_len];
Wake_bouts_len.l_p=[Wake_bouts_len.l_p  bird_l_p.bouts_Wake_len];
fname='w038l_p_EEG_2021-09-19_22-10-06';
bird_l_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_p=[IS_bouts_len.l_p  bird_l_p.bouts_IS_len];
SWS_bouts_len.l_p=[SWS_bouts_len.l_p  bird_l_p.bouts_SWS_len];
REM_bouts_len.l_p=[REM_bouts_len.l_p  bird_l_p.bouts_REM_len];
Wake_bouts_len.l_p=[Wake_bouts_len.l_p  bird_l_p.bouts_Wake_len];
fname='w044l_p_eeg_2022-01-13_21-57-16';
bird_l_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_p=[IS_bouts_len.l_p  bird_l_p.bouts_IS_len];
SWS_bouts_len.l_p=[SWS_bouts_len.l_p  bird_l_p.bouts_SWS_len];
REM_bouts_len.l_p=[REM_bouts_len.l_p  bird_l_p.bouts_REM_len];
Wake_bouts_len.l_p=[Wake_bouts_len.l_p  bird_l_p.bouts_Wake_len];

% r_p channels in all birds
fname='w025r_p_eeg_2021-08-04_22-02-26';
bird_r_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_p=[IS_bouts_len.r_p  bird_r_p.bouts_IS_len];
SWS_bouts_len.r_p=[SWS_bouts_len.r_p  bird_r_p.bouts_SWS_len];
REM_bouts_len.r_p=[REM_bouts_len.r_p  bird_r_p.bouts_REM_len];
Wake_bouts_len.r_p=[Wake_bouts_len.r_p  bird_r_p.bouts_Wake_len];
fname='w027_r_p_EEG2021-08-17_21-47-03';
bird_r_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_p=[IS_bouts_len.r_p  bird_r_p.bouts_IS_len];
SWS_bouts_len.r_p=[SWS_bouts_len.r_p  bird_r_p.bouts_SWS_len];
REM_bouts_len.r_p=[REM_bouts_len.r_p  bird_r_p.bouts_REM_len];
Wake_bouts_len.r_p=[Wake_bouts_len.r_p  bird_r_p.bouts_Wake_len];
fname='w042r_p_eeg_2022-01-12_21-39-12';
bird_r_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_p=[IS_bouts_len.r_p  bird_r_p.bouts_IS_len];
SWS_bouts_len.r_p=[SWS_bouts_len.r_p  bird_r_p.bouts_SWS_len];
REM_bouts_len.r_p=[REM_bouts_len.r_p  bird_r_p.bouts_REM_len];
Wake_bouts_len.r_p=[Wake_bouts_len.r_p  bird_r_p.bouts_Wake_len];
fname='w044r_p_eeg_2022-01-13_21-57-16';
bird_r_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_p=[IS_bouts_len.r_p  bird_r_p.bouts_IS_len];
SWS_bouts_len.r_p=[SWS_bouts_len.r_p  bird_r_p.bouts_SWS_len];
REM_bouts_len.r_p=[REM_bouts_len.r_p  bird_r_p.bouts_REM_len];
Wake_bouts_len.r_p=[Wake_bouts_len.r_p  bird_r_p.bouts_Wake_len];

%% load data
load('Z:\zoologie\HamedData\LocalSWPaper\PaperData\bouts_all_birds');

%% figures
% colors for diffrent sleep stages
r=.8*[1 .4 .4 ]; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
w=[.9 .9 .3];
figure('position',[300 300 800 250]*1)
% SWS
subplot(1,3,1)
[N,edges] = histcounts(SWS_bouts_len.l_a,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',s*.5); hold on

[N,edges] = histcounts(SWS_bouts_len.r_a,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',s*.8); hold on

[N,edges] = histcounts(SWS_bouts_len.l_p,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',min(s*1.1,[1 1 1])); hold on

[N,edges] = histcounts(SWS_bouts_len.r_p,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',min(s*1.4,[1 1 1])); hold on

[N,edges] = histcounts(SWS_bouts_len.lfp,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',[.4 1 .4]); hold on
xlim([0 15]); xlabel('Duration (sec)'); title('SWS')
 ylabel('Probability');
legend('L front','R front','L caudal','R caudal','DVR');
% IS
subplot(1,3,3)
[N,edges] = histcounts(IS_bouts_len.l_a,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',i*.5); hold on

[N,edges] = histcounts(IS_bouts_len.r_a,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',i*.8); hold on

[N,edges] = histcounts(IS_bouts_len.l_p,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',min(i*1.1,[1 1 1])); hold on

[N,edges] = histcounts(IS_bouts_len.r_p,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',min(i*1.4,[1 1 1])); hold on

[N,edges] = histcounts(IS_bouts_len.lfp,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',[.4 1 .4]); hold on
xlim([0 8]);   xlabel('Duration (sec)'); title('IS')
yticklabels([]); 
legend('L front','R front','L caudal','R caudal','DVR');

% REM
subplot(1,3,2)
[N,edges] = histcounts(REM_bouts_len.l_a,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',r*.5); hold on

[N,edges] = histcounts(REM_bouts_len.r_a,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',r*.8); hold on

[N,edges] = histcounts(REM_bouts_len.l_p,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',min(r*1.1,[1 1 1])); hold on

[N,edges] = histcounts(REM_bouts_len.r_p,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',min(r*1.4,[1 1 1])); hold on

[N,edges] = histcounts(REM_bouts_len.lfp,[0:2:60]);
bin_center=edges(1:(length(edges)-1)) ;
plot(bin_center, (N/sum(N)),'LineWidth',1.4,'color',[.4 1 .4]); hold on
xlim([0 15]);   xlabel('Duration (sec)'); title('REM')
 yticklabels([]); 
legend('L front','R front','L caudal','R caudal','DVR');

% statistical test for difference of state duration in DVR and hyperpalium
% surface
% SWS
[p_SWS_l_a,h] = ranksum(SWS_bouts_len.lfp,SWS_bouts_len.l_a)
[p_SWS_r_a,h] = ranksum(SWS_bouts_len.lfp,SWS_bouts_len.r_a)
[p_SWS_r_p,h] = ranksum(SWS_bouts_len.lfp,SWS_bouts_len.r_p)
[p_SWS_l_p,h] = ranksum(SWS_bouts_len.lfp,SWS_bouts_len.l_p)
% IS
[p_IS_l_a,h] = ranksum(IS_bouts_len.lfp,IS_bouts_len.l_a)
[p_IS_r_a,h] = ranksum(IS_bouts_len.lfp,IS_bouts_len.r_a)
[p_IS_r_p,h] = ranksum(IS_bouts_len.lfp,IS_bouts_len.r_p)
[p_IS_l_p,h] = ranksum(IS_bouts_len.lfp,IS_bouts_len.l_p)
% REM
[p_REM_l_a,h] = ranksum(REM_bouts_len.lfp,REM_bouts_len.l_a)
[p_REM_r_a,h] = ranksum(REM_bouts_len.lfp,REM_bouts_len.r_a)
[p_REM_r_p,h] = ranksum(REM_bouts_len.lfp,REM_bouts_len.r_p)
[p_REM_l_p,h] = ranksum(REM_bouts_len.lfp,REM_bouts_len.l_p)

%% bar plots of the distribution of the sleep stage dusrations
% colors for diffrent sleep stages
r=.8*[1 .4 .4 ]; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
w=[.9 .9 .3];
figure('position',[300 300 800 250]*1)
% SWS
subplot(1,3,1)
x1=SWS_bouts_len.l_a;
x2=SWS_bouts_len.r_a;
x3=SWS_bouts_len.l_p;
x4=SWS_bouts_len.r_p;
x5=SWS_bouts_len.lfp;
x=1:5; % for 4 recording sites
y = [mean(x1) mean(x2)  mean(x3)  mean(x4)  mean(x5)];
N=min([length(x1)  length(x2)  length(x3)  length(x4)  length(x5)]);
err = [std(x1)    std(x2)   std(x3)   std(x4)   std(x5)]/sqrt(N); % division by 2 for ste
errorbar(x, y, err, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',s,'MarkerFaceColor',s,'linestyle','none','color','k')
xlim([.3 5.7]);
ylim([4.5 7])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
title('SWS')
ylabel('Duration (sec)')

% REM
subplot(1,3,2)
x1=REM_bouts_len.l_a;
x2=REM_bouts_len.r_a;
x3=REM_bouts_len.l_p;
x4=REM_bouts_len.r_p;
x5=REM_bouts_len.lfp;
x=1:5; % for 4 recording sites
y = [mean(x1) mean(x2)  mean(x3)  mean(x4)  mean(x5)];
N=min([length(x1)  length(x2)  length(x3)  length(x4)  length(x5)]);
err = [std(x1)    std(x2)   std(x3)   std(x4)   std(x5)]/sqrt(N); % division by 2 for ste
errorbar(x, y, err, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',r,'MarkerFaceColor',r,'linestyle','none','color','k')
xlim([.3 5.7]);
ylim([4.5 7])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
title('REM')

% IS
subplot(1,3,3)
x1=IS_bouts_len.l_a;
x2=IS_bouts_len.r_a;
x3=IS_bouts_len.l_p;
x4=IS_bouts_len.r_p;
x5=IS_bouts_len.lfp;
x=1:5; % for 4 recording sites
y = [mean(x1) mean(x2)  mean(x3)  mean(x4)  mean(x5)];
N=min([length(x1)  length(x2)  length(x3)  length(x4)  length(x5)]);
err = [std(x1)    std(x2)   std(x3)   std(x4)   std(x5)]/sqrt(N); % division by 2 for ste
errorbar(x, y, err, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',i,'MarkerFaceColor',i,'linestyle','none','color','k')
xlim([.3 5.7]);
% ylim([0 50])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
title('IS')

