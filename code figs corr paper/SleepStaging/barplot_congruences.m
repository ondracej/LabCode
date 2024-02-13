clc;

% colors for each stage
r=.8*[1 .4 .4 ]; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
w=[.9 .9 .3];
%bar plot for the incongruence
figure('position',[300 600 700 200])
% SWS
subplot(1,3,1) 
x=1:4; % for 4 recording sites
y = [0.6	0.3775	0.587	0.704];
err = [0.201659779	0.195852836	0.119258822	0.040373258]/2; % division by 2 for ste
errorbar(x, y*100, err*100, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',s,'MarkerFaceColor',s,'linestyle','none','color','k')
xlim([.3 4.7]);
ylim([0 80])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
title('SWS')
ylabel('Congruence (%)')

% IS
subplot(1,3,2) 
x=1:4; % for 4 recording sites
y = [0.225	0.1375	0.1675	0.134];
err = [0.056862407	0.045	0.035939764	0.023021729]/2;
errorbar(x, y*100, err*100, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',i,'MarkerFaceColor',i,'linestyle','none','color','k')
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
y = [0.58	0.475	0.6475	0.57];
err = [0.169901932	0.157162336	0.110867789	0.171318417]/2;
errorbar(x, y*100, err*100, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',r,'MarkerFaceColor',r,'linestyle','none','color','k')
xlim([.3 4.7])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
ylim([0 80])
title('REM')
yticklabels([])

% statistical tests to show that congruence is lower during IS
% IS vs SWS and REM
IS_congs=[0.25	0.14	0.15	0.11 ...
0.2	0.2	0.22	0.11 ...
		0.14	0.15 ...
0.16	0.11		0.14 ...
0.29	0.1	0.16	0.16  ];

SWS_congs=[0.77	0.65	0.688	0.66 ...
0.63	0.39	0.44	0.73 ...
0.31		0.68	0.68 ...
	0.24		0.69 ...
0.69	0.23	0.54	0.76 ];

REM_congs=[0.73	0.67	0.73	0.42 ...
0.66	0.5	0.52	0.59 ...
0.34		0.75	0.73 ...
	0.29		0.74 ...
0.59	0.44	0.59	0.37 ...
];
clc;
[p,h_IS_SWS]=ranksum(IS_congs,SWS_congs)
[p,h_IS_REM]=ranksum(IS_congs,REM_congs)
[p,h_SWS_REM]=ranksum(SWS_congs,REM_congs)

mean_IS_congs=mean(IS_congs)
st_IS_congs=std(IS_congs)
mean_SWS_congs=mean(SWS_congs)
st_SWS_congs=std(SWS_congs)
mean_REM_congs=mean(REM_congs)
st_REM_congs=std(REM_congs)