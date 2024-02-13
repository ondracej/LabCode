clear;clc;
res(1).bird=''; % just to initiate the matrix that contains the output from all birds' data
save('G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\batch_1_night_AllBirds_CC_of_DOS.mat','res','-nocompression');

n=1
fname='72-94_29_05_scoring';   % load data
load(fname);
light_off_t=28772/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=892778/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:10 12:16]; % number of non-noisy channels
GenFig1_CC_DOS_1night_allbirds_code;
clear

n=2
fname='73-03_09_03_scoring';
load(fname);
light_off_t=31000/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=889160/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=1:16; % number of non-noisy channels
GenFig1_CC_DOS_1night_allbirds_code;
clear

n=3
fname='72-00_26_03_scoring';
load(fname);
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=842000/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:13 15:16]; % number of non-noisy channels
GenFig1_CC_DOS_1night_allbirds_code;
clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=4
fname='w0009_01-05_scoring';
load(fname);
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=872000/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % number of non-noisy channels
GenFig1_CC_DOS_1night_allbirds_code;
clear

n=5
fname='w0016_08-08_scoring';
load(fname);
light_off_t=690/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=871900/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % number of non-noisy channels
GenFig1_CC_DOS_1night_allbirds_code;
clear

n=6
fname='w0018_14-08_scoring';
load(fname);
light_off_t=19040/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=881362/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12:16]; % number of non-noisy channels
GenFig1_CC_DOS_1night_allbirds_code;
clear

n=7
fname='w0020_25_09_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0021 juv\w0021 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=35580/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=900200/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % number of non-noisy channels
GenFig1_CC_DOS_1night_allbirds_code;
clear

n=8
fname='w0021_20_08_scoring';
load(fname);
light_off_t=22100/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=885580/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % number of non-noisy channels
GenFig1_CC_DOS_1night_allbirds_code;
clear

n=9
fname='w0041-05-01-2022_scoring';   % load data
load(fname);
light_off_t=750/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=869900/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[2:16]; % non-noisy channels
t_diff=177; % time in secons from the start of Ephys recording till start of video
GenFig1_CC_DOS_1night_allbirds_code;
clear;

n=10
fname='w0043-22-12-2021_scoring';   % load data
load(fname);
image_layout='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\w043 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=18840/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=888050/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[2:16]; % non-noisy channels
t_diff=6; % time in secons from the start of Ephys recording till start of video
GenFig1_CC_DOS_1night_allbirds_code;
clear;
