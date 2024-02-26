% loading the stage lengths from all birds, and putting them together
clear; clc;
% predefining variables
IS_bouts_len.l_a=[];
SWS_bouts_len.l_a=[];
REM_bouts_len.l_a=[];

IS_bouts_len.r_a=[];
SWS_bouts_len.r_a=[];
REM_bouts_len.r_a=[];

IS_bouts_len.l_p=[];
SWS_bouts_len.l_p=[];
REM_bouts_len.l_p=[];

IS_bouts_len.r_p=[];
SWS_bouts_len.r_p=[];
REM_bouts_len.r_p=[];

IS_bouts_len.lfp=[];
SWS_bouts_len.lfp=[];
REM_bouts_len.lfp=[];

data_folder='Y:\zoologie\HamedData\LocalSWPaper\PaperData\new_scorings\stage_lengths';

fname='stage_len_w027_lfp'
bird_lfp=load([data_folder '\' fname '.mat']);
IS_bouts_len.lfp=[IS_bouts_len.lfp  bird_lfp.bouts_IS_len];
SWS_bouts_len.lfp=[SWS_bouts_len.lfp  bird_lfp.bouts_SWS_len];
REM_bouts_len.lfp=[REM_bouts_len.lfp  bird_lfp.bouts_REM_len];
w027_mean_SWS_lfp=mean(bird_lfp.bouts_SWS_len);
w027_mean_IS_lfp=mean(bird_lfp.bouts_IS_len);
w027_mean_REM_lfp=mean(bird_lfp.bouts_REM_len);
fname='stage_len_w042_lfp'
bird_lfp=load([data_folder '\' fname '.mat']);
IS_bouts_len.lfp=[IS_bouts_len.lfp  bird_lfp.bouts_IS_len];
SWS_bouts_len.lfp=[SWS_bouts_len.lfp  bird_lfp.bouts_SWS_len];
REM_bouts_len.lfp=[REM_bouts_len.lfp  bird_lfp.bouts_REM_len];
w042_mean_SWS_lfp=mean(bird_lfp.bouts_SWS_len);
w042_mean_IS_lfp=mean(bird_lfp.bouts_IS_len);
w042_mean_REM_lfp=mean(bird_lfp.bouts_REM_len);
fname='stage_len_w044_lfp'
bird_lfp=load([data_folder '\' fname '.mat']);
IS_bouts_len.lfp=[IS_bouts_len.lfp  bird_lfp.bouts_IS_len];
SWS_bouts_len.lfp=[SWS_bouts_len.lfp  bird_lfp.bouts_SWS_len];
REM_bouts_len.lfp=[REM_bouts_len.lfp  bird_lfp.bouts_REM_len];
w044_mean_SWS_lfp=mean(bird_lfp.bouts_SWS_len);
w044_mean_IS_lfp=mean(bird_lfp.bouts_IS_len);
w044_mean_REM_lfp=mean(bird_lfp.bouts_REM_len);

fname='stage_len_w027_l_a'
bird_l_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_a=[IS_bouts_len.l_a  bird_l_a.bouts_IS_len];
SWS_bouts_len.l_a=[SWS_bouts_len.l_a  bird_l_a.bouts_SWS_len];
REM_bouts_len.l_a=[REM_bouts_len.l_a  bird_l_a.bouts_REM_len];
w027_mean_SWS_l_a=mean(bird_l_a.bouts_SWS_len);
w027_mean_IS_l_a=mean(bird_l_a.bouts_IS_len);
w027_mean_REM_l_a=mean(bird_l_a.bouts_REM_len);
fname='stage_len_w042_l_a'
bird_l_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_a=[IS_bouts_len.l_a  bird_l_a.bouts_IS_len];
SWS_bouts_len.l_a=[SWS_bouts_len.l_a  bird_l_a.bouts_SWS_len];
REM_bouts_len.l_a=[REM_bouts_len.l_a  bird_l_a.bouts_REM_len];
w042_mean_SWS_l_a=mean(bird_l_a.bouts_SWS_len);
w042_mean_IS_l_a=mean(bird_l_a.bouts_IS_len);
w042_mean_REM_l_a=mean(bird_l_a.bouts_REM_len);

fname='stage_len_w044_l_a'
bird_l_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_a=[IS_bouts_len.l_a  bird_l_a.bouts_IS_len];
SWS_bouts_len.l_a=[SWS_bouts_len.l_a  bird_l_a.bouts_SWS_len];
REM_bouts_len.l_a=[REM_bouts_len.l_a  bird_l_a.bouts_REM_len];
w044_mean_SWS_l_a=mean(bird_l_a.bouts_SWS_len);
w044_mean_IS_l_a=mean(bird_l_a.bouts_IS_len);
w044_mean_REM_l_a=mean(bird_l_a.bouts_REM_len);

% r_a channels in all birds
fname='stage_len_w027_r_a';
bird_r_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_a=[IS_bouts_len.r_a  bird_r_a.bouts_IS_len];
SWS_bouts_len.r_a=[SWS_bouts_len.r_a  bird_r_a.bouts_SWS_len];
REM_bouts_len.r_a=[REM_bouts_len.r_a  bird_r_a.bouts_REM_len];
w027_mean_SWS_r_a=mean(bird_r_a.bouts_SWS_len);
w027_mean_IS_r_a=mean(bird_r_a.bouts_IS_len);
w027_mean_REM_r_a=mean(bird_r_a.bouts_REM_len);
fname='stage_len_w042_r_a';
bird_r_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_a=[IS_bouts_len.r_a  bird_r_a.bouts_IS_len];
SWS_bouts_len.r_a=[SWS_bouts_len.r_a  bird_r_a.bouts_SWS_len];
REM_bouts_len.r_a=[REM_bouts_len.r_a  bird_r_a.bouts_REM_len];
w042_mean_SWS_r_a=mean(bird_r_a.bouts_SWS_len);
w042_mean_IS_r_a=mean(bird_r_a.bouts_IS_len);
w042_mean_REM_r_a=mean(bird_r_a.bouts_REM_len);
fname='stage_len_w044_r_a';
bird_r_a=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_a=[IS_bouts_len.r_a  bird_r_a.bouts_IS_len];
SWS_bouts_len.r_a=[SWS_bouts_len.r_a  bird_r_a.bouts_SWS_len];
REM_bouts_len.r_a=[REM_bouts_len.r_a  bird_r_a.bouts_REM_len];
w044_mean_SWS_r_a=mean(bird_r_a.bouts_SWS_len);
w044_mean_IS_r_a=mean(bird_r_a.bouts_IS_len);
w044_mean_REM_r_a=mean(bird_r_a.bouts_REM_len);
% l_p channels in all birds
fname='stage_len_w027_l_p';
bird_l_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_p=[IS_bouts_len.l_p  bird_l_p.bouts_IS_len];
SWS_bouts_len.l_p=[SWS_bouts_len.l_p  bird_l_p.bouts_SWS_len];
REM_bouts_len.l_p=[REM_bouts_len.l_p  bird_l_p.bouts_REM_len];
w027_mean_SWS_l_p=mean(bird_l_p.bouts_SWS_len);
w027_mean_IS_l_p=mean(bird_l_p.bouts_IS_len);
w027_mean_REM_l_p=mean(bird_l_p.bouts_REM_len);
fname='stage_len_w044_l_p';
bird_l_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.l_p=[IS_bouts_len.l_p  bird_l_p.bouts_IS_len];
SWS_bouts_len.l_p=[SWS_bouts_len.l_p  bird_l_p.bouts_SWS_len];
REM_bouts_len.l_p=[REM_bouts_len.l_p  bird_l_p.bouts_REM_len];
w044_mean_SWS_l_p=mean(bird_l_p.bouts_SWS_len);
w044_mean_IS_l_p=mean(bird_l_p.bouts_IS_len);
w044_mean_REM_l_p=mean(bird_l_p.bouts_REM_len);
% r_p channels in all birds

fname='stage_len_w027_r_p';
bird_r_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_p=[IS_bouts_len.r_p  bird_r_p.bouts_IS_len];
SWS_bouts_len.r_p=[SWS_bouts_len.r_p  bird_r_p.bouts_SWS_len];
REM_bouts_len.r_p=[REM_bouts_len.r_p  bird_r_p.bouts_REM_len];
w027_mean_SWS_r_p=mean(bird_r_p.bouts_SWS_len);
w027_mean_IS_r_p=mean(bird_r_p.bouts_IS_len);
w027_mean_REM_r_p=mean(bird_r_p.bouts_REM_len);
fname='stage_len_w042_r_p';
bird_r_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_p=[IS_bouts_len.r_p  bird_r_p.bouts_IS_len];
SWS_bouts_len.r_p=[SWS_bouts_len.r_p  bird_r_p.bouts_SWS_len];
REM_bouts_len.r_p=[REM_bouts_len.r_p  bird_r_p.bouts_REM_len];
w042_mean_SWS_r_p=mean(bird_r_p.bouts_SWS_len);
w042_mean_IS_r_p=mean(bird_r_p.bouts_IS_len);
w042_mean_REM_r_p=mean(bird_r_p.bouts_REM_len);
fname='stage_len_w044_r_p';
bird_r_p=load([data_folder '\' fname '.mat']);
IS_bouts_len.r_p=[IS_bouts_len.r_p  bird_r_p.bouts_IS_len];
SWS_bouts_len.r_p=[SWS_bouts_len.r_p  bird_r_p.bouts_SWS_len];
REM_bouts_len.r_p=[REM_bouts_len.r_p  bird_r_p.bouts_REM_len];
w044_mean_SWS_r_p=mean(bird_r_p.bouts_SWS_len);
w044_mean_IS_r_p=mean(bird_r_p.bouts_IS_len);
w044_mean_REM_r_p=mean(bird_r_p.bouts_REM_len);

%% bar plots of the distribution of the sleep stage dusrations
% colors for diffrent sleep stages
r=[253 145 33]/255; 
s=[.4 .4 1]; 
i=[.2 1 1]; 

figure('position',[300 200 300 700])
% SWS
subplot(3,1,1)
x1=SWS_bouts_len.l_a;
x2=SWS_bouts_len.r_a;
x3=SWS_bouts_len.l_p;
x4=SWS_bouts_len.r_p;
x5=SWS_bouts_len.lfp;
x=1:5; % for 4 recording sites
y = [mean(x1) mean(x2)  mean(x3)  mean(x4)  mean(x5)];
N=min([length(x1)  length(x2)  length(x3)  length(x4)  length(x5)]);
err = [std(x1)    std(x2)   std(x3)   std(x4)   std(x5)]/sqrt(N); % division by 2 for ste
% errorbar(x, y, err, '-','MarkerSize', 10,...
%     'MarkerEdgeColor',s,'MarkerFaceColor',s,'linestyle','none','color','k'); 
hold on
b=bar(x,y,'FaceColor',s,'EdgeColor','none','BarWidth',.7 ); 

plot(1,w027_mean_SWS_l_a,'ko','MarkerSize',8);
plot(1,w042_mean_SWS_l_a,'k+','MarkerSize',10);
plot(1,w044_mean_SWS_l_a,'kd','MarkerSize',8);

plot(2,w027_mean_SWS_r_a,'ko','MarkerSize',8);
plot(2,w042_mean_SWS_r_a-.1,'k+','MarkerSize',10);
plot(2,w044_mean_SWS_r_a,'kd','MarkerSize',8);

plot(3,w027_mean_SWS_r_p,'ko','MarkerSize',8);
plot(3,w042_mean_SWS_r_p,'k+','MarkerSize',10);
plot(3,w044_mean_SWS_r_p,'kd','MarkerSize',8);

plot(4,w027_mean_SWS_l_p,'ko','MarkerSize',8);
plot(4,w044_mean_SWS_l_p,'kd','MarkerSize',8);

plot(5,w027_mean_SWS_lfp,'ko','MarkerSize',8);
plot(5,w042_mean_SWS_lfp,'k+','MarkerSize',10);
plot(5,w044_mean_SWS_lfp,'kd','MarkerSize',8);

xlim([.3 5.7]);
ylim([0 15.7])
box off
xticks([1 2 3 4 5])
xticklabels({'L ant EEG','R ant EEG','R post EEG','L post EEG','LFP DVR'})
xtickangle(-30)
ylabel('SWS (%)')
title('Durations')

% REM
subplot(3,1,2)
x1=REM_bouts_len.l_a;
x2=REM_bouts_len.r_a;
x3=REM_bouts_len.l_p;
x4=REM_bouts_len.r_p;
x5=REM_bouts_len.lfp;
x=1:5; % for 4 recording sites
y = [mean(x1) mean(x2)  mean(x3)  mean(x4)  mean(x5)];
N=min([length(x1)  length(x2)  length(x3)  length(x4)  length(x5)]);
err = [std(x1)    std(x2)   std(x3)   std(x4)   std(x5)]/sqrt(N); % division by 2 for ste
% errorbar(x, y, err, '-','MarkerSize', 10,...
%     'MarkerEdgeColor',r,'MarkerFaceColor',r,'linestyle','none','color','k');
hold on
bar(x,y,'FaceColor',r,'EdgeColor','none','BarWidth',.7);

plot(1,w027_mean_REM_l_a,'ko','MarkerSize',8);
plot(1,w042_mean_REM_l_a,'k+','MarkerSize',10);
plot(1,w044_mean_REM_l_a,'kd','MarkerSize',8);

plot(2,w027_mean_REM_r_a,'ko','MarkerSize',8);
plot(2,w042_mean_REM_r_a-.1,'k+','MarkerSize',10);
plot(2,w044_mean_REM_r_a,'kd','MarkerSize',8);

plot(3,w027_mean_REM_r_p,'ko','MarkerSize',8);
plot(3,w042_mean_REM_r_p,'k+','MarkerSize',10);
plot(3,w044_mean_REM_r_p,'kd','MarkerSize',8);

plot(4,w027_mean_REM_l_p,'ko','MarkerSize',8);
plot(4,w044_mean_REM_l_p,'kd','MarkerSize',8);

plot(5,w027_mean_REM_lfp,'ko','MarkerSize',8);
plot(5,w042_mean_REM_lfp,'k+','MarkerSize',10);
plot(5,w044_mean_REM_lfp,'kd','MarkerSize',8);

xlim([.3 5.7]);
ylim([0 15.7])
box off
xticks([1 2 3 4 5])
xticklabels({'L ant EEG','R ant EEG','R post EEG','L post EEG','LFP DVR'})
xtickangle(-30)
ylabel('REM (%)')

% IS
subplot(3,1,3)
x1=IS_bouts_len.l_a;
x2=IS_bouts_len.r_a;
x3=IS_bouts_len.r_p;
x4=IS_bouts_len.l_p;
x5=IS_bouts_len.lfp;
x=1:5; % for 4 recording sites
y = [mean(x1) mean(x2)  mean(x3)  mean(x4)  mean(x5)];
N=min([length(x1)  length(x2)  length(x3)  length(x4)  length(x5)]);
err = [std(x1)    std(x2)   std(x3)   std(x4)   std(x5)]/sqrt(N); % division by 2 for ste
% errorbar(x, y, err, '-','MarkerSize', 10,...
%     'MarkerEdgeColor',i,'MarkerFaceColor',i,'linestyle','none','color','k');
hold on
bar(x,y,'FaceColor',i,'EdgeColor','none','BarWidth',.7);

plot(1,w027_mean_IS_l_a,'ko','MarkerSize',8);
plot(1,w042_mean_IS_l_a,'k+','MarkerSize',10);
plot(1,w044_mean_IS_l_a,'kd','MarkerSize',8);

plot(2,w027_mean_IS_r_a,'ko','MarkerSize',8);
plot(2,w042_mean_IS_r_a-.1,'k+','MarkerSize',10);
plot(2,w044_mean_IS_r_a,'kd','MarkerSize',8);

plot(3,w027_mean_IS_r_p,'ko','MarkerSize',8);
plot(3,w042_mean_IS_r_p,'k+','MarkerSize',10);
plot(3,w044_mean_IS_r_p,'kd','MarkerSize',8);

plot(4,w027_mean_IS_l_p+.2,'ko','MarkerSize',8);
plot(4,w044_mean_IS_l_p,'kd','MarkerSize',8);

plot(5,w027_mean_IS_lfp+.1,'ko','MarkerSize',8);
plot(5,w042_mean_IS_lfp-.1,'k+','MarkerSize',10);
plot(5,w044_mean_IS_lfp-.2,'kd','MarkerSize',8);

xlim([.3 5.7]);
ylim([0 15.7])
box off
xticks([1 2 3 4 5])
xticklabels({'L ant EEG','R ant EEG','R post EEG','L post EEG','LFP DVR'})
xtickangle(-30)
ylabel('IS (%)');

%% ANOVA test to see if the durations are different across sites
% [p_SWS, tbl_SWS, stats_SWS] = anova1(SWS_percentages,group)
% [c,m,h,nms] = multcompare(stats_SWS)
IS_lengths=[IS_bouts_len.l_a IS_bouts_len.r_a  IS_bouts_len.r_p IS_bouts_len.l_p IS_bouts_len.lfp];
IS_groups=[ones(size(IS_bouts_len.l_a)) 2*ones(size(IS_bouts_len.r_a))...
    3*ones(size(IS_bouts_len.r_p)) 4*ones(size(IS_bouts_len.l_p)) 5*ones(size(IS_bouts_len.lfp))];
[p_IS, tbl_ISS, stats_IS] = anova1(IS_lengths,IS_groups);
[c,m,h,nms] = multcompare(stats_IS)

SWS_lengths=[SWS_bouts_len.l_a SWS_bouts_len.r_a  SWS_bouts_len.r_p SWS_bouts_len.l_p SWS_bouts_len.lfp];
SWS_groups=[ones(size(SWS_bouts_len.l_a)) 2*ones(size(SWS_bouts_len.r_a))...
    3*ones(size(SWS_bouts_len.r_p)) 4*ones(size(SWS_bouts_len.l_p)) 5*ones(size(SWS_bouts_len.lfp))];
[p_SWS, tbl_SWSS, stats_SWS] = anova1(SWS_lengths,SWS_groups);
[c,m,h,nms] = multcompare(stats_SWS)

REM_lengths=[REM_bouts_len.l_a REM_bouts_len.r_a  REM_bouts_len.r_p REM_bouts_len.l_p REM_bouts_len.lfp];
REM_groups=[ones(size(REM_bouts_len.l_a)) 2*ones(size(REM_bouts_len.r_a))...
    3*ones(size(REM_bouts_len.r_p)) 4*ones(size(REM_bouts_len.l_p)) 5*ones(size(REM_bouts_len.lfp))];
[p_REM, tbl_REMS, stats_REM] = anova1(REM_lengths,REM_groups);
[c,m,h,nms] = multcompare(stats_REM)














