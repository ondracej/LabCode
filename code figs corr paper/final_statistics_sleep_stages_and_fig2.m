clear;
stage_percentage_adult=[];
stage_percentage_juvenile=[];
juvs=1; % counter
aduls=1;
sex=[];
path_directory='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper'; % directory where stats of each bird is saved
all_files=ls(path_directory);
for k=1:length(all_files)
    filename_=all_files(k,:);
    fname=strtrim(filename_);
    if length(fname)>22 & fname(1:23)==    "stage_stat_sleep_stages"
        fname(25:29)
        if strcmp(fname(25:29),'w0016') | strcmp(fname(25:29),'w0018') | strcmp(fname(25:29),'w0021')
            sex(aduls+juvs-1)=0;
        else
            sex(aduls+juvs-1)=1;
        end
        load(fname)
        if  fname(25)=='w' % for juveniles
            stage_percentage_juvenile.REM(juvs,:)=stage_percentage.REM;
            stage_percentage_juvenile.SWS(juvs,:)=stage_percentage.SWS;
            stage_percentage_juvenile.IS(juvs,:)=stage_percentage.IS;
            stage_percentage_juvenile.Wake(juvs,:)=stage_percentage.Wake;
            juvs=juvs+1;
            
        else % for adults
            stage_percentage_adult.REM(aduls,:)=stage_percentage.REM;
            stage_percentage_adult.SWS(aduls,:)=stage_percentage.SWS;
            stage_percentage_adult.IS(aduls,:)=stage_percentage.IS;
            stage_percentage_adult.Wake(aduls,:)=stage_percentage.Wake;
            aduls=aduls+1;
        end
    end
end
%%
figure
subplot(3,1,1) % REM
mean_adult=mean(stage_percentage_adult.REM);
ste_adult=std(stage_percentage_adult.REM)/sqrt(size(stage_percentage_adult.REM,1));
errorbar(.5:11.5,mean_adult,ste_adult,'color',[.5 .5 1],'linewidth',1.5); hold on

mean_juvenile=mean(stage_percentage_juvenile.REM);
ste_juvenile=std(stage_percentage_juvenile.REM)/sqrt(size(stage_percentage_juvenile.REM,1));
errorbar(.5:11.5,mean_juvenile,ste_juvenile,'color',[1 .5 .5],'linewidth',1.5); hold on
ylabel('REM (%)')
legend('adult','juvenile')

subplot(3,1,2) % SWS
mean_adult=mean(stage_percentage_adult.SWS);
ste_adult=std(stage_percentage_adult.SWS)/sqrt(size(stage_percentage_adult.SWS,1));
errorbar(.5:11.5,mean_adult,ste_adult,'color',[.5 .5 1],'linewidth',1.5); hold on

mean_juvenile=mean(stage_percentage_juvenile.SWS);
ste_juvenile=std(stage_percentage_juvenile.SWS)/sqrt(size(stage_percentage_juvenile.SWS,1));
errorbar(.5:11.5,mean_juvenile,ste_juvenile,'color',[1 .5 .5],'linewidth',1.5); hold on
ylabel('% SWS')

subplot(3,1,3) % IS
mean_adult=mean(stage_percentage_adult.IS);
ste_adult=std(stage_percentage_adult.IS)/sqrt(size(stage_percentage_adult.IS,1));
errorbar(.5:11.5,mean_adult,ste_adult,'color',[.5 .5 1],'linewidth',1.5); hold on

mean_juvenile=mean(stage_percentage_juvenile.IS);
ste_juvenile=std(stage_percentage_juvenile.IS)/sqrt(size(stage_percentage_juvenile.IS,1));
errorbar(.5:11.5,mean_juvenile,ste_juvenile,'color',[1 .5 .5],'linewidth',1.5); hold on
ylabel('% IS')

% stats
mean_REM_adult=mean(mean(stage_percentage_adult.REM))
sd_REM_adult=std(mean(stage_percentage_adult.REM,2))

mean_SWS_adult=mean(mean(stage_percentage_adult.SWS))
sd_SWS_adult=std(mean(stage_percentage_adult.SWS,2))

mean_IS_adult=mean(mean(stage_percentage_adult.IS))
sd_IS_adult=std(mean(stage_percentage_adult.IS,2))


mean_REM_juvenile=mean(mean(stage_percentage_juvenile.REM))
sd_REM_juvenile=std(mean(stage_percentage_juvenile.REM,2))

mean_SWS_juvenile=mean(mean(stage_percentage_juvenile.SWS))
sd_SWS_juvenile=std(mean(stage_percentage_juvenile.SWS,2))

mean_IS_juvenile=mean(mean(stage_percentage_juvenile.IS))
sd_IS_juvenile=std(mean(stage_percentage_juvenile.IS,2))

% anovan
REMs=[mean(stage_percentage_adult.REM,2); mean(stage_percentage_juvenile.REM,2)];
age=[zeros(size(mean(stage_percentage_adult.REM,2))); ones(size(mean(stage_percentage_juvenile.REM,2)))];
[p,~,stats] = anovan(REMs,{age,sex})
SWSs=[mean(stage_percentage_adult.SWS,2); mean(stage_percentage_juvenile.SWS,2)];
age=[zeros(size(mean(stage_percentage_adult.SWS,2))); ones(size(mean(stage_percentage_juvenile.SWS,2)))];
[p,~,stats] = anovan(SWSs,{age,sex})
ISs=[mean(stage_percentage_adult.IS,2); mean(stage_percentage_juvenile.IS,2)];
age=[zeros(size(mean(stage_percentage_adult.IS,2))); ones(size(mean(stage_percentage_juvenile.IS,2)))];
[p,~,stats] = anovan(ISs,{age,sex})

%% figure
figure
subplot(3,1,1)
data_to_plot=mean(stage_percentage_juvenile.SWS);
plot(-1+.2*randn(1,length(data_to_plot)), data_to_plot, '.','markersize',20,'color',[1 .4 .4 .5]); hold on
data_to_plot=mean(stage_percentage_adult.SWS);
plot(1+.2*randn(1,length(data_to_plot)), data_to_plot, '.','markersize',20,'color',[.4 .4 1 .5]);
xticks([-1 1]); xticklabels({'jvnl','adlt'});
xlim([-1.5 1.5])
ylabel('SWS (%)')

subplot(3,1,2)
data_to_plot=mean(stage_percentage_juvenile.REM);
plot(-1+.2*randn(1,length(data_to_plot)), data_to_plot, '.','markersize',20,'color',[1 .4 .4 .5]); hold on
data_to_plot=mean(stage_percentage_adult.REM);
plot(1+.2*randn(1,length(data_to_plot)), data_to_plot, '.','markersize',20,'color',[.4 .4 1 .5]);
xticks([-1 1]); xticklabels({'jvnl','adlt'});
xlim([-1.5 1.5])
ylabel('REM (%)')

subplot(3,1,3)
data_to_plot=mean(stage_percentage_juvenile.IS);
plot(-1+.2*randn(1,length(data_to_plot)), data_to_plot, '.','markersize',20,'color',[1 .4 .4 .5]); hold on
data_to_plot=mean(stage_percentage_adult.IS);
plot(1+.2*randn(1,length(data_to_plot)), data_to_plot, '.','markersize',20,'color',[.4 .4 1 .5]);
xticks([-1 1]); xticklabels({'jvnl','adlt'});
xlim([-1.5 1.5])
ylabel('IS (%)')

%% durations
clear;
for hour=1:12
stage_duration_adult.REM{hour}=[];
stage_duration_juvenile.REM{hour}=[];
stage_duration_adult.SWS{hour}=[];
stage_duration_juvenile.SWS{hour}=[]; 
stage_duration_adult.IS{hour}=[];
stage_duration_juvenile.IS{hour}=[];
stage_duration_adult.Wake{hour}=[];
stage_duration_juvenile.Wake{hour}=[];
end

bouts_REM_all=[];
bouts_SWS_all=[];
bouts_IS_all=[];
sex_REM=[]; % 0 for male , 1 for any female
sex_SWS=[]; % 0 for male , 1 for any female
sex_IS=[]; % 0 for male , 1 for any female
age_REM=[]; % 0 for juv , 1 for any adult REM
age_SWS=[]; % 0 for juv , 1 for any adult REM
age_IS=[]; % 0 for juv , 1 for any adult REM

aduls=0;
juvs=0;
path_directory='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper'; % directory where stats of each bird is saved
all_files=ls(path_directory);
for k=1:length(all_files)
    filename_=all_files(k,:);
    fname=strtrim(filename_);
    if length(fname)>22 & fname(1:23)==    "stage_stat_sleep_stages"
        load(fname)
        
%%%%%%%%%%%%%%%%%%% for the ANOVA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % counting the bouts of each stage for the ANOVA labels for sex and age
        % take the bout lengths
        bouts_REM=[]; 
        bouts_SWS=[];
        bouts_IS=[];
        for hour=1:12
            bouts_REM=[bouts_REM stage_duration.REM{1,hour}];
            bouts_SWS=[bouts_SWS stage_duration.SWS{1,hour}];
            bouts_IS=[bouts_REM stage_duration.IS{1,hour}];
        end
        bouts_REM_all=[bouts_REM_all mean(bouts_REM)];
        bouts_SWS_all=[bouts_SWS_all  mean(bouts_SWS)];
        bouts_IS_all=[bouts_IS_all  mean(bouts_IS)];

        % determine sex labels
        if strcmp(fname(25:29),'w0016') | strcmp(fname(25:29),'w0018') | strcmp(fname(25:29),'w0021')
            sex_REM=[sex_REM 1]; % 1 for females
            sex_SWS=[sex_SWS 1];
            sex_IS=[sex_IS 1];
            
        else
            sex_REM=[sex_REM 0]; % 0 for males
            sex_SWS=[sex_SWS 0];
            sex_IS=[sex_IS 0];
        end
        % determine age labels
        if  fname(25)=='w' % for juveniles
            age_REM=[age_REM 0];
            age_SWS=[age_SWS 0];
            age_IS=[age_IS 0];
            
        else % for adults
            age_REM=[age_REM 1];
            age_SWS=[age_SWS 1];
            age_IS=[age_IS 1];
            
        end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% was only for ANOVA %%%%%%%%
        for hour=1:12
            if  fname(25)=='w' % for juveniles
                stage_duration_juvenile.REM{hour}=[stage_duration_juvenile.REM{hour} stage_duration.REM{1,hour}];
                stage_duration_juvenile.SWS{hour}=[stage_duration_juvenile.SWS{hour} stage_duration.SWS{1,hour}];
                stage_duration_juvenile.IS{hour}=[stage_duration_juvenile.IS{hour} stage_duration.IS{1,hour}];
                stage_duration_juvenile.Wake{hour}=[stage_duration_juvenile.Wake{hour} stage_duration.Wake{1,hour}];
                juvs=juvs+1;
                
            else % for adults
                stage_duration_adult.REM{hour}=[stage_duration_adult.REM{hour} stage_duration.REM{1,hour}];
                stage_duration_adult.SWS{hour}=[stage_duration_adult.SWS{hour} stage_duration.SWS{1,hour}];
                stage_duration_adult.IS{hour}=[stage_duration_adult.IS{hour} stage_duration.IS{1,hour}];
                stage_duration_adult.Wake{hour}=[stage_duration_adult.Wake{hour} stage_duration.Wake{1,hour}];
                aduls=aduls+1;
            end
        end
    end
end


figure
subplot(3,1,1) % REM
for hour=1:12
    mean_adult(hour)=mean(stage_duration_adult.REM{hour});
    ste_adult(hour)=std(stage_duration_adult.REM{hour})/sqrt(length(stage_duration_adult.REM{hour}));
end
errorbar(1:12,mean_adult,ste_adult,'color',[.5 .5 1],'linewidth',1.5); hold on

for hour=1:12
    mean_juvenile(hour)=mean(stage_duration_juvenile.REM{hour});
    ste_juvenile(hour)=std(stage_duration_juvenile.REM{hour})/sqrt(length(stage_duration_juvenile.REM{hour}));
end
errorbar(1:12,mean_juvenile,ste_juvenile,'color',[1 .5 .5],'linewidth',1.5); hold on
ylabel('REM len (sec)')
legend('adult','juvenile')
xlim([.5 12.5])

subplot(3,1,2) % SWS
for hour=1:12
    mean_adult(hour)=mean(stage_duration_adult.SWS{hour});
    ste_adult(hour)=std(stage_duration_adult.SWS{hour})/sqrt(length(stage_duration_adult.SWS{hour}));
end
errorbar(1:12,mean_adult,ste_adult,'color',[.5 .5 1],'linewidth',1.5); hold on

for hour=1:12
    mean_juvenile(hour)=mean(stage_duration_juvenile.SWS{hour});
    ste_juvenile(hour)=std(stage_duration_juvenile.SWS{hour})/sqrt(length(stage_duration_juvenile.SWS{hour}));
end
errorbar(1:12,mean_juvenile,ste_juvenile,'color',[1 .5 .5],'linewidth',1.5); hold on
ylabel('SWS len (sec)')
xlim([.5 12.5])


subplot(3,1,3) % IS
for hour=1:12
    mean_adult(hour)=mean(stage_duration_adult.IS{hour});
    ste_adult(hour)=std(stage_duration_adult.IS{hour})/sqrt(length(stage_duration_adult.IS{hour}));
end
errorbar(1:12,mean_adult,ste_adult,'color',[.5 .5 1],'linewidth',1.5); hold on

for hour=1:12
    mean_juvenile(hour)=mean(stage_duration_juvenile.IS{hour});
    ste_juvenile(hour)=std(stage_duration_juvenile.IS{hour})/sqrt(length(stage_duration_juvenile.IS{hour}));
end
errorbar(1:12,mean_juvenile,ste_juvenile,'color',[1 .5 .5],'linewidth',1.5); hold on
xlim([.5 12.5])
ylabel('IS len (sec)')
xlabel('Time (h)')

% stats
all_REM_adult=[];
all_SWS_adult=[];
all_IS_adult=[];

all_REM_juvenile=[];
all_SWS_juvenile=[];
all_IS_juvenile=[];

for hour=1:12
    all_REM_adult=[all_REM_adult stage_duration_adult.REM{hour}];
    all_SWS_adult=[all_SWS_adult stage_duration_adult.SWS{hour}];
    all_IS_adult=[all_IS_adult stage_duration_adult.IS{hour}];
    
    all_REM_juvenile=[all_REM_juvenile stage_duration_juvenile.REM{hour}];
    all_SWS_juvenile=[all_SWS_juvenile stage_duration_juvenile.SWS{hour}];
    all_IS_juvenile=[all_IS_juvenile stage_duration_juvenile.IS{hour}];
end

% stats
mean_REM_adult=mean(all_REM_adult)
sd_REM_adult=std(all_REM_adult)

mean_SWS_adult=mean(all_SWS_adult)
sd_SWS_adult=std(all_SWS_adult)

mean_IS_adult=mean(all_IS_adult)
sd_IS_adult=std(all_IS_adult)


mean_REM_juvenile=mean(all_REM_juvenile)
sd_REM_juvenile=std(all_REM_juvenile)

mean_SWS_juvenile=mean(all_SWS_juvenile)
sd_SWS_juvenile=std(all_SWS_juvenile)

mean_IS_juvenile=mean(all_IS_juvenile)
sd_IS_juvenile=std(all_IS_juvenile)

% ANOVA
% REM
[p,~,stats] = anovan(bouts_REM_all,{age_REM,sex_REM})
% SWS
[p,~,stats] = anovan(bouts_SWS_all,{age_SWS,sex_SWS})
% IS
[p,~,stats] = anovan(bouts_IS_all,{age_IS,sex_IS})