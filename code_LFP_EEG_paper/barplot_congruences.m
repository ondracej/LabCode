clc;

% colors for each stage
r=[ 253 145 33]/255; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
%bar plot for the incongruence
figure('position',[300 200 250 700])
% SWS
subplot(3,1,1) 
x=1:4; % for 4 recording sites
y = [40.33333333	37	54	43.66666667];
err = [20.23198787	12.76714533	7.071067812	8.736894948]/sqrt(3); % division by 2 for ste
errorbar(x, y, err, '-','MarkerSize', 10,...
    'MarkerEdgeColor',s,'MarkerFaceColor',s,'linestyle','none','color','k'); hold on
bar(x,y,'FaceColor',s,'EdgeColor','none','BarWidth',.6);
plot(1,100* 0.51,'ko','MarkerSize',10);
plot(1,100* 0.17,'k+','MarkerSize',10);
plot(1,100* 0.53,'kd','MarkerSize',8);

plot(2,100* 0.48,'ko','MarkerSize',10);
plot(2,100* 0.23,'k+','MarkerSize',10);
plot(2,100* 0.4,'kd','MarkerSize',8);

plot(3,100* 0.59,'ko','MarkerSize',10);
plot(3,100* 0.49,'kd','MarkerSize',8);

plot(4,100* 0.51,'ko','MarkerSize',10);
plot(4,100* 0.34,'k+','MarkerSize',10);
plot(4,100* 0.46,'kd','MarkerSize',8);

xlim([.3 4.7]);
ylim([0 90])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
title('SWS')
ylabel('Congruence (%)')

% IS
subplot(3,1,3) 
x=1:4; % for 4 recording sites

y = [52	47	49.5	42];
err = [10.19803903	7.937253933	13.43502884	11.35781669]/sqrt(3);
errorbar(x, y, err, '-','MarkerSize', 10,...
    'MarkerEdgeColor',i,'MarkerFaceColor',i,'linestyle','none','color','k'); hold on
bar(x,y,'FaceColor',i,'EdgeColor','none','BarWidth',.6);

plot(1,100* 0.48,'ko','MarkerSize',10);
plot(1,100* 0.42,'k+','MarkerSize',10);
plot(1,100* 0.66,'kd','MarkerSize',8);

plot(2,100* 0.53,'ko','MarkerSize',10);
plot(2,100* 0.5,'k+','MarkerSize',10);
plot(2,100* 0.38,'kd','MarkerSize',8);

plot(3,100* 0.59,'ko','MarkerSize',10);
plot(3,100* 0.4,'kd','MarkerSize',8);

plot(4,100* 0.37,'ko','MarkerSize',10);
plot(4,100* 0.34,'k+','MarkerSize',10);
plot(4,100* 0.55,'kd','MarkerSize',8);

xlim([.3 4.7])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
ylim([0 90])
title('IS')
ylabel('Congruence (%)')

% REM
subplot(3,1,2) 
x=1:4; % for 4 recording sites

y = [59.66666667	47.33333333	42	35.33333333];
err = [30.08875759	21.38535324	19.79898987	10.96965511]/sqrt(3);
errorbar(x, y, err, '-','MarkerSize', 10,...
    'MarkerEdgeColor',r,'MarkerFaceColor',r,'linestyle','none','color','k'); hold on
bar(x,y,'FaceColor',r,'EdgeColor','none','BarWidth',.6);

plot(1,100* 0.57,'ko','MarkerSize',10);
plot(1,100* 0.31,'k+','MarkerSize',10);
plot(1,100* 0.89,'kd','MarkerSize',8);

plot(2,100* 0.36,'ko','MarkerSize',10);
plot(2,100* 0.34,'k+','MarkerSize',10);
plot(2,100* 0.72,'kd','MarkerSize',8);

plot(3,100* 0.28,'ko','MarkerSize',10);
plot(3,100* 0.56,'kd','MarkerSize',8);

plot(4,100* 0.44,'ko','MarkerSize',10);
plot(4,100* 0.39,'k+','MarkerSize',10);
plot(4,100* 0.23,'kd','MarkerSize',8);

xlim([.3 4.7])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R caudal EEG','L caudal EEG','LFP DVR'})
xtickangle(-30)
ylim([0 90])
title('REM')
ylabel('Congruence (%)')

%% statistics
% mean and sd of congruence at each sleep stage

cong_SWS=[0.71	0.721	0.336	0.426   0.079	0.079	0.255	0.802 ...
			0.103	0.048		0.39    0.69	0.453	0.54	0.716 ];
cong_IS=[0.41	0.407	0.336	0.223   0.651	0.493	0.456	0.223 ...
			0.613	0.791		0.24    0.71	0.11	0.11	0.2436];
    cong_REM=[0.59	0.582	0.454	0.59    0.14	0.312	0.575	0.27 ...
			0.232	0.113		0.36    0.59	0.74	0.72	0.394];

mean_cong_SWS=mean(cong_SWS)
sd_cong_SWS=std(cong_SWS)

mean_cong_IS=mean(cong_IS)
sd_cong_IS=std(cong_IS)

mean_cong_REM=mean(cong_REM)
sd_cong_REM=std(cong_REM)

% anova2 test to see if there is a diff in congrunce across stages
congs=[cong_SWS cong_IS cong_REM];
stages=[ones(size(cong_SWS)) 2*ones(size(cong_IS)) 3*ones(size(cong_REM))]; % 1:SWS, 2:IS, 3: REM
locations=[1 1 1 1  2 2 2 2 3 3 3  4 4 4 4  ... % 1: r_1, 2: r_p, 3: l_p, 4: DVR
    1 1 1 1 2 2 2 2 3 3 3  4 4 4 4  ...
    1 1 1 1  2 2 2 2 3 3 3  4 4 4 4 ];
[p,~,~] = anovan(congs,{stages,locations})










