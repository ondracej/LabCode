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
y = [0.60	0.2175	0.4175	0.704];
err = [0.201	0.156	0.288	0.040]/2; % division by 2 for ste
errorbar(x, y*100, err*100, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',s,'MarkerFaceColor',s,'linestyle','none','color','k')
xlim([.3 4.7]);
ylim([0 100])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R rost EEG','L rost EEG','DVR'})
xtickangle(-30)
title('SWS')
ylabel('Congruence (%)')

% IS
subplot(1,3,2) 
x=1:4; % for 4 recording sites
y = [0.225	0.2875	0.3075	0.134];
err = [0.056862407	0.305	0.270477972	0.023021729]/2;
errorbar(x, y*100, err*100, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',i,'MarkerFaceColor',i,'linestyle','none','color','k')
xlim([.3 4.7])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R rost EEG','L rost EEG','DVR'})
xtickangle(-30)
ylim([0 100])
title('IS')
% REM
subplot(1,3,3) 
x=1:4; % for 4 recording sites
y = [0.58	0.3375	0.49	0.57];
err = [0.169901932	0.169779268	0.277248384	0.171318417]/2;
errorbar(x, y*100, err*100, '-s','MarkerSize', 10,...
    'MarkerEdgeColor',r,'MarkerFaceColor',r,'linestyle','none','color','k')
xlim([.3 4.7])
box off
xticks([1 2 3 4])
xticklabels({'R front EEG','R rost EEG','L rost EEG','DVR'})
xtickangle(-30)
ylim([0 100])
title('REM')

% statistical tests for the differenct across stages
% IS vs SWS
IS_congs=[0.25,	0.74,	0.71,	0.11,   0.2,	0.2	,0.22	,0.11, ...
		0.14	0.15  0.16	0.11	0.14,   0.29	0.1	0.16	0.16 ];
SWS_congs=[0.77	0.01	0.01	0.66    0.63	0.39	0.44	0.73 ...
0.31	0.68	0.68 	0.24		0.69    0.69	0.23	0.54	0.76];
REM_congs=[0.73	0.12	0.1     0.42    0.66	0.5	0.52	0.59    0.34 ...
    0.75	0.73   	0.29		0.74    0.59	0.44	0.59	0.37];

[h_IS_SWS,p]=ttest2(IS_congs,SWS_congs)
[h_IS_REM,p]=ttest2(IS_congs,REM_congs)

mean_IS_congs=mean(IS_congs)
st_IS_congs=std(IS_congs)
mean_SWS_congs=mean(SWS_congs)
st_SWS_congs=std(SWS_congs)
mean_REM_congs=mean(REM_congs)
st_REM_congs=std(REM_congs)