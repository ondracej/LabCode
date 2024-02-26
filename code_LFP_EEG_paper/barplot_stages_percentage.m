clc;
% colors for each stage
r=[ 253 145 33]/255; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
%bar plot for the percentage of each stage
figure('position',[300 200 300 700])

% SWS
subplot(3,1,1) 
x=1:5; % for 4 recording sites
y = [22.33333333	20	24	32	32
];
err = [2.886751346	5.291502622	6.08276253	2.828427125	2.645751311

]/sqrt(3); % division by 2 for ste
errorbar(x, y, err, '-','MarkerSize', 10,...
    'MarkerEdgeColor',s,'MarkerFaceColor',s,'linestyle','none','color','k'); hold on
bar(x,y,'FaceColor',s,'EdgeColor','none','BarWidth',.7);
plot(1,100* 0.249,'ko','MarkerSize',10);
plot(1,100* 0.193,'k+','MarkerSize',10);
plot(1,100* 0.24,'kd','MarkerSize',8);

plot(2,100* 0.26,'ko','MarkerSize',10);
plot(2,100* 0.188,'k+','MarkerSize',10);
plot(2,100* 0.163,'kd','MarkerSize',8);

plot(3,100* 0.312,'ko','MarkerSize',10);
plot(3,100* 0.215,'k+','MarkerSize',10);
plot(3,100* 0.206,'kd','MarkerSize',8);

plot(4,100* 0.342,'ko','MarkerSize',10);
plot(4,100* 0.306,'kd','MarkerSize',8);

plot(5,100* 0.352,'ko','MarkerSize',10);
plot(5,100* 0.31,'k+','MarkerSize',10);
plot(5,100* 0.30,'kd','MarkerSize',8);

xlim([.3 5.7]);
ylim([0 62])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R post EEG','L post EEG','DVR'})
xtickangle(-30)
ylabel('SWS (%)')

% IS
subplot(3,1,3) 
x=1:5; % for 4 recording sites
y = [55	46	44.66666667	46	40.33333333
];
err = [6.08276253	6.08276253	8.386497084	11.3137085	11.01514109

]/sqrt(3); % division by 2 for ste
errorbar(x, y, err, '-','MarkerSize', 10,...
    'MarkerEdgeColor',i,'MarkerFaceColor',i,'linestyle','none','color','k'); hold on

bar(x,y,'FaceColor',i,'EdgeColor','none','BarWidth',.7);
plot(1,100* 0.51,'ko','MarkerSize',10);
plot(1,100* 0.52,'k+','MarkerSize',10);
plot(1,100* 0.62,'kd','MarkerSize',8);

plot(2,100* 0.42,'ko','MarkerSize',10);
plot(2,100* 0.43,'k+','MarkerSize',10);
plot(2,100* 0.53,'kd','MarkerSize',8);

plot(3,100* 0.50,'ko','MarkerSize',10);
plot(3,100* 0.49,'k+','MarkerSize',10);
plot(3,100* 0.35,'kd','MarkerSize',8);

plot(4,100* 0.54,'ko','MarkerSize',10);
plot(4,100* 0.38,'kd','MarkerSize',8);

plot(5,100* 0.35,'ko','MarkerSize',10);
plot(5,100* 0.33,'k+','MarkerSize',10);
plot(5,100* 0.53,'kd','MarkerSize',8);

xlim([.3 5.7]);
ylim([0 62])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R post EEG','L post EEG','DVR'})
xtickangle(-30)

ylabel('IS (%)')

% REM
subplot(3,1,2) 
x=1:5; % for 4 recording sites
y = [22.33333333	32.66666667	30.33333333	21	26.33333333

];
err = [7.637626158	4.618802154	13.0511813	14.14213562	9.609023537

]/sqrt(3); % division by 2 for ste
errorbar(x, y, err, '-','MarkerSize', 10,...
    'MarkerEdgeColor',r,'MarkerFaceColor',r,'linestyle','none','color','k'); hold on
bar(x,y,'FaceColor',r,'EdgeColor','none','BarWidth',.7);

plot(1,100* 0.24,'ko','MarkerSize',10);
plot(1,100* 0.29,'k+','MarkerSize',10);
plot(1,100* 0.14,'kd','MarkerSize',8);

plot(2,100* 0.30,'ko','MarkerSize',10);
plot(2,100* 0.38,'k+','MarkerSize',10);
plot(2,100* 0.30,'kd','MarkerSize',8);

plot(3,100* 0.182,'ko','MarkerSize',10);
plot(3,100* 0.293,'k+','MarkerSize',10);
plot(3,100* 0.446,'kd','MarkerSize',8);

plot(4,100* 0.112,'ko','MarkerSize',10);
plot(4,100* 0.31,'kd','MarkerSize',8);

plot(5,100* 0.282,'ko','MarkerSize',10);
plot(5,100* 0.35,'k+','MarkerSize',10);
plot(5,100* 0.16,'kd','MarkerSize',8);

xlim([.3 5.7]);
ylim([0 62])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R post EEG','L post EEG','DVR'})
xtickangle(-30)

ylabel('REM (%)')

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








