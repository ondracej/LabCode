
%% general info: bird_id , color theme, symbol, ...
clear
data=load('G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\batch_results3with_dph_Fig_1_2_3'); % the file containing the batch result of all birds
res=data.res; % the variable containing the results
ress=res(1:49);

bird_names={'72-00','73-03','72-94','w0009','w0016','w0018','w0020','w0021','w0041','w0043'};
bird_symbols={'o','<','>','+','*','x','s','d','v','^'};
rng(355);
col_=.9*rand(10,3);
col_mask=[.5*ones(3,3); 1.1*ones(7,3)];
col=col_.*col_mask;
%  extracting the ID for each bird (1 to 8)
for bird_n=1:length(ress)
    % finding the name of the bird
    bird_name_long=ress(bird_n).bird; % like '72-94_08_09_2021'
    bird_name=bird_name_long(1:5); % like '72-94'
    
    % finding the bird index (lopping over number of birds)
    for i=1:length(bird_names)
        if strcmp(bird_names{i},bird_name)
            bird_id(bird_n)=i;
            break
        end
    end
end
clear ss bird_name bird_name_long  bird_n bird_name col_ i n ress valid_chnls

%%
res=load('G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\corr_full_low_high_band2.mat');
res=res.res.res;
% LL, RR, and LR connectivity for each band

for n=1:length(res)
    % high band: LL, RR, and LR
    valid_chnls=res(n).valid_chnls;
    corr_REM=res(n).high_band_corr_REM;
    corr_IS=res(n).high_band_corr_IS;
    corr_low=res(n).high_band_corr_SWS;
    corr_high=(corr_REM+corr_IS+corr_low)/3;
    corr_high_LL_part=corr_high(valid_chnls(valid_chnls<=8),valid_chnls(valid_chnls<=8));
    conn_high_LL(n)=sum(tril(corr_high_LL_part,-1),'all')/...
        (sum(valid_chnls<=8)*(sum(valid_chnls<=8)-1)/2);
    corr_high_RR_part=corr_high(valid_chnls(valid_chnls>8),valid_chnls(valid_chnls>8));
    conn_high_RR(n)=sum(tril(corr_high_RR_part,-1),'all')/...
        (sum(valid_chnls>8)*(sum(valid_chnls>8)-1)/2);
    corr_high_LR_part=corr_high(valid_chnls(valid_chnls<=8),valid_chnls(valid_chnls>8));
    conn_high_LR(n)=sum(corr_high_LR_part,'all')/...
        (sum(valid_chnls<=8)*sum(valid_chnls>8));
    
    % low band: LL, RR, and LR
    valid_chnls=res(n).valid_chnls;
    corr_REM=res(n).low_band_corr_REM;
    corr_IS=res(n).low_band_corr_IS;
    corr_low=res(n).low_band_corr_SWS;
    corr_low=(corr_REM+corr_IS+corr_low)/3;
    corr_low_LL_part=corr_low(valid_chnls(valid_chnls<=8),valid_chnls(valid_chnls<=8));
    conn_low_LL(n)=sum(tril(corr_low_LL_part,-1),'all')/...
        (sum(valid_chnls<=8)*(sum(valid_chnls<=8)-1)/2);
    corr_low_RR_part=corr_low(valid_chnls(valid_chnls>8),valid_chnls(valid_chnls>8));
    conn_low_RR(n)=sum(tril(corr_low_RR_part,-1),'all')/...
        (sum(valid_chnls>8)*(sum(valid_chnls>8)-1)/2);
    corr_low_LR_part=corr_low(valid_chnls(valid_chnls<=8),valid_chnls(valid_chnls>8));
    conn_low_LR(n)=sum(corr_low_LR_part,'all')/...
        (sum(valid_chnls<=8)*sum(valid_chnls>8));
    
    % full band: LL, RR, and LR
    valid_chnls=res(n).valid_chnls;
    corr_REM=res(n).full_band_corr_REM;
    corr_IS=res(n).full_band_corr_IS;
    corr_low=res(n).full_band_corr_SWS;
    corr_full=(corr_REM+corr_IS+corr_low)/3;
    corr_full_LL_part=corr_full(valid_chnls(valid_chnls<=8),valid_chnls(valid_chnls<=8));
    conn_full_LL(n)=sum(tril(corr_full_LL_part,-1),'all')/...
        (sum(valid_chnls<=8)*(sum(valid_chnls<=8)-1)/2);
    corr_full_RR_part=corr_full(valid_chnls(valid_chnls>8),valid_chnls(valid_chnls>8));
    conn_full_RR(n)=sum(tril(corr_full_RR_part,-1),'all')/...
        (sum(valid_chnls>8)*(sum(valid_chnls>8)-1)/2);
    corr_full_LR_part=corr_full(valid_chnls(valid_chnls<=8),valid_chnls(valid_chnls>8));
    conn_full_LR(n)=sum(corr_full_LR_part,'all')/...
        (sum(valid_chnls<=8)*sum(valid_chnls>8));
    
end
clear corr_high_LL_part corr_high_LR_part corr_high_RR_part ...
    corr_low_LL_part corr_low_LR_part corr_low_RR_part ...
corr_full_LL_part corr_full_LR_part corr_full_RR_part ...
corr_IS corr_REM corr_low corr_high  corr_low corr_full corr_all

%%
bird_n=1:length(res);
juv_id=bird_id(bird_n)>3  ; % id of all juveniles
juv_n=1;
juv_inds=[];
for bird_n=1:length(res)
    id=bird_id(bird_n);
    % only one of the parenthesis will be logical 1
    if id>3 % if it is a juvenile
    juv_exp_day(juv_n,1)=res(bird_n).dph; % age at day of recording
    juv_n=juv_n+1;
    juv_inds=[juv_inds bird_n];
    end
end
clear juv_n
% LL, RR, and LR for different bands
% low band
[corr_low_LL, p_low_LL]=corrcoef(juv_exp_day,conn_low_LL(juv_id))
[corr_low_RR , p_low_RR]=corrcoef(juv_exp_day,conn_low_RR(juv_id))
[corr_low_LR, p_low_LR]=corrcoef(juv_exp_day,conn_low_LR(juv_id))

[rr(1)]=corr_low_LL(1,2);
[rr(2)]=corr_low_RR(1,2);
[rr(3)]=corr_low_LR(1,2);

% high band
[corr_high_LL, p_high_LL]=corrcoef(juv_exp_day,conn_high_LL(juv_id))
[corr_high_RR , p_high_RR]=corrcoef(juv_exp_day,conn_high_RR(juv_id))
[corr_high_LR, p_high_LR]=corrcoef(juv_exp_day,conn_high_LR(juv_id))

[rr(4)]=corr_high_LL(1,2);
[rr(5)]=corr_high_RR(1,2);
[rr(6)]=corr_high_LR(1,2);

% full band
[corr_full_LL, p_full_LL]=corrcoef(juv_exp_day,conn_full_LL(juv_id))
[corr_full_RR , p_full_RR]=corrcoef(juv_exp_day,conn_full_RR(juv_id))
[corr_full_LR, p_full_LR]=corrcoef(juv_exp_day,conn_full_LR(juv_id))

[rr(7)]=corr_full_LL(1,2);
[rr(8)]=corr_full_RR(1,2);
[rr(9)]=corr_full_LR(1,2);


% curve fitting
fo = fitoptions('Method','NonlinearLeastSquares','Lower',[.7,.7,.01],'Upper',[1.2,1,0.03]);
g = fittype('a-b*exp(-c*x)','options',fo);
bird_symbols={'o','<','>','+','*','x','s','d','v','^'};

f_juvenile=figure('position',[500 400 800 500])
% color code for birds
rng(355);
col_=.9*rand(10,3);
col_mask=[.5*ones(3,3); 1.1*ones(7,3)];
col=col_.*col_mask;

xx=7:25;
% plot for the L-L
subplot(3,3,1)
1;
x=juv_exp_day-40; y=conn_low_LL(juv_id)'; f0 = fit(x,y,g);
for bird_n=1:length(juv_inds)
    % plotting
    i=bird_id(juv_inds(bird_n));
    p=plot(x(bird_n)+40,y(bird_n),'marker',bird_symbols{i},'markersize',5,'LineWidth', 1.5,'color',col(i,:)); hold on
end
plot(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',1.5);
xlim([45 90]), ylim([-.05 .9])
xticks([50 60 ]); xticklabels([50 60 ])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
title('L-L EEG connectivity')
ylabel('1.5-8 Hz')
tau(1)=1/f0.c;

subplot(3,3,4)
4;
x=juv_exp_day-40; y=conn_high_LL(juv_id)'; f0 = fit(x,y,g);
for bird_n=1:length(juv_inds)
    % plotting
    i=bird_id(juv_inds(bird_n));
    p=plot(x(bird_n)+40,y(bird_n),'marker',bird_symbols{i},'markersize',5,'LineWidth', 1.5,'color',col(i,:)); hold on
end
plot(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',1.5);
xlim([45 90]), ylim([-.05 .9])
xticks([50 60 ]); xticklabels([50 60 ])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
ylabel('30-49 Hz')
tau(4)=1/f0.c;

subplot(3,3,7)
7;
x=juv_exp_day-40; y=conn_full_LL(juv_id)'; f0 = fit(x,y,g);
for bird_n=1:length(juv_inds)
    % plotting
    i=bird_id(juv_inds(bird_n));
    p=plot(x(bird_n)+40,y(bird_n),'marker',bird_symbols{i},'markersize',5,'LineWidth', 1.5,'color',col(i,:)); hold on
end
plot(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',1.5);
xlim([45 90]), ylim([-.05 .9])
xticks([50 60 ]); xticklabels([50 60 ])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
ylabel('full band')
tau(7)=1/f0.c;

% plot for the R-R
subplot(3,3,2)
2;
x=juv_exp_day-40; y=conn_low_RR(juv_id)'; f0 = fit(x,y,g);
for bird_n=1:length(juv_inds)
    % plotting
    i=bird_id(juv_inds(bird_n));
    p=plot(x(bird_n)+40,y(bird_n),'marker',bird_symbols{i},'markersize',5,'LineWidth', 1.5,'color',col(i,:)); hold on
end
plot(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',1.5);
xlim([45 90]), ylim([-.05 .9])
xticks([50 60 ]); xticklabels([50 60 ])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
title('R-R EEG connectivity')
tau(2)=1/f0.c;

subplot(3,3,5)
5;
x=juv_exp_day-40; y=conn_high_RR(juv_id)'; f0 = fit(x,y,g);
for bird_n=1:length(juv_inds)
    % plotting
    i=bird_id(juv_inds(bird_n));
    p=plot(x(bird_n)+40,y(bird_n),'marker',bird_symbols{i},'markersize',5,'LineWidth', 1.5,'color',col(i,:)); hold on
end
plot(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',1.5);
xlim([45 90]), ylim([-.05 .9])
xticks([50 60 ]); xticklabels([50 60 ])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
tau(5)=1/f0.c;

subplot(3,3,8)
8;
x=juv_exp_day-40; y=conn_full_RR(juv_id)'; f0 = fit(x,y,g);
for bird_n=1:length(juv_inds)
    % plotting
    i=bird_id(juv_inds(bird_n));
    p=plot(x(bird_n)+40,y(bird_n),'marker',bird_symbols{i},'markersize',5,'LineWidth', 1.5,'color',col(i,:)); hold on
end
plot(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',1.5);
xlim([45 90]), ylim([-.05 .9])
xticks([50 60 ]); xticklabels([50 60 ])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
tau(8)=1/f0.c;


% plot for the L-R
subplot(3,3,3)
3;
x=juv_exp_day-40; y=conn_low_LR(juv_id)'; f0 = fit(x,y,g);
for bird_n=1:length(juv_inds)
    % plotting
    i=bird_id(juv_inds(bird_n));
    p=plot(x(bird_n)+40,y(bird_n),'marker',bird_symbols{i},'markersize',5,'LineWidth', 1.5,'color',col(i,:)); hold on
end
plot(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',1.5);
xlim([45 90]), ylim([-.05 .9])
xticks([50 60 ]); xticklabels([50 60 ])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
title('L-R EEG connectivity')
tau(3)=1/f0.c;

subplot(3,3,6)
6;
x=juv_exp_day-40; y=conn_high_LR(juv_id)'; f0 = fit(x,y,g);
for bird_n=1:length(juv_inds)
    % plotting
    i=bird_id(juv_inds(bird_n));
    p=plot(x(bird_n)+40,y(bird_n),'marker',bird_symbols{i},'markersize',5,'LineWidth', 1.5,'color',col(i,:)); hold on
end
plot(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',1.5);
xlim([45 90]), ylim([-.05 .9])
xticks([50 60 ]); xticklabels([50 60 ])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
tau(6)=1/f0.c;

subplot(3,3,9)
9;
x=juv_exp_day-40; y=conn_full_LR(juv_id)'; f0 = fit(x,y,g);
for bird_n=1:length(juv_inds)
    % plotting
    i=bird_id(juv_inds(bird_n));
    p=plot(x(bird_n)+40,y(bird_n),'marker',bird_symbols{i},'markersize',5,'LineWidth', 1.5,'color',col(i,:)); hold on
end
plot(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',1.5);
xlim([45 90]), ylim([-.05 .9])
xticks([50 60 ]); xticklabels([50 60 ])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
tau(9)=1/f0.c;


% adding linear regression line
% corr of connectivity with age, adding the regression line and statistical significance
bird_n=1:length(res);
juv_id=(bird_id(bird_n)==4 | bird_id(bird_n)==5 | bird_id(bird_n)==6 | bird_id(bird_n)==8); % id of all juveniles
clear juv_LLRRLR_corr_low juv_LLRRLR_corr_high  juv_LLRRLR_corr_full juv_exp_day
juv_n=1;
for bird_n=1:length(res)
    id=bird_id(bird_n);
    % only one of the parenthesis will be logical 1
    if id>=4 & id<=8 % if it is a juvenile
    juv_LLRRLR_corr_low(juv_n,:)=[conn_low_LL(bird_n) conn_low_RR(bird_n) conn_low_LR(bird_n)];  
    juv_LLRRLR_corr_high(juv_n,:)=[conn_high_LL(bird_n) conn_high_RR(bird_n) conn_high_LR(bird_n)];  
    juv_LLRRLR_corr_full(juv_n,:)=[conn_full_LL(bird_n) conn_full_RR(bird_n) conn_full_LR(bird_n)];  
    juv_exp_day(juv_n,1)=res(bird_n).dph; % age at day of recording
    juv_n=juv_n+1;
    end
end


% finding the fitting regression line
% for the LL subplot
x=juv_exp_day; y=juv_LLRRLR_corr_low(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile);
x=47:65; y=slope*x+intercept;
subplot(3,3,1); hold on
plot(x,y,':','color',1*[0 0 0],'linewidth',1.5);
text(56.3,.05,['r=' num2str(round(rr(1)*100)/100) '  ' '\tau=' num2str(round(tau(1)*10)/10)]);

x=juv_exp_day; y=juv_LLRRLR_corr_high(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(47:65); y=slope*x+intercept;
subplot(3,3,4); hold on
plot(x,y,':','color',1*[0 0 0],'linewidth',1.5);
text(56.3,.05,['r=' num2str(round(rr(4)*100)/100) '  ' '\tau=' num2str(round(tau(4)*10)/10)]);
 
x=juv_exp_day; y=juv_LLRRLR_corr_full(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(47:65); y=slope*x+intercept;
subplot(3,3,7); hold on
plot(x,y,':','color',1*[0 0 0],'linewidth',1.5);
text(56.3,.05,['r=' num2str(round(rr(7)*100)/100) '  ' '\tau=' num2str(round(tau(7)*10)/10)]);

% finding the fitting regression line
% for the RR subplot
x=juv_exp_day; y=juv_LLRRLR_corr_low(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(47:65); y=slope*x+intercept;
subplot(3,3,2); hold on
plot(x,y,':','color',1*[0 0 0],'linewidth',1.5);
text(56.3,.05,['r=' num2str(round(rr(2)*100)/100) '  ' '\tau=' num2str(round(tau(2)*10)/10)]);

x=juv_exp_day; y=juv_LLRRLR_corr_high(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(47:65); y=slope*x+intercept;
subplot(3,3,5); hold on
plot(x,y,':','color',1*[0 0 0],'linewidth',1.5);
text(56.3,.05,['r=' num2str(round(rr(5)*100)/100) '  ' '\tau=' num2str(round(tau(5)*10)/10)]);
 
x=juv_exp_day; y=juv_LLRRLR_corr_full(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(47:65); y=slope*x+intercept;
subplot(3,3,8); hold on
plot(x,y,':','color',1*[0 0 0],'linewidth',1.5);
text(56.3,.05,['r=' num2str(round(rr(8)*100)/100) '  ' '\tau=' num2str(round(tau(8)*10)/10)]);
xlabel('Age (dph)')

% finding the fitting regression line for the LR subplot
x=juv_exp_day; y=juv_LLRRLR_corr_low(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(47:65); y=slope*x+intercept;
subplot(3,3,3); hold on
plot(x,y,':','color',1*[0 0 0],'linewidth',1.5);
text(56.3,.05,['r=' num2str(round(rr(3)*100)/100) '  ' '\tau=' num2str(round(tau(3)*10)/10)]);

x=juv_exp_day; y=juv_LLRRLR_corr_high(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(47:65); y=slope*x+intercept;
subplot(3,3,6); hold on
plot(x,y,':','color',1*[0 0 0],'linewidth',1.5);
text(56.3,.05,['r=' num2str(round(rr(6)*100)/100) '  ' '\tau=' num2str(round(tau(6)*10)/10)]);
 
x=juv_exp_day; y=juv_LLRRLR_corr_full(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(47:65); y=slope*x+intercept;
subplot(3,3,9); hold on
plot(x,y,':','color',1*[0 0 0],'linewidth',1.5);
text(56.3,.05,['r=' num2str(round(rr(9)*100)/100) '  ' '\tau=' num2str(round(tau(9)*10)/10)]);

