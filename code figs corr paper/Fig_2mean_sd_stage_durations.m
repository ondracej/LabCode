 clear;
 %Save the folder of files in the current directory
 path_directory='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper'; 
 % Pls note the format of files,change it as required
    juv_stage_duration_SWS=[];
    juv_stage_duration_IS=[];
    juv_stage_duration_REM=[];
    
    adult_stage_duration_SWS=[];
    adult_stage_duration_IS=[];
    adult_stage_duration_REM=[];
    
 original_files=dir([path_directory '/stage_stat_sleep_stages*.mat']); 
 for k=1:length(original_files)
     fname=original_files(k).name;
    filename=[path_directory '/' fname];
    load(filename) % Load file
    switch  fname(25)
    case 'w'
    for hour=1:12
    juv_stage_duration_SWS=[juv_stage_duration_SWS stage_duration.SWS{hour}];
    juv_stage_duration_IS=[juv_stage_duration_IS stage_duration.IS{hour}];
    juv_stage_duration_REM=[juv_stage_duration_REM stage_duration.REM{hour}];
    end
    
    case '7'
    for hour=1:12
    adult_stage_duration_SWS=[adult_stage_duration_SWS stage_duration.SWS{hour}];
    adult_stage_duration_IS=[adult_stage_duration_IS stage_duration.IS{hour}];
    adult_stage_duration_REM=[adult_stage_duration_REM stage_duration.REM{hour}];
    end    
    end
 end


    mean(juv_stage_duration_SWS)
    mean(juv_stage_duration_IS)
    mean(juv_stage_duration_REM)
    std(juv_stage_duration_SWS)
    std(juv_stage_duration_IS)
    std(juv_stage_duration_REM)
    
    mean(adult_stage_duration_SWS)
    mean(adult_stage_duration_IS)
    mean(adult_stage_duration_REM)
    std(adult_stage_duration_SWS)
    std(adult_stage_duration_IS)
    std(adult_stage_duration_REM)
    


