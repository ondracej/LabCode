labels=data.bin_label;
t_bins=data.t_bin_label-light_off_t;
for hour=1:12
    % REM and SWS stage_percentage
    inds=t_bins/3600>hour-1 & t_bins/3600<hour;
    stage_percentage.REM(hour)=100*sum(strcmp(labels(inds),'REM'))/(3600/3);
    stage_percentage.SWS(hour)=100*sum(strcmp(labels(inds),'SWS'))/(3600/3);
    stage_percentage.IS(hour)=100*sum(strcmp(labels(inds),'IS'))/(3600/3);
    stage_percentage.Wake(hour)=100*sum(strcmp(labels(inds),'Wake'))/(3600/3);

    % REM and SWS durations
    hour_inds=true(1,sum(inds));
[stage_duration.Wake{hour}, stage_duration.SWS{hour}, stage_duration.IS{hour}, stage_duration.REM{hour}] = ...
    stage_length_(labels(inds), hour_inds, t_bins(inds));

     % REM and SWS transitions
REM_nREM_transitions(hour)=length(stage_duration.REM{hour});
arousals(hour)=length(stage_duration.Wake{hour});
end

save(strcat("G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_", fname),...
    'stage_percentage','stage_duration','REM_nREM_transitions','arousals');
