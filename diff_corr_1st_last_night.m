% initiation of the saved variable
clear res
n=1;
res(n).bird=''; % initiation of the file


n=1;
fname='73-03_09_03_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=31000/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=889160/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=1:16; % number of non-noisy channels
pipeline_full_corr_matrix;
clear


n=2;
fname='73-03 14_03_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=746290/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=1:16; % number of non-noisy channels
pipeline_full_corr_matrix;
clear


n=3;
fname='w0009_27-04_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=7000/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=857860/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % number of non-noisy channels
pipeline_full_corr_matrix;
clear


n=4;
fname='w0009_06-05_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=820590/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:8 10:16]; % number of non-noisy channels
pipeline_full_corr_matrix;
clear



n=5;
fname='72-00_18-03_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=847160/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:13 15:16]; % number of non-noisy channels
pipeline_full_corr_matrix;
clear



n=6;
fname='72-00_09-04_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=840700/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:5 7:13 15:16]; % number of non-noisy channels
pipeline_full_corr_matrix;
clear

n=7;
fname='72-94_28-05_scoring';   % load data
load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-94\72-94 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=106800/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=989716/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:10 12:16]; % number of non-noisy channels
pipeline_full_corr_matrix;
clear

n=8;
fname='72-94_11-06_scoring';   % load data
load(fname);
image_layout='Z:\zoologie\HamedData\P1\72-94\72-94 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=135300/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=1000300/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:10 12:16]; % number of non-noisy channels
pipeline_full_corr_matrix;
clear



n=9;
fname='w0016_05-08_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0016 juv\w0016 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=32120/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=897280/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % number of non-noisy channels
pipeline_full_corr_matrix;
clear


n=10;
fname='w0016_11-08_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0016 juv\w0016 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=16560/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=881111/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % number of non-noisy channels
pipeline_full_corr_matrix;
clear


n=11;
fname='w0021_17-08_scoring';
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0021 juv\w0021 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=8630/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=873750/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % number of non-noisy channels
pipeline_full_corr_matrix;
clear



n=12;
fname='w0021_23-08_scoring';     
load(fname);
image_layout='Z:\zoologie\HamedData\P1\w0021 juv\w0021 layout.jpg'; %%%%%%%%%%%%%%
light_off_t=84520/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=947970/20;  %%%%%%%%%%% frame number devided by rate of acquisition
valid_chnls=[1:6 8:10 12 13 15 16]; % number of non-noisy channels
pipeline_full_corr_matrix;
clear


