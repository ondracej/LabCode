clc;
% colors for each stage
r=.9*[1 .4 .4 ]; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
w=[.9 .9 .3];
%bar plot for the percentage of each stage
figure('position',[300 600 800 200])

% SWS
subplot(1,3,1) 
x=1:5; % for 4 recording sites
y = [0.1695	0.161	0.1673	0.260133333	0.51965
];
err = [0.15401106	0.105862458	0.140319017	0.095866852	0.154065306
]/2; % division by 2 for ste
errorbar(x, y*100, err*100, '-','MarkerSize', 10,...
    'MarkerEdgeColor',s,'MarkerFaceColor',s,'linestyle','none','color','k'); hold on
bar(x,y*100,'FaceColor',s);
plot(1,100* 0.07,'kx','MarkerSize',10);
plot(1,100* 0.389,'ko','MarkerSize',10);
plot(1,100* 0.083,'k+','MarkerSize',10);
plot(1,100* 0.14,'kd','MarkerSize',8);

plot(2,100* 0.271,'kx','MarkerSize',10);
plot(2,100* 0.07,'ko','MarkerSize',10);
plot(2,100* 0.088,'k+','MarkerSize',10);
plot(2,100* 0.223,'kd','MarkerSize',8);

plot(3,100* 0.20,'kx','MarkerSize',10);
plot(3,100* 0.082,'ko','MarkerSize',10);
plot(3,100* 0.05,'k+','MarkerSize',10);
plot(3,100* 0.356,'kd','MarkerSize',8);

plot(4,100* 0.256,'kx','MarkerSize',10);
plot(4,100* 0.162,'ko','MarkerSize',10);
plot(4,100* 0.3816,'kd','MarkerSize',8);

plot(5,100* 0.626,'kx','MarkerSize',10);
plot(5,100* 0.542,'ko','MarkerSize',10);
plot(5,100* 0.33,'k+','MarkerSize',10);
plot(5,100* 0.566,'kd','MarkerSize',8);

xlim([.3 5.7]);
ylim([0 73])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
title('SWS')
ylabel('Time (%)')

% IS
subplot(1,3,2) 
x=1:5; % for 4 recording sites
y = [0.4123	0.4925	0.425525	0.262	0.202925

];
err = [0.186826872	0.138570728	0.265744305	0.14857658	0.020795733
]/2; % division by 2 for ste
errorbar(x, y*100, err*100, '-','MarkerSize', 10,...
    'MarkerEdgeColor',i,'MarkerFaceColor',i,'linestyle','none','color','k'); hold on

bar(x,y*100,'FaceColor',i);
plot(1,100* 0.48,'kx','MarkerSize',10);
plot(1,100* 0.149,'ko','MarkerSize',10);
plot(1,100* 0.433,'k+','MarkerSize',10);
plot(1,100* 0.58,'kd','MarkerSize',8);

plot(2,100* 0.301,'kx','MarkerSize',10);
plot(2,100* 0.62,'ko','MarkerSize',10);
plot(2,100* 0.568,'k+','MarkerSize',10);
plot(2,100* 0.483,'kd','MarkerSize',8);

plot(3,100* 0.38,'kx','MarkerSize',10);
plot(3,100* 0.492,'ko','MarkerSize',10);
plot(3,100* 0.73,'k+','MarkerSize',10);
plot(3,100* 0.106,'kd','MarkerSize',8);

plot(4,100* 0.326,'kx','MarkerSize',10);
plot(4,100* 0.362,'ko','MarkerSize',10);
plot(4,100* 0.1016,'kd','MarkerSize',8);

plot(5,100* 0.196,'kx','MarkerSize',10);
plot(5,100* 0.182,'ko','MarkerSize',10);
plot(5,100* 0.23,'k+','MarkerSize',10);
plot(5,100* 0.226,'kd','MarkerSize',8);

xlim([.3 5.7]);
ylim([0 73.1])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
yticklabels([])
title('IS')

% REM
subplot(1,3,3) 
x=1:5; % for 4 recording sites
y = [0.3288	0.2441	0.328225	0.415766667	0.2708
];
err = [0.138067809	0.09211681	0.153861894	0.046901741	0.086342303
]/2; % division by 2 for ste
errorbar(x, y*100, err*100, '-','MarkerSize', 10,...
    'MarkerEdgeColor',r,'MarkerFaceColor',r,'linestyle','none','color','k'); hold on
bar(x,y*100,'FaceColor',r);

plot(1,100* 0.40,'kx','MarkerSize',10);
plot(1,100* 0.41,'ko','MarkerSize',10);
plot(1,100* 0.373,'k+','MarkerSize',10);
plot(1,100* 0.12,'kd','MarkerSize',8);

plot(2,100* 0.371,'kx','MarkerSize',10);
plot(2,100* 0.15,'ko','MarkerSize',10);
plot(2,100* 0.228,'k+','MarkerSize',10);
plot(2,100* 0.223,'kd','MarkerSize',8);

plot(3,100* 0.36,'kx','MarkerSize',10);
plot(3,100* 0.362,'ko','MarkerSize',10);
plot(3,100* 0.11,'k+','MarkerSize',10);
plot(3,100* 0.476,'kd','MarkerSize',8);

plot(4,100* 0.36,'kx','MarkerSize',10);
plot(4,100* 0.422,'ko','MarkerSize',10);
plot(4,100* 0.4516,'kd','MarkerSize',8);

plot(5,100* 0.166,'kx','MarkerSize',10);
plot(5,100* 0.342,'ko','MarkerSize',10);
plot(5,100* 0.33,'k+','MarkerSize',10);
plot(5,100* 0.226,'kd','MarkerSize',8);

xlim([.3 5.7]);
ylim([0 73])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
yticklabels([])
title('REM')

%% statistical tests regarding comparison of SWS across sites
DVR_perc=[0.6296    0.5483  0.3346  0.5661];
p_l_a = 4*ranksum(DVR_perc,[0.0615
0.3956

0.084
0.1369
])
p_r_a = 4*ranksum(DVR_perc,[0.2735
0.0608

0.0812
0.2285
])
p_r_p = 4*ranksum(DVR_perc,[0.2
0.078

0.04
0.3512
])
p_l_p = 4*ranksum(DVR_perc,[0.256
0.1664

 
0.358
])

% IS percentage comparison of DVR and rest
DVR_perc=[0.192
0.1794

0.2241
0.2162
];
p_l_a = 4*ranksum(DVR_perc,[0.4838
0.148

0.434
0.5834
])
p_r_a = 4*ranksum(DVR_perc,[0.3032
0.6217

0.563
0.4821

])
p_r_p = 4*ranksum(DVR_perc,[0.382
0.4914

0.7348
0.0939

])
p_l_p = 4*ranksum(DVR_perc,[0.327
0.367

0.092
])


% statistical test to see if in DVR, percentage of IS and SWS are
% significantly diffrerent
p_l_a = ranksum([0.192
0.1794
0.2241
0.2162
],[0.6296    0.5483  0.3346  0.5661])

%% ANOVA test 
% ANOVA test to see if the classification of sleep into stages are different across sites (factor), for ...
% each sleep stage separately

IS_percentages=[0.4838	0.3032	0.382	0.327	0.192 ...
0.148	0.6217	0.4914	0.367	0.1794 ...
				0.434	0.563	0.7348		0.2241 ...
0.5834	0.4821	0.0939	0.092	0.2162
];

group=[1:5 1:5 1 2 3 5 1:5];
[p_IS, tbl_IS, stats_IS] = anova1(IS_percentages,group)

%
REM_percentages=[0.4068	0.3724	0.366	0.3649	0.169 ...
0.4112	0.153	0.3618	0.4251	0.3477...
				0.374	0.224	0.111		0.337...
0.1232	0.227	0.4741	0.4573	0.2295
];
[p_REM, tbl_REM, stats_REM] = anova1(REM_percentages,group)
%
SWS_percentages=[0.0615	0.2735	0.2	0.256	0.6296 ...
0.3956	0.0608	0.078	0.1664	0.5483 ...
				0.084	0.0812	0.04	 	0.3346...
0.1369	0.2285	0.3512	0.358	0.5661];
[p_SWS, tbl_SWS, stats_SWS] = anova1(SWS_percentages,group)
[c,m,h,nms] = multcompare(stats_SWS)








