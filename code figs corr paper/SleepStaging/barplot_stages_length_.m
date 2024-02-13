clc;
% colors for each stage
r=.8*[1 .4 .4 ]; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
w=[.9 .9 .3];
%bar plot for the percentage of each stage
figure('position',[300 600 900 200])

% Wake
subplot(1,4,4) 
x=1:5; % for 4 recording sites
y = [0.13738	0.141025	0.302775	0.1756	0.12824

];
err = [0.064844406	0.09893612	0.168542781	0.063268581	0.102071999

]/2; % division by 2 for ste
errorbar(x, y*100, err*100, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',w,'MarkerFaceColor',w,'linestyle','none','color','k')
xlim([.3 5.7]);
ylim([0 50])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
yticklabels([])
title('Wake (following movements)')

% SWS
subplot(1,4,1) 
x=1:5; % for 4 recording sites
y = [0.36512	0.35795	0.274975	0.33825	0.44334
];
err = [0.057001991	0.07653803	0.096966468	0.046411888	0.080386252
]/2; % division by 2 for ste
errorbar(x, y*100, err*100, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',s,'MarkerFaceColor',s,'linestyle','none','color','k')
xlim([.3 5.7]);
ylim([0 50])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
title('SWS')
ylabel('Time (%)')

% IS
subplot(1,4,2) 
x=1:5; % for 4 recording sites
y = [0.10726	0.1439	0.107975	0.113725	0.08714
];
err = [0.031218232	0.041510079	0.029297597	0.04179357	0.02786051
]/2; % division by 2 for ste
errorbar(x, y*100, err*100, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',i,'MarkerFaceColor',i,'linestyle','none','color','k'); hold on
% IS_times_r_caud=[0.7837    0.1514  0.0988  0.0939]*100;
% scatter(3+randn(size(IS_times_r_caud))*.1,IS_times_r_caud);
% IS_times_l_caud=[0.71   0.22    0.14    0.16    ]*100;
% scatter(4+randn(size(IS_times_l_caud))*.1,IS_times_l_caud);
xlim([.3 5.7]);
ylim([0 50])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
yticklabels([])
title('IS')

% REM
subplot(1,4,3) 
x=1:5; % for 4 recording sites
y = [0.39294	0.35715	0.31475	0.37745	0.34126
];
err = [0.016826111	0.044771308	0.07271545	0.049975827	0.099593188
]/2; % division by 2 for ste
errorbar(x, y*100, err*100, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',r,'MarkerFaceColor',r,'linestyle','none','color','k'); 
ylim([0 50])
box off
xticks([1 2 3 4 5])
xticklabels({'L front EEG','R front EEG','R caudal EEG','L caudal EEG','DVR'})
xtickangle(-30)
yticklabels([])
title('REM')

% statistical tests to show SWS and REM are significantly more observed in
% front, and IS is significantly more observed in caudalral side
% 
SWS_front=[0.4465	0.4006	0.3376	0.334	0.3069	0.4463	0.3958		0.2812	0.3085];
SWS_caudal=[0.41	0.3988  0.2804	0.2864  0.3398  0.1983	0.2112	0.328];
REM_front=[0.4038	0.4215  0.4012	0.353   0.3966	0.3999	0.3224  0.3632	0.3317];
REM_caudal=[0.414	0.4189  0.3218	0.3051  0.3985  0.2491	0.2741	0.3873];
IS_front=[0.1238	0.1206  0.096	0.1087  0.0767	0.0864	0.1442  0.1534	0.2021];
IS_caudal= [0.0878	0.0865  0.1514	0.1512  0.0696  0.0988	0.0939	0.1476];
Wake_front=[0.0394	0.0117  0.1023	0.1425  0.1891	0.1797	0.2522  0.1764	0.1577];
Wake_caudal=[0.09	0.1158  0.2464	0.2573  0.1922  0.4539	0.4208	0.1371];
clc;
[p,h_SWS_front_caudal]=ranksum(SWS_front,SWS_caudal)
[p,h_IS_front_caudal]=ranksum(IS_front,IS_caudal)
[p,h_REM_front_caudal]=ranksum(REM_front,REM_caudal)
[p,h_Wake_front_caudal]=ranksum(Wake_front,Wake_caudal)

SWS_R=[0.4463	0.41 0.3958	0.2804 0.2812	0.1983  0.3085	0.2112];
SWS_L=[0.4465   0.4006  0.3376  0.334   0.3069  0.3988  0.2864     0.3398   0.328];

IS_R=[0.1206	0.0878  0.1087	0.1514  0.1442	0.0988  0.2021	0.0939];
IS_L=[0.1238  0.096 0.0767  0.0864  0.1534  0.0865  0.1512  0.0696  0.1476  ];

REM_R=[0.4215	0.414   0.353	0.3218  0.3224	0.2491  0.3317	0.2741 ];
REM_L=[0.4038   0.4012  0.3966  0.3999  0.3632  0.4189  0.3051  0.3985  0.3873];

Wake_R=[0.0117	0.09    0.1425	0.2464  0.2522	0.4539  0.1577	0.4208 ];
Wake_L=[0.0394  0.1023  0.1891  0.1797  0.1764  0.1158  0.2573  0.1922  0.1371];


[p,h_SWS_R_L]=ranksum(SWS_R,SWS_L)
[p,h_IS_R_L]=ranksum(IS_R,IS_L)
[p,h_REM_R_L]=ranksum(REM_R,REM_L)
[p,h_Wake_R_L]=ranksum(Wake_R,Wake_L)
%#################

mean_all_SWS=mean([SWS_front SWS_caudal])
sd_all_SWS=std([SWS_front SWS_caudal])

mean_all_REM=mean([REM_front REM_caudal])
sd_all_REM=std([REM_front REM_caudal])

mean_all_IS=mean([IS_front IS_caudal])
sd_all_IS=std([IS_front IS_caudal])

mean_all_Wake=mean([Wake_front Wake_caudal])
sd_all_Wake=std([Wake_front Wake_caudal])