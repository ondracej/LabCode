clc;

% colors for each stage
r=.9*[1 .4 .4 ]; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
w=[.9 .9 .3];
%bar plot for the incongruence
figure('position',[300 700 800 200])
% SWS
subplot(1,3,1) 
x=1:4; % for 4 recording sites
y = [0.3955	0.32525	0.377	0.5835];
err = [0.307090052	0.321685535	0.193210378	0.183709553]/2; % division by 2 for ste
errorbar(x, y*100, err*100, '-','MarkerSize', 10,...
    'MarkerEdgeColor',s,'MarkerFaceColor',s,'linestyle','none','color','k'); hold on
bar(x,y*100,'FaceColor',s);
plot(1,100* 0.71,'kx','MarkerSize',10);
plot(1,100* 0.079,'ko','MarkerSize',10);
plot(1,100* 0.103,'k+','MarkerSize',10);
plot(1,100* 0.69,'kd','MarkerSize',8);

plot(2,100* 0.721,'kx','MarkerSize',10);
plot(2,100* 0.079,'ko','MarkerSize',10);
plot(2,100* 0.048,'k+','MarkerSize',10);
plot(2,100* 0.453,'kd','MarkerSize',8);

plot(3,100* 0.336,'kx','MarkerSize',10);
plot(3,100* 0.255,'ko','MarkerSize',10);
plot(3,100* 0.54,'kd','MarkerSize',8);

plot(4,100* 0.426,'kx','MarkerSize',10);
plot(4,100* 0.802,'ko','MarkerSize',10);
plot(4,100* 0.39,'k+','MarkerSize',10);
plot(4,100* 0.716,'kd','MarkerSize',8);



xlim([.3 4.7]);
ylim([0 80.21])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
title('SWS')
ylabel('Congruence (%)')

% IS
subplot(1,3,2) 
x=1:4; % for 4 recording sites
y = [0.596	0.45025	0.2905	0.2324];
err = [0.130263835	0.280225356	0.164409043	0.038051702]/2;
errorbar(x, y*100, err*100, '-','MarkerSize', 10,...
    'MarkerEdgeColor',i,'MarkerFaceColor',i,'linestyle','none','color','k'); hold on
bar(x,y*100,'FaceColor',i);

plot(1,100* 0.41,'kx','MarkerSize',10);
plot(1,100* 0.659,'ko','MarkerSize',10);
plot(1,100* 0.613,'k+','MarkerSize',10);
plot(1,100* 0.71,'kd','MarkerSize',8);

plot(2,100* 0.401,'kx','MarkerSize',10);
plot(2,100* 0.499,'ko','MarkerSize',10);
plot(2,100* 0.798,'k+','MarkerSize',10);
plot(2,100* 0.113,'kd','MarkerSize',8);

plot(3,100* 0.336,'kx','MarkerSize',10);
plot(3,100* 0.455,'ko','MarkerSize',10);
plot(3,100* 0.11,'kd','MarkerSize',8);

plot(4,100* 0.236,'kx','MarkerSize',10);
plot(4,100* 0.212,'ko','MarkerSize',10);
plot(4,100* 0.25,'k+','MarkerSize',10);
plot(4,100* 0.23,'kd','MarkerSize',8);

xlim([.3 4.7])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
ylim([0 80])
title('IS')
yticklabels([])

% REM
subplot(1,3,3) 
x=1:4; % for 4 recording sites
y = [0.3784	0.43675	0.58475	0.40887];

err = [0.205725059	0.278947277	0.137101848	0.186995187]/2;
errorbar(x, y*100, err*100, '-','MarkerSize', 10,...
    'MarkerEdgeColor',r,'MarkerFaceColor',r,'linestyle','none','color','k'); hold on
bar(x,y*100,'FaceColor',r);

plot(1,100* 0.59,'kx','MarkerSize',10);
plot(1,100* 0.14,'ko','MarkerSize',10);
plot(1,100* 0.233,'k+','MarkerSize',10);
plot(1,100* 0.59,'kd','MarkerSize',8);

plot(2,100* 0.581,'kx','MarkerSize',10);
plot(2,100* 0.319,'ko','MarkerSize',10);
plot(2,100* 0.118,'k+','MarkerSize',10);
plot(2,100* 0.743,'kd','MarkerSize',8);

plot(3,100* 0.456,'kx','MarkerSize',10);
plot(3,100* 0.575,'ko','MarkerSize',10);
plot(3,100* 0.72,'kd','MarkerSize',8);

plot(4,100* 0.596,'kx','MarkerSize',10);
plot(4,100* 0.272,'ko','MarkerSize',10);
plot(4,100* 0.36,'k+','MarkerSize',10);
plot(4,100* 0.39,'kd','MarkerSize',8);

xlim([.3 4.7])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
ylim([0 80])
title('REM')
yticklabels([])

% statistics
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










