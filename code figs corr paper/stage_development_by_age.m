clear;
n=1;
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0009_28-04';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=48 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

n=2; 
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0009_30-04';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=50 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

n=3;
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0009_01-05';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=51 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

n=4;
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0009_04-05';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=54 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

n=5;
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0009_05-05';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=55 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

n=6; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0009_06-05';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=56 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

%%%%%%%%%%% w016

n=7; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0016_05-08';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=50 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);


n=8; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0016_06-08';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=51 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);


n=9; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0016_08-08';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=53 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

%%%%%%%%% w0021
n=10; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0021_20_08';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=54 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

n=11; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0021_21-08';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=55 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

n=12; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0021_23-08';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=57 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

%%%%%%%%% w0041
n=13; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0041-05-01-2022';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=83 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

n=14; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0041-06-01-2022';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=84 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

n=15; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0041-07-01-2022';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=85 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

n=16; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0041-08-01-2022';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=86 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

%%%%%%% w043
n=17; %%%%%%%%
fname='G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\stage_stat_sleep_stages_w0043-23-12-2021';%%%%%%%%
[filepath,name,ext] = fileparts(fname);
stages_data=load(fname);
stages_vs_age(n).bird_id=name(25:29);
stages_vs_age(n).age=70 ; %%%%%%%%
stages_vs_age(n).REM=mean(stages_data.stage_percentage.REM);
stages_vs_age(n).IS=mean(stages_data.stage_percentage.IS);
stages_vs_age(n).SWS=mean(stages_data.stage_percentage.SWS);

%% analysis and figures
bird_symbols={'+','*','d','v','^'};
figure
for k=1:17
    symb=bird_symbols{strcmp( stages_vs_age(k).bird_id,{'w0009','w0016','w0021','w0041','w0043'})};
subplot(1,3,1)
plot([stages_vs_age(k).age],[stages_vs_age(k).REM],'.r','markersize',5,...
    'marker',symb,'LineWidth', 1.2);
xlabel('Age (dph)'); hold on
ylabel('REM (%)')
subplot(1,3,2)
plot([stages_vs_age(k).age],[stages_vs_age(k).SWS],'.b','markersize',5,...
    'marker',symb,'LineWidth', 1.2);  hold on
xlabel('Age (dph)');
ylabel('SWS (%)')
subplot(1,3,3)
plot([stages_vs_age(k).age],[stages_vs_age(k).IS],'.','Color',[0 .9 1],'markersize',5,...
    'marker',symb,'LineWidth', 1.2);  hold on
xlabel('Age (dph)');
ylabel('IS (%)')
end
