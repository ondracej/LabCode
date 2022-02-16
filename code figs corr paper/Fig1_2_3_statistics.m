clear;
% data=load('G:\Hamed\zf\P1\labled sleep\batch_results1'); % the file containing the batch result of all birds
% res=data.res; % the variable containing the results

data=load('G:\Hamed\zf\P1\labled sleep\batch_results3with_dph_Fig_1_2_3'); % the file containing the batch result of all birds
res=data.res; % the variable containing the results

bird_names={'72-00','73-03','72-94','w0009','w0016','w0018','w0020','w0021','w0041','w0043'};
bird_symbols={'o','<','>','+','*','x','s','d','v','^'};
rng(355);
col_=.9*rand(10,3);
col_mask=[.5*ones(3,3); 1.2*ones(7,3)];
col=col_.*col_mask;
%  extracting the ID for each bird (1 to 8)
for bird_n=1:length(res)
    % finding the name of the bird
    bird_name_long=res(bird_n).bird; % like '72-94_08_09_2021'
    bird_name=bird_name_long(1:5); % like '72-94'
    
    % finding the bird index (lopping over number of birds)
    for i=1:length(bird_names)
        if strcmp(bird_names{i},bird_name)
            bird_id(bird_n)=i;
            break
        end
    end
end

%% figure for the mean of depth variable and the error bars
figure;
for bird_n=1:49
    % plotting
        i=bird_id(bird_n);
        err = res(bird_n).iqr_LH/2;
        x=res(bird_n).dph;
        y=res(bird_n).median_LH;
    if i<=3 % for adults
        plot( x+2*sum(bird_id<i)-500,y,'marker',bird_symbols{i},'color',col(i,:),'LineWidth',2); hold on
        errorbar(x+2*sum(bird_id<i)-500,y, err, 'color',[col(i,:) .2]);
    else  % for juveniles
        plot(x+2*sum(bird_id<i),y,'marker',bird_symbols{i},'color',col(i,:),'LineWidth',2); hold on
        errorbar(x+2*sum(bird_id<i),y, err, 'color',[col(i,:) .2]);
    end
end
ylim([0 260]); xlim([85 330]); 
xticks([150 240]);
xticklabels({'Juveniles','Adults'}) 
ylabel('Depth of Sleep')
% xticks([0 2]);  xticklabels({'Juveniles','Adults'});
title('Sleep depth index across nights');


%% figure for the mean of low band powers (1.5-8)
figure;
subplot(2,1,1)
for bird_n=1:49
    % plotting
        i=bird_id(bird_n);
        err = res(bird_n).iqr_L/2;
        x=res(bird_n).dph;
        y=res(bird_n).median_L;
    if i<=3 % for adults
        plot( x+2*sum(bird_id<i)-500,y,'marker',bird_symbols{i},'color',col(i,:),'LineWidth',2); hold on
        errorbar(x+2*sum(bird_id<i)-500,y, err, 'color',[col(i,:) .2]);
    else  % for juveniles
        plot(x+2*sum(bird_id<i),y,'marker',bird_symbols{i},'color',col(i,:),'LineWidth',2); hold on
        errorbar(x+2*sum(bird_id<i),y, err, 'color',[col(i,:) .2]);
    end
end
xlim([85 330]); ylim([0 .52]) 
xticks([150 240]);
xticklabels({'Juveniles','Adults'})
ylabel(' Power (normalized)');
% xticks([0 2]);  xticklabels({'Juveniles','Adults'});
title('1.5-8 Hz power across nights');

% figure for the mean of high band powers (30-49.5)
subplot(2,1,2)
for bird_n=1:49
    % plotting
        i=bird_id(bird_n);
        err = res(bird_n).iqr_H/2;
        x=res(bird_n).dph;
        y=res(bird_n).median_H;
    if i<=3 % for adults
        plot( x+2*sum(bird_id<i)-500,y,'marker',bird_symbols{i},'color',col(i,:),'LineWidth',2); hold on
        errorbar(x+2*sum(bird_id<i)-500,y, err, 'color',[col(i,:) .2]);
    else  % for juveniles
        plot(x+2*sum(bird_id<i),y,'marker',bird_symbols{i},'color',col(i,:),'LineWidth',2); hold on
        errorbar(x+2*sum(bird_id<i),y, err, 'color',[col(i,:) .2]);
    end
end
xlim([85 330])
ylim([0 .026])
xticks([150 240]);
xticklabels({'Juveniles','Adults'})
ylabel(' Power (normalized)');
% xticks([0 2]);  xticklabels({'Juveniles','Adults'});
title('30-50 Hz power across nights');

%% for the legends
figure
for k=1:length(bird_names)
    plot(1,k,'s','color',col(k,:),'markersize',10,'linewidth',2,'marker',bird_symbols{k}); hold on
end
legend(bird_names)
ylim([0 14])
%%
% figure for the mean local wave incidence for all nights and birds

figure;
for bird_n=1:length(res)-2
    % plotting
        i=bird_id(bird_n);
        var_=res(bird_n).local_wave_perSec_perChnl_mean; 
        err = std(var_(~isnan(var_)));
        x=res(bird_n).dph;
        y=mean(var_(~isnan(var_)));
    if i<=3 % for adults
        plot( x+2*sum(bird_id<i)-500,y,'marker',bird_symbols{i},'color',col(i,:),'LineWidth',2); hold on
        errorbar(x+2*sum(bird_id<i)-500,y, err, 'color',[col(i,:) .2]);
    else  % for juveniles
        plot(x+2*sum(bird_id<i),y,'marker',bird_symbols{i},'color',col(i,:),'LineWidth',2); hold on
        errorbar(x+2*sum(bird_id<i),y, err, 'color',[col(i,:) .2]);
    end
end
  xlim([40 350]) 
title('local wave incidence across nights');
xlabel ('age (dph)')
ylabel('local wave incidence (#/sec)')
%%
% statistics for figure 1,2
% statistical test for the median of sleep-depth variable
juv_inds=bird_id==4 | bird_id==5 | bird_id==6 | bird_id==8 ; % index to bird_id for juveniles
adu_inds=bird_id==1 | bird_id==2 | bird_id==3  ; % index to bird_id for juveniles
mean_median_depth_juv=mean([res(juv_inds).median_LH])
mean_median_depth_adult=mean([res(adu_inds).median_LH])

iqr_median_depth_juv=iqr([res(juv_inds).median_LH])
iqr_median_depth_adult=iqr([res(adu_inds).median_LH])

all_local_wave_chnls_juv=[res(juv_inds).local_wave_perSec_perChnl_mean];
mean_local_wave_juv=mean(all_local_wave_chnls_juv(~isnan(all_local_wave_chnls_juv)),'all')

all_local_wave_chnls_adu=[res(adu_inds).local_wave_perSec_perChnl_mean];
mean_local_wave_adu=mean(all_local_wave_chnls_adu(~isnan(all_local_wave_chnls_adu)),'all')

% statistical test between adult and juvenile group
[p,h]=ranksum( [res(juv_inds).local_wave_perSec_perChnl_mean], [res(adu_inds).local_wave_perSec_perChnl_mean] )
[p,h]=ranksum( [res(juv_inds).median_LH], [res(adu_inds).median_LH] )

mean_corr_local_wave_and_depth_juv=median([res(juv_inds).corr_local_wave_and_depth])
mean_corr_local_wave_and_depth_adu=median([res(adu_inds).corr_local_wave_and_depth])

iqr_corr_local_wave_and_depth_juv=iqr([res(juv_inds).corr_local_wave_and_depth])
iqr_corr_local_wave_and_depth_adu=iqr([res(adu_inds).corr_local_wave_and_depth])

%%  Fig. 3 plot of the inter/intra-hemispheric correlations during different stages in adult group
% for the adult
f_adult=figure; 
for bird_n=1:length(res)-2
    % plotting
    i=bird_id(bird_n);
    age=780*(i==1)+686*(i==2)+780*(i==3)+50*(i==4)+50*(i==5)+51*(i==6)+52*(i==8); % depending on the bird ID, only one of the parenthesis will ...
    % be logically correct. That 1, multiplied by the age of the
    % corresponding bird, gives the age of the bird.
    if i<=3 % for adults
        
        % LL corr
        subplot(1,3,1) %  SWS
        x=res(bird_n).dph;
        plot( (x-age),res(bird_n).LLRRLR_corr_SWS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  IS
        plot( (x-age)+30,res(bird_n).LLRRLR_corr_IS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  REM
        plot( (x-age)+60,res(bird_n).LLRRLR_corr_REM(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim(30*[-.2 2.8]);  ylabel('corr coef')
        xticks([0 1 2]*30);  xticklabels({'SWS','IS','REM'});
        title('Adult L-L EEG connectivity');
        
        % RR corr
        subplot(1,3,2) %  SWS
        plot( 0+(x-age),res(bird_n).LLRRLR_corr_SWS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  IS
        plot( 30+(x-age),res(bird_n).LLRRLR_corr_IS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  REM
        plot( 60+(x-age),res(bird_n).LLRRLR_corr_REM(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim(30*[-.2 2.8]);
        xticks([0 1 2]*30);  xticklabels({'SWS','IS','REM'});
        title('Adult R-R EEG connectivity');
        
        % RL corr
        subplot(1,3,3) %  SWS
        plot( 0+(x-age),res(bird_n).LLRRLR_corr_SWS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  IS
        plot( 30+(x-age),res(bird_n).LLRRLR_corr_IS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  REM
        plot( 60+(x-age),res(bird_n).LLRRLR_corr_REM(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim(30*[-.2 2.8]);
        xticks([0 1 2]*30);  xticklabels({'SWS','IS','REM'});
        title('Adult R-L EEG connectivity');
        
    end
end

% for the juveniles
f_juvenile=figure; 
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);

    if i>3 % for adults
    x=res(bird_n).dph;
    age=780*(i==1)+686*(i==2)+780*(i==3)+50*(i==4)+50*(i==5)+51*(i==6)+52*(i==8); % depending on the bird ID, only one of the parenthesis will ...
    % be logically correct. That 1, multiplied by the age of the
    % corresponding bird, gives the age of the bird.    
        % LL corr
        subplot(1,3,1) %  SWS
        plot( 0+(x-age),res(bird_n).LLRRLR_corr_SWS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  IS
        plot( 30+(x-age),res(bird_n).LLRRLR_corr_IS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  REM
        plot( 60+(x-age),res(bird_n).LLRRLR_corr_REM(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim(30*[-.2 2.8]); ylabel('corr coef')
        xticks(30*[0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Juvenile L-L EEG connectivity');
        
        % RR corr
        subplot(1,3,2) %  SWS
        plot( 0+(x-age),res(bird_n).LLRRLR_corr_SWS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  IS
        plot( 30+(x-age),res(bird_n).LLRRLR_corr_IS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  REM
        plot( 60+(x-age),res(bird_n).LLRRLR_corr_REM(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim(30*[-.2 2.8]);
        xticks(30*[0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Juvenile R-R EEG connectivity');
        
        % RL corr
        subplot(1,3,3) %  SWS
        plot( 0+(x-age),res(bird_n).LLRRLR_corr_SWS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  IS
        plot( 30+(x-age),res(bird_n).LLRRLR_corr_IS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  REM
        plot( 60+(x-age),res(bird_n).LLRRLR_corr_REM(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim(30*[-.2 2.8]);
        xticks(30*[0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Juvenile R-L EEG connectivity');
        
    end
end

%% test if the correlation between DOS and local wave density is significanto

bird_n=1:length(res);
juv_id=(bird_id(bird_n)==4 | bird_id(bird_n)==5 | bird_id(bird_n)==6 | bird_id(bird_n)==8); % id of all juveniles
juv_n=1; adult_n=1;
for bird_n=1:length(res)-2
    id=bird_id(bird_n);
    % only one of the parenthesis will be logical 1
    if id==4 | id==5 | id==6 | id==8 % if it is a juvenile
    dos_loc_wave_corrs_juv(juv_n)=res(juv_n).corr_local_wave_and_depth;
    juv_n=juv_n+1;
    elseif i<=3
    dos_loc_wave_corrs_adult(adult_n)=res(adult_n).corr_local_wave_and_depth;
    adult_n=adult_n+1;
    end
end
p = signrank(dos_loc_wave_corrs_adult)
p = signrank(dos_loc_wave_corrs_juv)

%% corr of connectivity with age, adding the regression line and statistical significance
% juvenule
bird_n=1:length(res)-2;
juv_id=(bird_id(bird_n)==4 | bird_id(bird_n)==5 | bird_id(bird_n)==6 | bird_id(bird_n)==8); % id of all juveniles
juv_n=1;
for bird_n=1:length(res)
    id=bird_id(bird_n);
    % only one of the parenthesis will be logical 1
    if id==4 | id==5 | id==6 | id==8 % if it is a juvenile
    dph0=780*(id==1)+686*(id==2)+780*(id==3)+50*(id==4)+50*(id==5)+51*(id==6)+52*(id==8); % depending on the bird ID, ...
    juv_LLRRLR_corr_SWS(juv_n,:)=res(bird_n).LLRRLR_corr_SWS;  
    juv_LLRRLR_corr_IS(juv_n,:)=res(bird_n).LLRRLR_corr_IS;  
    juv_LLRRLR_corr_REM(juv_n,:)=res(bird_n).LLRRLR_corr_REM;  
    juv_exp_day(juv_n,1)=res(bird_n).dph-dph0; % age at day of recording
    juv_n=juv_n+1;
    end
end
% LL, RR, and LR for SWS:
conn_SWS_LL=corrcoef(juv_exp_day,juv_LLRRLR_corr_SWS(:,1));
conn_SWS_RR=corrcoef(juv_exp_day,juv_LLRRLR_corr_SWS(:,2));
conn_SWS_LR=corrcoef(juv_exp_day,juv_LLRRLR_corr_SWS(:,3));

corr_SWS_LL=conn_SWS_LL(1,2)
corr_SWS_RR=conn_SWS_RR(1,2)
corr_SWS_LR=conn_SWS_LR(1,2)

% LL, RR, and LR for IS:
conn_IS_LL=corrcoef(juv_exp_day,juv_LLRRLR_corr_IS(:,1));
conn_IS_RR=corrcoef(juv_exp_day,juv_LLRRLR_corr_IS(:,2));
conn_IS_LR=corrcoef(juv_exp_day,juv_LLRRLR_corr_IS(:,3));

corr_IS_LL=conn_IS_LL(1,2)
corr_IS_RR=conn_IS_RR(1,2)
corr_IS_LR=conn_IS_LR(1,2)

% LL, RR, and LR for REM:
conn_REM_LL=corrcoef(juv_exp_day,juv_LLRRLR_corr_REM(:,1));
conn_REM_RR=corrcoef(juv_exp_day,juv_LLRRLR_corr_REM(:,2));
conn_REM_LR=corrcoef(juv_exp_day,juv_LLRRLR_corr_REM(:,3));

corr_REM_LL=conn_REM_LL(1,2)
corr_REM_RR=conn_REM_RR(1,2)
corr_REM_LR=conn_REM_LR(1,2)

% adult
clear  adult_LLRRLR_corr_SWS  adult_LLRRLR_corr_IS  adult_LLRRLR_corr_REM  adult_exp_day
bird_n=1:length(res);
adult_id=(bird_id(bird_n)==1 | bird_id(bird_n)==2 | bird_id(bird_n)==3); % id of all juveniles
adult_n=1;
for bird_n=1:length(res)
    id=bird_id(bird_n);
    % only one of the parenthesis will be logical 1
    if (id==1  & res(bird_n).bird(11)=='3') | id==2 | id==3 % if it is an adult
    dph0=780*(id==1)+686*(id==2)+780*(id==3)+50*(id==4)+50*(id==5)+51*(id==6)+52*(id==8); % depending on the bird ID, ...
    adult_LLRRLR_corr_SWS(adult_n,:)=res(bird_n).LLRRLR_corr_SWS;  
    adult_LLRRLR_corr_IS(adult_n,:)=res(bird_n).LLRRLR_corr_IS;  
    adult_LLRRLR_corr_REM(adult_n,:)=res(bird_n).LLRRLR_corr_REM;  
    adult_exp_day(adult_n,1)=res(bird_n).dph-dph0; % age at day of recording
    adult_n=adult_n+1;
    end
end
% LL, RR, and LR for SWS:
conn_SWS_LL=corrcoef(adult_exp_day,adult_LLRRLR_corr_SWS(:,1));
conn_SWS_RR=corrcoef(adult_exp_day,adult_LLRRLR_corr_SWS(:,2));
conn_SWS_LR=corrcoef(adult_exp_day,adult_LLRRLR_corr_SWS(:,3));

corr_SWS_LL=conn_SWS_LL(1,2)
corr_SWS_RR=conn_SWS_RR(1,2)
corr_SWS_LR=conn_SWS_LR(1,2)

% LL, RR, and LR for IS:
conn_IS_LL=corrcoef(adult_exp_day,adult_LLRRLR_corr_IS(:,1));
conn_IS_RR=corrcoef(adult_exp_day,adult_LLRRLR_corr_IS(:,2));
conn_IS_LR=corrcoef(adult_exp_day,adult_LLRRLR_corr_IS(:,3));

corr_IS_LL=conn_IS_LL(1,2)
corr_IS_RR=conn_IS_RR(1,2)
corr_IS_LR=conn_IS_LR(1,2)

% LL, RR, and LR for REM:
conn_REM_LL=corrcoef(adult_exp_day,adult_LLRRLR_corr_REM(:,1));
conn_REM_RR=corrcoef(adult_exp_day,adult_LLRRLR_corr_REM(:,2));
conn_REM_LR=corrcoef(adult_exp_day,adult_LLRRLR_corr_REM(:,3));

corr_REM_LL=conn_REM_LL(1,2)
corr_REM_RR=conn_REM_RR(1,2)
corr_REM_LR=conn_REM_LR(1,2)

% finding the fitting regression line
% for the LL subplot
x=adult_exp_day; y=adult_LLRRLR_corr_SWS(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_adult)
x=-1:1:16; y=slope*x+intercept;
subplot(1,3,1); hold on
plot(x,y,'--','color',.3*[1 1 1]);
 
x=adult_exp_day; y=adult_LLRRLR_corr_IS(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_adult)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,1); hold on
plot(x+30,y,'--','color',.3*[1 1 1]);
 
x=adult_exp_day; y=adult_LLRRLR_corr_REM(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_adult)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,1); hold on
plot(x+60,y,'--','color',.3*[1 1 1]);
 
% finding the fitting regression line
% for the RR subplot
x=adult_exp_day; y=adult_LLRRLR_corr_SWS(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_adult)
x=-1:1:16; y=slope*x+intercept;
subplot(1,3,2); hold on
plot(x,y,'--','color',.3*[1 1 1]);
 
x=adult_exp_day; y=adult_LLRRLR_corr_IS(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_adult)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,2); hold on
plot(x+30,y,'--','color',.3*[1 1 1]);
 
x=adult_exp_day; y=adult_LLRRLR_corr_REM(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_adult)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,2); hold on
plot(x+60,y,'--','color',.3*[1 1 1]);


% finding the fitting regression line
% for the LR subplot
x=adult_exp_day; y=adult_LLRRLR_corr_SWS(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_adult)
x=-1:1:16; y=slope*x+intercept;
subplot(1,3,3); hold on
plot(x,y,'--','color',.3*[1 1 1]);
 
x=adult_exp_day; y=adult_LLRRLR_corr_IS(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_adult)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,3); hold on
plot(x+30,y,'--','color',.3*[1 1 1]);
 
x=adult_exp_day; y=adult_LLRRLR_corr_REM(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_adult)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,3); hold on
plot(x+60,y,'--','color',.3*[1 1 1]);

% for juveniles
% finding the fitting regression line
% for the LL subplot
x=juv_exp_day; y=juv_LLRRLR_corr_SWS(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=-1:1:16; y=slope*x+intercept;
subplot(1,3,1); hold on
plot(x,y,'--','color',.3*[1 1 1]);
 
x=juv_exp_day; y=juv_LLRRLR_corr_IS(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,1); hold on
plot(x+30,y,'--','color',.3*[1 1 1]);
 
x=juv_exp_day; y=juv_LLRRLR_corr_REM(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,1); hold on
plot(x+60,y,'--','color',.3*[1 1 1]);
 
% finding the fitting regression line
% for the RR subplot
x=juv_exp_day; y=juv_LLRRLR_corr_SWS(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=-1:1:16; y=slope*x+intercept;
subplot(1,3,2); hold on
plot(x,y,'--','color',.3*[1 1 1]);
 
x=juv_exp_day; y=juv_LLRRLR_corr_IS(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,2); hold on
plot(x+30,y,'--','color',.3*[1 1 1]);
 
x=juv_exp_day; y=juv_LLRRLR_corr_REM(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,2); hold on
plot(x+60,y,'--','color',.3*[1 1 1]);


% finding the fitting regression line
% for the LR subplot
x=juv_exp_day; y=juv_LLRRLR_corr_SWS(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=-1:1:16; y=slope*x+intercept;
subplot(1,3,3); hold on
plot(x,y,'--','color',.3*[1 1 1]);
 
x=juv_exp_day; y=juv_LLRRLR_corr_IS(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,3); hold on
plot(x+30,y,'--','color',.3*[1 1 1]);
 
x=juv_exp_day; y=juv_LLRRLR_corr_REM(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(-1:1:16); y=slope*x+intercept;
subplot(1,3,3); hold on
plot(x+60,y,'--','color',.3*[1 1 1]);
%% statistical tests for figure 3: connectivities across the hemispheres 

% 2-way ANOVA for the difference in connectivity across the hemispheres
% row factor is sleep stage (SWS, IS, REM), the column factor is
% hemispheric side for connectivity (LL, RR, LR)
% for adult
% formatting data for anova2
corr_SWS=[res(adu_inds).LLRRLR_corr_SWS];
corr_IS=[res(adu_inds).LLRRLR_corr_IS];
corr_REM=[res(adu_inds).LLRRLR_corr_REM];

anova_input=[corr_SWS(1:3:end)',...
    corr_SWS(2:3:end)',...
    corr_SWS(3:3:end)';...
    corr_IS(1:3:end)',...
    corr_IS(2:3:end)',...
    corr_IS(3:3:end)';...
    corr_REM(1:3:end)',...
    corr_REM(2:3:end)',...
    corr_REM(3:3:end)'];

[~,~,stats] = anova2(anova_input,sum(adu_inds));
c = multcompare(stats)

% for juveniles
% formatting data for anova2
corr_SWS=[res(juv_inds).LLRRLR_corr_SWS];
corr_IS=[res(juv_inds).LLRRLR_corr_IS];
corr_REM=[res(juv_inds).LLRRLR_corr_REM];

anova_input=[corr_SWS(1:3:end)',...
    corr_SWS(2:3:end)',...
    corr_SWS(3:3:end)';...
    corr_IS(1:3:end)',...
    corr_IS(2:3:end)',...
    corr_IS(3:3:end)';...
    corr_REM(1:3:end)',...
    corr_REM(2:3:end)',...
    corr_REM(3:3:end)'];

[~,~,stats] = anova2(anova_input,sum(juv_inds));
c = multcompare(stats)

%% ANOVA2 for checking a possible significant difference in connectivity across the stages
% for adult
% reformatting data for anova2
corr_SWS=[res(adu_inds).LLRRLR_corr_SWS];
corr_IS=[res(adu_inds).LLRRLR_corr_IS];
corr_REM=[res(adu_inds).LLRRLR_corr_REM];

anova_input=[
    corr_SWS(1:3:end),...
    corr_SWS(2:3:end),...
    corr_SWS(3:3:end);...
    corr_IS(1:3:end),...
    corr_IS(2:3:end),...
    corr_IS(3:3:end);...
    corr_REM(1:3:end),...
    corr_REM(2:3:end),...
    corr_REM(3:3:end)]';

[~,~,stats] = anova2(anova_input,sum(adu_inds));
c = multcompare(stats)

% for juveniles
% reformatting data for anova2
corr_SWS=[res(juv_inds).LLRRLR_corr_SWS];
corr_IS=[res(juv_inds).LLRRLR_corr_IS];
corr_REM=[res(juv_inds).LLRRLR_corr_REM];

anova_input=[
    corr_SWS(1:3:end),...
    corr_SWS(2:3:end),...
    corr_SWS(3:3:end);...
    corr_IS(1:3:end),...
    corr_IS(2:3:end),...
    corr_IS(3:3:end);...
    corr_REM(1:3:end),...
    corr_REM(2:3:end),...
    corr_REM(3:3:end)]';

[~,~,stats] = anova2(anova_input,sum(juv_inds));
c = multcompare(stats)

%% to find which channels have changed mostly during the recording nights
loaded_res=load('G:\Hamed\zf\P1\labled sleep\batch_corr_mat_change.mat');
res=loaded_res.res;
figure
sub_n=1; % subplot square number, starting from 1, incresing by 1 in each step
for k=1:2:length(res)-1
    corr_mat_diff_SWS=res(k+1).matrix_corr_SWS-res(k).matrix_corr_SWS;
    corr_mat_diff_IS=res(k+1).matrix_corr_IS-res(k).matrix_corr_IS;
    corr_mat_diff_REM=res(k+1).matrix_corr_REM-res(k).matrix_corr_REM;
    valid_chnls=setdiff(1:16,res(k).noisy_chnls);
    all_3_matrices=[corr_mat_diff_SWS(valid_chnls,valid_chnls) corr_mat_diff_IS(valid_chnls,valid_chnls) ...
        corr_mat_diff_REM(valid_chnls,valid_chnls)];
    max_col=max(all_3_matrices,[],'all');
    min_col=min(all_3_matrices,[],'all');
    subplot(length(res)/2,3,sub_n) 
    imagesc(flipud(corr_mat_diff_SWS),[min_col max_col]); axis square; sub_n=sub_n+1; title(res(k).bird(1:5)); xticks([]); yticks([]);
    subplot(length(res)/2,3,sub_n) 
    imagesc(flipud(corr_mat_diff_IS),[min_col max_col]); axis square; sub_n=sub_n+1; xticks([]); yticks([]);
    subplot(length(res)/2,3,sub_n) 
    imagesc(flipud(corr_mat_diff_REM),[min_col max_col]); axis square; sub_n=sub_n+1; colorbar; xticks([]); yticks([]);
    
end

%% local wave incidence for the adults and juvenile mapped on the electrode
% sites
figure
% load adult template
image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; 
im=imread(image_layout);
im1=.6*double(rgb2gray(imresize(im,.3)));
subplot(1,2,1)
imshow(int8(im1)); hold on
% [x1,y1]=ginput(16);
% xy_adult(:,1)=x1; xy_adult(:,2)=y1;
% load juvenile template
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; 
im=imread(image_layout);
im1=.6*double(rgb2gray(imresize(im,.3)));
subplot(1,2,2)
imshow(int8(im1)); hold on
% [x1,y1]=ginput(16);
% xy_juv(:,1)=x1; xy_juv(:,2)=y1;

cm=flipud(autumn(100)); % colormap
adult_count=zeros(16,1); juv_count=zeros(16,1);
adult_sum=zeros(16,1); juv_sum=zeros(16,1);
for bird_n=1:length(res)
        i=bird_id(bird_n);
        local_wave_per_chnl = res(bird_n).local_wave_perSec_perChnl_mean;
        nans=isnan(local_wave_per_chnl);
        local_wave_per_chnl(nans)=zeros(1,sum(nans));
    if i<=3 % for adults
        adult_sum=adult_sum+local_wave_per_chnl;
        adult_count=adult_count+~nans;
    else  % for juveniles
        juv_sum=juv_sum+local_wave_per_chnl;
        juv_count=juv_count+~nans;
    end
end
adult_mean=adult_sum./adult_count;
juv_mean=juv_sum./juv_count;
all_birds_mean=[adult_mean; juv_mean];
subplot(1,2,1)
for ch=1:length(juv_count) % number of channels
    rel_val=(adult_mean(ch)-min(all_birds_mean))/range(all_birds_mean);
    scatter1 = scatter(xy_adult(ch,1),xy_adult(ch,2),300,'o','MarkerFaceColor',...
        cm(ceil(rel_val*100+eps),:),'MarkerEdgeColor',cm(ceil(rel_val*100+eps),:));
    scatter1.MarkerFaceAlpha = 1; scatter1.MarkerEdgeAlpha =.9;
    hold on
end
set(gcf, 'Position',[200 , 200, 600, 500]);

subplot(1,2,2)
for ch=1:length(juv_count) % number of channels
    rel_val=(juv_mean(ch)-min(juv_mean))/range(all_birds_mean);
    scatter1 = scatter(xy_juv(ch,1),xy_juv(ch,2),300,'o','MarkerFaceColor',...
        cm(ceil(rel_val*100+eps),:),'MarkerEdgeColor',cm(ceil(rel_val*100+eps),:));
    scatter1.MarkerFaceAlpha = 1; scatter1.MarkerEdgeAlpha =.9;
    hold on
end
set(gcf, 'Position',[200 , 200, 600, 500]);

%% sleep depth per channel for the adults and juvenile mapped on the electrode
% sites
figure
% load adult template
image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; 
im=imread(image_layout);
im1=.6*double(rgb2gray(imresize(im,.3)));
subplot(1,2,1)
imshow(int8(im1)); hold on
% [x1,y1]=ginput(16);
% xy_adult(:,1)=x1; xy_adult(:,2)=y1;
% load juvenile template
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; 
im=imread(image_layout);
im1=.6*double(rgb2gray(imresize(im,.3)));
subplot(1,2,2)
imshow(int8(im1)); hold on
% [x1,y1]=ginput(16);
% xy_juv(:,1)=x1; xy_juv(:,2)=y1;

cm=flipud(autumn(100)); % colormap
adult_count=zeros(16,1); juv_count=zeros(16,1);
adult_sum=zeros(16,1); juv_sum=zeros(16,1);
for bird_n=1:length(res)
        i=bird_id(bird_n);
        sleep_depth_per_chnl = res(bird_n).median_LH_per_chnl;
        nans=isnan(sleep_depth_per_chnl);
        sleep_depth_per_chnl(nans)=zeros(1,sum(nans));
    if i<=3 % for adults
        adult_sum=adult_sum+sleep_depth_per_chnl;
        adult_count=adult_count+~nans;
    else  % for juveniles
        juv_sum=juv_sum+sleep_depth_per_chnl;
        juv_count=juv_count+~nans;
    end
end
adult_mean=adult_sum./adult_count;
juv_mean=juv_sum./juv_count;
all_birds_mean=[adult_mean; juv_mean];
subplot(1,2,1)
for ch=1:length(juv_count) % number of channels
    rel_val=(adult_mean(ch)-min(all_birds_mean))/range(all_birds_mean);
    scatter1 = scatter(xy_adult(ch,1),xy_adult(ch,2),300,'o','MarkerFaceColor',...
        cm(ceil(rel_val*100+eps),:),'MarkerEdgeColor',cm(ceil(rel_val*100+eps),:));
    scatter1.MarkerFaceAlpha = 1; scatter1.MarkerEdgeAlpha =.9;
    hold on
end
set(gcf, 'Position',[200 , 200, 600, 500]);

subplot(1,2,2)
for ch=1:length(juv_count) % number of channels
    rel_val=(juv_mean(ch)-min(juv_mean))/range(all_birds_mean);
    scatter1 = scatter(xy_juv(ch,1),xy_juv(ch,2),300,'o','MarkerFaceColor',...
        cm(ceil(rel_val*100+eps),:),'MarkerEdgeColor',cm(ceil(rel_val*100+eps),:));
    scatter1.MarkerFaceAlpha = 1; scatter1.MarkerEdgeAlpha =.9;
    hold on
end
set(gcf, 'Position',[200 , 200, 600, 500]);
