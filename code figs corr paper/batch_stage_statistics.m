


n=1
fname='sleep_stages_72-94_29_05';   % load data
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-94\72-94 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=28772/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=892778/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:10 12:16]; % non-noisy channels
run_stage_statistics;
clear;

n=2
fname='sleep_stages_73-03_09_03';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=31000/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=889160/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=1:16; % non-noisy channels
run_stage_statistics;
clear

n=3
fname='sleep_stages_73-03_11_03';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=5980/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=837500/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=1:16; % non-noisy channels
run_stage_statistics;
clear

n=4
fname='sleep_stages_73-03 14_03';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=746290/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=1:16; % non-noisy channels
run_stage_statistics;
clear

n=5;
fname='sleep_stages_w0009_01-05';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=872000/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % non-noisy channels
run_stage_statistics;
clear

n=6;
fname='sleep_stages_w0016_08-08';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0016 juv\w0016 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=690/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=871900/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % non-noisy channels
run_stage_statistics;
clear

n=7;
fname='sleep_stages_72-00_26_03';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=842000/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:16]; % non-noisy channels
run_stage_statistics;
clear

n=8;
fname='sleep_stages_72-00_02-04';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=884675/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:16]; % non-noisy channels
run_stage_statistics;
clear

n=9;
fname='sleep_stages_72-00_03-04';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=851777/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:16]; % non-noisy channels
run_stage_statistics;
clear

n=10;
fname='sleep_stages_72-00_05-04';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=843130/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:16]; % non-noisy channels
run_stage_statistics;
clear

n=11;
fname='sleep_stages_72-00_06-04';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=854300/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:16]; % non-noisy channels
run_stage_statistics;
clear

n=12;
fname='sleep_stages_72-00_07-04';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=842350/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:16]; % non-noisy channels
run_stage_statistics;
clear



n=14;
fname='sleep_stages_w0009_28-04';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1780/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=851500/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % non-noisy channels
run_stage_statistics;
clear


n=17
fname='sleep_stages_w0021_20_08';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0021 juv\w0021 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=22100/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=885580/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % non-noisy channels
run_stage_statistics;
clear


n=22; 
fname='sleep_stages_72-00_29-03';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=810000/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:16]; % non-noisy channels
run_stage_statistics;
clear


n=23
fname='sleep_stages_72-00_31-03';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=804670/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:16]; % non-noisy channels
run_stage_statistics;
clear

n=24
fname='sleep_stages_72-94_07-06';   % load data
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-94\72-94 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=52530/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=916540/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:10 12:16]; % non-noisy channels
run_stage_statistics;
clear


n=26;
fname='sleep_stages_72-94_28-05';   % load data
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-94\72-94 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=106800/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=989716/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:10 12:16]; % non-noisy channels
run_stage_statistics;
clear


n=28
fname='sleep_stages_72-94_31-05';   % load data
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-94\72-94 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=6715/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=871390/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:10 12:16]; % non-noisy channels
run_stage_statistics;
clear


n=29
fname='sleep_stages_w0009_30-04';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=855300/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % non-noisy channels
run_stage_statistics;
clear

n=30
fname='sleep_stages_w0009_04-05';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=879920/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % non-noisy channels
run_stage_statistics;
clear


tic
n=31
fname='sleep_stages_w0009_05-05';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=837890/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % non-noisy channels
beep
run_stage_statistics;
toc
clear

n=32
fname='sleep_stages_w0009_06-05';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=820590/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % non-noisy channels
beep
run_stage_statistics;
clear


n=33
fname='sleep_stages_w0016_05-08';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0016 juv\w0016 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=32120/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=897280/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % non-noisy channels
beep
run_stage_statistics;
clear


n=34
fname='sleep_stages_w0016_06-08';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0016 juv\w0016 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1580/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=866430/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % non-noisy channels
beep
run_stage_statistics;
clear


n=39
fname='sleep_stages_w0021_21-08';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0021 juv\w0021 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=22100/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=885570/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % non-noisy channels
beep
run_stage_statistics;
clear


n=41
fname='sleep_stages_w0021_23-08';
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0021 juv\w0021 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=84520/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=947970/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % non-noisy channels
beep
run_stage_statistics;
clear


n=42
fname='sleep_stages_72-94_08-06';  
data=load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-94\72-94 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=19130/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=883360/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:10 12:16]; % non-noisy channels
beep
run_stage_statistics;
clear


%%%%%%%%%%%%%%%%%%%%%%%%%
% these are the ones without ADC. For EEG-video alighnment, the difference between the srtarting time is used.

n=43
fname='sleep_stages_w0041-05-01-2022';   % load data
data=load(fname);
image_layout='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\w041 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=750/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=869900/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[2:16]; % non-noisy channels
t_diff=177; % time in secons from the start of Ephys recording till start of video
beep
run_stage_statistics;
clear;

n=44
fname='sleep_stages_w0041-06-01-2022';   % load data
data=load(fname);
image_layout='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\w041 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=27920/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=895800/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[2:16]; % non-noisy channels
t_diff=16; % time in secons from the start of Ephys recording till start of video
beep
run_stage_statistics;
clear;

n=45
fname='sleep_stages_w0041-07-01-2022';   % load data
data=load(fname);
image_layout='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\w041 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=20490/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=890370/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[2:16]; % non-noisy channels
t_diff=20; % time in secons from the start of Ephys recording till start of video
beep
run_stage_statistics;
clear;

n=46 %% really really awesome sharp stages!!!!!!!!!
fname='sleep_stages_w0041-08-01-2022';   % load data
data=load(fname);
image_layout='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\w041 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=7490/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=882890/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[2:16]; % non-noisy channels
t_diff=13; % time in secons from the start of Ephys recording till start of video
beep;
run_stage_statistics;
clear;



n=49
fname='sleep_stages_w0043-23-12-2021';   % load data
data=load(fname);
image_layout='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\w043 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=24790/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=893940/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[2:16]; % non-noisy channels
t_diff=26; % time in secons from the start of Ephys recording till start of video
beep
run_stage_statistics;
clear;



