% creating the saving variable
clear;
res(1).experiment='';
save('G:\Hamed\zf\P1\labled sleep\cc_doss.mat','res','-nocompression')
n=1
fname='72-94_29_05_scoring';   % load data
load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-94\72-94 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=28772/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=892778/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:10 12:16]; % non-noisy channels
cc_dos;
clear;

n=2
fname='73-03_09_03_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=31000/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=889160/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=1:16; % non-noisy channels
cc_dos;
clear



n=3
fname='w0009_01-05_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=872000/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % non-noisy channels
cc_dos;
clear

n=4
fname='w0016_08-08_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0016 juv\w0016 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=690/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=871900/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % non-noisy channels
cc_dos;
clear

n=5
fname='72-00_26_03_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=842000/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:16]; % non-noisy channels
cc_dos;
clear



n=6
fname='w0009_27-04_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=7000/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=857860/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % non-noisy channels
cc_dos;
clear



n=7
fname='w0018_14-08_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0016 juv\w0016 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=19040/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=881362/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12:16]; % non-noisy channels
cc_dos;
clear

n=8
fname='w0020_25_09_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0021 juv\w0021 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=35580/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=900200/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % non-noisy channels
cc_dos;
clear








n=9
fname='w0021_17-08_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0021 juv\w0021 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=8630/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=873750/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % non-noisy channels
cc_dos;
clear





%%%%%%%%%%%%%%%%%%%%%%%%%
% these are the ones without ADC. For EEG-video alighnment, the difference between the srtarting time is used.

n=10
fname='w0041-05-01-2022_scoring';   % load data
load(fname);
image_layout='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\w041 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=750/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=869900/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[2:16]; % non-noisy channels
t_diff=177; % time in secons from the start of Ephys recording till start of video
cc_dos;
clear;




n=11
fname='w0043-22-12-2021_scoring';   % load data
load(fname);
image_layout='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\w043 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=18840/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=888050/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[2:16]; % non-noisy channels
t_diff=6; % time in secons from the start of Ephys recording till start of video
cc_dos;
clear;




