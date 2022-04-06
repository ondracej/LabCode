tic
SWS_onsets=[];
REM_onsets=[];
t0_=t_bins3sec(1); % initiation for the variable containing the times of SWS and REM initiation
t0=t_bins3sec(1); % initiation for the variable containing the times of SWS and REM initiation

SWS_inds=[];
REM_inds=[];
while ~isempty(t0_)
    t0_=find(LH_valid>SWS_thresh & t_bins3sec>t0);
    if ~isempty(t0_)
        t0=t_bins3sec(t0_(1)); % first time after the current transition time, t0, that DOS surpasses SWS threshold
        SWS_onsets=[SWS_onsets t0];
        SWS_inds=[SWS_inds t0_];
        % see if there is also REM happening:
        t0_=find(LH_valid<REM_thresh & t_bins3sec>t0);
        if ~isempty(t0_)
            t0=t_bins3sec(t0_(1)); % first time after the current transition time, t0, that DOS surpasses SWS threshold
            REM_onsets=[REM_onsets t0];
            REM_inds=[REM_inds t0_];
        end
    end
end
toc