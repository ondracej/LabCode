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
%% stats
mean_REM_adult=mean(mean(stage_duration_adult.REM))
sd_REM_adult=std(mean(stage_duration_adult.REM,2))

mean_SWS_adult=mean(mean(stage_duration_adult.SWS))
sd_SWS_adult=std(mean(stage_duration_adult.SWS,2))

mean_IS_adult=mean(mean(stage_duration_adult.IS))
sd_IS_adult=std(mean(stage_duration_adult.IS,2))


mean_REM_juvenile=mean(mean(stage_duration_juvenile.REM))
sd_REM_juvenile=std(mean(stage_duration_juvenile.REM,2))

mean_SWS_juvenile=mean(mean(stage_duration_juvenile.SWS))
sd_SWS_juvenile=std(mean(stage_duration_juvenile.SWS,2))

mean_IS_juvenile=mean(mean(stage_duration_juvenile.IS))
sd_IS_juvenile=std(mean(stage_duration_juvenile.IS,2))

% anovan
REMs=[mean(stage_duration_adult.REM,2); mean(stage_duration_juvenile.REM,2)];
age=[zeros(size(mean(stage_duration_adult.REM,2))); ones(size(mean(stage_duration_juvenile.REM,2)))];
p = anovan(REMs,{age,sex})
SWSs=[mean(stage_duration_adult.SWS,2); mean(stage_duration_juvenile.SWS,2)];
age=[zeros(size(mean(stage_duration_adult.SWS,2))); ones(size(mean(stage_duration_juvenile.SWS,2)))];
p = anovan(SWSs,{age,sex})
ISs=[mean(stage_duration_adult.IS,2); mean(stage_duration_juvenile.IS,2)];
age=[zeros(size(mean(stage_duration_adult.IS,2))); ones(size(mean(stage_duration_juvenile.IS,2)))];
p = anovan(ISs,{age,sex})