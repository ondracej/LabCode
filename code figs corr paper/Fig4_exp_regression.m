%%
clc;
% for the juveniles
f_juvenile=figure;
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    x=res(bird_n).dph;
%     age=780*(i==1)+686*(i==2)+780*(i==3)+50*(i==4)+51*(i==5)+51*(i==6)+54*(i==7)+52*(i==8)+83*(i==9)+69*(i==10); % depending on the bird ID, only one of the parenthesis will ...
    % be logically correct. That 1, multiplied by the age of the
    % corresponding bird, gives the age of the bird.
  
    age(bird_n)=x;
    LLSWS(bird_n)=res(bird_n).LLRRLR_corr_SWS(1);
    LLIS(bird_n)=res(bird_n).LLRRLR_corr_IS(1);
    LLREM(bird_n)=res(bird_n).LLRRLR_corr_REM(1);
    
    RRSWS(bird_n)=res(bird_n).LLRRLR_corr_SWS(2);
    RRIS(bird_n)=res(bird_n).LLRRLR_corr_IS(2);
    RRREM(bird_n)=res(bird_n).LLRRLR_corr_REM(2);
    
    LRSWS(bird_n)=res(bird_n).LLRRLR_corr_SWS(3);
    LRIS(bird_n)=res(bird_n).LLRRLR_corr_IS(3);
    LRREM(bird_n)=res(bird_n).LLRRLR_corr_REM(3);
end

%% curve fitting
fo = fitoptions('Method','NonlinearLeastSquares','Lower',[.55,.2,.05],'Upper',[1.5,1,0.10]);
g = fittype('a-b*exp(-c*x)','options',fo);
bird_symbols={'o','<','>','+','*','x','s','d','v','^'};

f_juvenile=figure
% color code for birds
rng(355);
col_=.9*rand(10,3);
col_mask=[.5*ones(3,3); 1.1*ones(7,3)];
col=col_.*col_mask;

xx=7:1000;
% plot for the L-L
subplot(3,3,1)
x=age'-40; y=LLSWS'; f0 = fit(x,y,g)
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    p=semilogx(x(bird_n)+40,y(bird_n),'marker','.','markersize',16,'color',col(i,:)); hold on
end
semilogx(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',2);
xlim([45 1000]), ylim([0 1]); 
xticks([50 100 1000]); xticklabels([50 100 1000])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
title('L-L EEG connectivity')
ylabel('SWS')
tau(1)=1/f0.c;

subplot(3,3,4)
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    p=semilogx(x(bird_n)+40,y(bird_n),'marker','.','markersize',16,'color',col(i,:)); hold on
end
x=age'-40; y=LLIS'; f0 = fit(x,y,g)
semilogx(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',2);
xlim([45 1000]), ylim([0 1]); 
xticks([50 100 1000]); xticklabels([50 100 1000])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
ylabel('IS')

subplot(3,3,7)
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    p=semilogx(x(bird_n)+40,y(bird_n),'marker','.','markersize',16,'color',col(i,:)); hold on
end
x=age'-40; y=LLREM'; f0 = fit(x,y,g)
semilogx(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',2);
xlim([45 1000]), ylim([0 1]); 
xticks([50 100 1000]); xticklabels([50 100 1000])
yticks([0 .2 .4 .6 .8 1]); 
ylabel('REM')
xlabel('Age (dph)')

% plot for the R-R
subplot(3,3,2)
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    p=semilogx(x(bird_n)+40,y(bird_n),'marker','.','markersize',16,'color',col(i,:)); hold on
end
x=age'-40; y=RRSWS'; f0 = fit(x,y,g)
semilogx(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',2);
xlim([45 1000]), ylim([0 1]); 
xticks([50 100 1000]); xticklabels([50 100 1000])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
title('R-R EEG connectivity')

subplot(3,3,5)
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    p=semilogx(x(bird_n)+40,y(bird_n),'marker','.','markersize',16,'color',col(i,:)); hold on
end
x=age'-40; y=RRIS'; f0 = fit(x,y,g)
semilogx(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',2);
xlim([45 1000]), ylim([0 1]); 
xticks([50 100 1000]); xticklabels([50 100 1000])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 

subplot(3,3,8)
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    p=semilogx(x(bird_n)+40,y(bird_n),'marker','.','markersize',16,'color',col(i,:)); hold on
end
x=age'-40; y=RRREM'; f0 = fit(x,y,g)
semilogx(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',2);
xlim([45 1000]), ylim([0 1]); 
xticks([50 100 1000]); xticklabels([50 100 1000])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
xlabel('Age (dph)')


% plot for the L-R
subplot(3,3,3)
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    p=semilogx(x(bird_n)+40,y(bird_n),'marker','.','markersize',16,'color',col(i,:)); hold on
end
x=age'-40; y=LRSWS'; f0 = fit(x,y,g)
semilogx(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',2);
xlim([45 1000]), ylim([0 1]); 
xticks([50 100 1000]); xticklabels([50 100 1000])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
title('L-R EEG connectivity')

subplot(3,3,6)
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    p=semilogx(x(bird_n)+40,y(bird_n),'marker','.','markersize',16,'color',col(i,:)); hold on
end
x=age'-40; y=LRIS'; f0 = fit(x,y,g)
semilogx(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',2);
xlim([45 1000]), ylim([0 1]); 
xticks([50 100 1000]); xticklabels([50 100 1000])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 

subplot(3,3,9)
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    p=semilogx(x(bird_n)+40,y(bird_n),'marker','.','markersize',16,'color',col(i,:)); hold on
end
x=age'-40; y=LRREM'; f0 = fit(x,y,g)
semilogx(xx+40,f0(xx),'-','color',.4*[1 1 1] ,'linewidth',2);
xlim([45 1000]), ylim([0 1]); 
xticks([50 100 1000]); xticklabels([50 100 1000])
yticks([0 .2 .4 .6 .8 1]); yticklabels([0 .2 .4 .6 .8 1]) 
xlabel('Age (dph)')


% adding linear regression line
% corr of connectivity with age, adding the regression line and statistical significance
% juvenule
bird_n=1:length(res);
juv_id=(bird_id(bird_n)==4 | bird_id(bird_n)==5 | bird_id(bird_n)==6 | bird_id(bird_n)==8); % id of all juveniles
clear juv_LLRRLR_corr_SWS juv_LLRRLR_corr_IS  juv_LLRRLR_corr_REM juv_exp_day
juv_n=1;
for bird_n=1:length(res)
    id=bird_id(bird_n);
    % only one of the parenthesis will be logical 1
    if id>=4 & id<=8 % if it is a juvenile
    juv_LLRRLR_corr_SWS(juv_n,:)=res(bird_n).LLRRLR_corr_SWS;  
    juv_LLRRLR_corr_IS(juv_n,:)=res(bird_n).LLRRLR_corr_IS;  
    juv_LLRRLR_corr_REM(juv_n,:)=res(bird_n).LLRRLR_corr_REM;  
    juv_exp_day(juv_n,1)=res(bird_n).dph; % age at day of recording
    juv_n=juv_n+1;
    end
end


% for juveniles
% finding the fitting regression line
% for the LL subplot
x=juv_exp_day; y=juv_LLRRLR_corr_SWS(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=50:78; y=slope*x+intercept;
subplot(3,3,1); hold on
semilogx(x,y,':','color',1*[1 .7 .4],'linewidth',2.5);
text(100,.1,['r=' num2str(round(cov_xy(2,1)*100)/100) '  ' '\tau=' num2str(round(tau(1)*100)/100)]);
x=juv_exp_day; y=juv_LLRRLR_corr_IS(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(50:78); y=slope*x+intercept;
subplot(3,3,4); hold on
semilogx(x,y,':','color',1*[1 .7 .4],'linewidth',2.5);
 
x=juv_exp_day; y=juv_LLRRLR_corr_REM(:,1);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(50:78); y=slope*x+intercept;
subplot(3,3,7); hold on
semilogx(x,y,':','color',1*[1 .7 .4],'linewidth',2.5);
 
% finding the fitting regression line
% for the RR subplot
x=juv_exp_day; y=juv_LLRRLR_corr_SWS(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(50:78); y=slope*x+intercept;
subplot(3,3,2); hold on
semilogx(x,y,':','color',1*[1 .7 .4],'linewidth',2.5);
 
x=juv_exp_day; y=juv_LLRRLR_corr_IS(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(50:78); y=slope*x+intercept;
subplot(3,3,5); hold on
semilogx(x,y,':','color',1*[1 .7 .4],'linewidth',2.5);
 
x=juv_exp_day; y=juv_LLRRLR_corr_REM(:,2);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(50:78); y=slope*x+intercept;
subplot(3,3,8); hold on
semilogx(x,y,':','color',1*[1 .7 .4],'linewidth',2.5);


% finding the fitting regression line
% for the LR subplot
x=juv_exp_day; y=juv_LLRRLR_corr_SWS(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(50:78); y=slope*x+intercept;
subplot(3,3,3); hold on
semilogx(x,y,':','color',1*[1 .7 .4],'linewidth',2.5);
 
x=juv_exp_day; y=juv_LLRRLR_corr_IS(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(50:78); y=slope*x+intercept;
subplot(3,3,6); hold on
semilogx(x,y,':','color',1*[1 .7 .4],'linewidth',2.5);
 
x=juv_exp_day; y=juv_LLRRLR_corr_REM(:,3);
cov_xy=cov(x,y);
slope=cov_xy(2,1)/var(x);
intercept=mean(y)-slope*mean(x);
% adding the regression line to the figures
figure(f_juvenile)
x=(50:78); y=slope*x+intercept;
subplot(3,3,9); hold on
semilogx(x,y,':','color',1*[1 .7 .4],'linewidth',2.5);