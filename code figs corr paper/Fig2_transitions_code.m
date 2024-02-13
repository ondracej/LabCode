function [transitions]=Fig2_transitions_code(data,t0)
% t0=light_off_t(n);

t_bins=data.t_bin_label;
stages=data.bin_label;
transitions.SWS_to_IS=zeros(1,12);
transitions.SWS_to_REM=zeros(1,12);
transitions.REM_to_IS=zeros(1,12);
transitions.REM_to_SWS=zeros(1,12);

% loop for the hours of sleep
for hour=0:11
    hour_inds=(t_bins>t0+hour*3600) & (t_bins<t0+(hour+1)*3600);
    stages_hour=stages(hour_inds);
    for k=1:length(stages_hour)-1
        if strcmp(stages_hour{k},'SWS') & strcmp(stages_hour{k+1},'IS')
            transitions.SWS_to_IS(hour+1)=transitions.SWS_to_IS(hour+1)+1;
        elseif strcmp(stages_hour{k},'SWS') & strcmp(stages_hour{k+1},'REM')
            transitions.SWS_to_REM(hour+1)=transitions.SWS_to_REM(hour+1)+1;
        elseif strcmp(stages_hour{k},'REM') & strcmp(stages_hour{k+1},'IS')
            transitions.REM_to_IS(hour+1)=transitions.REM_to_IS(hour+1)+1;
        elseif strcmp(stages_hour{k},'REM') & strcmp(stages_hour{k+1},'SWS')
            transitions.REM_to_SWS(hour+1)=transitions.REM_to_SWS(hour+1)+1;
        end
    end
end

end
