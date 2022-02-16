% clear;
% 
% saving_name='w041-05-01-2022_scoring'; %%%%%%%%%%%% saving name in the local computer
% folder_path='Z:\hameddata2\16 chnl EEG\w041 and w043\vids\w041'; %%%%%%%%%% read videofile from here
% fname='w041-05-01-2022_00265-converted'; %%%%%%%%%%%% video file name
% dir_path_ephys='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\chronic_2022-01-05_20-55-56-only-w041'; %%%%%%%%
% dir_prefix='150'; %%%%%%%%%%%%%%
% file_dev=1; %%%%%%%%%%%%%%%%% which portion of EEG file you want to read? 10 for ane tenth of the file
% chnl_order=[1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15 ]; 
% f0=750; %1st frame
% fn=869900;%%%%%%%  ceil(vid.FrameRate*vid.Duration/file_dev)-1000;  %%%%%%%%%% last frame %%%%%%%%% /10
% parameters for ADC correction proess
% ADC_corruption=1; %%%%%%%%% is ADC corrupted
% N_teager=50; %%%%%%%%%% delay parameter in Teager filter
% jump_val=0.5; %%%%%%%%% a value greater than the ADC pulse highs, after applying Teager filter to the ADC, but smaller ...
% % than the high jumps caused by corruption
% ADC_thresh=0.075; %%%%%%%%%% 
% load_EEG_video_without_ADC;

% clear;
% 
% saving_name='w041-06-01-2022_scoring'; %%%%%%%%%%%% saving name in the local computer
% folder_path='Z:\hameddata2\16 chnl EEG\w041 and w043\vids\w041'; %%%%%%%%%% read videofile from here
% fname='w041-06-01-2022_00266-converted'; %%%%%%%%%%%% video file name
% dir_path_ephys='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\chronic_2022-01-06_21-13-30-onyw041'; %%%%%%%%
% dir_prefix='150'; %%%%%%%%%%%%%%
% file_dev=1; %%%%%%%%%%%%%%%%% which portion of EEG file you want to read? 10 for ane tenth of the file
% chnl_order=[1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15 ]; 
% f0=27920; %1st frame
% fn=895800;%%%%%%%  ceil(vid.FrameRate*vid.Duration/file_dev)-1000;  %%%%%%%%%% last frame %%%%%%%%% /10
% load_EEG_video_without_ADC;
% clear;
% 
% saving_name='w041-07-01-2022_scoring'; %%%%%%%%%%%% saving name in the local computer
% folder_path='Z:\hameddata2\16 chnl EEG\w041 and w043\vids\w041'; %%%%%%%%%% read videofile from here
% fname='w041-07-01-2022_00267-converted'; %%%%%%%%%%%% video file name
% dir_path_ephys='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\chronic_2022-01-07_20-53-10-only-w041'; %%%%%%%%
% dir_prefix='150'; %%%%%%%%%%%%%%
% file_dev=1; %%%%%%%%%%%%%%%%% which portion of EEG file you want to read? 10 for ane tenth of the file
% chnl_order=[1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15 ]; 
% f0=20490; %1st frame
% fn=890370;%%%%%%%  ceil(vid.FrameRate*vid.Duration/file_dev)-1000;  %%%%%%%%%% last frame %%%%%%%%% /10
% load_EEG_video_without_ADC;
% clear;
% 
% saving_name='w041-08-01-2022_scoring'; %%%%%%%%%%%% saving name in the local computer
% folder_path='Z:\hameddata2\16 chnl EEG\w041 and w043\vids\w041'; %%%%%%%%%% read videofile from here
% fname='w041-08-01-2022_00269-converted'; %%%%%%%%%%%% video file name
% dir_path_ephys='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\chronic_2022-01-08_21-27-43-only-w041'; %%%%%%%%
% dir_prefix='150'; %%%%%%%%%%%%%%
% file_dev=1; %%%%%%%%%%%%%%%%% which portion of EEG file you want to read? 10 for ane tenth of the file
% chnl_order=[1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15 ]; 
% f0=7490; %1st frame
% fn=882890;%%%%%%%  ceil(vid.FrameRate*vid.Duration/file_dev)-1000;  %%%%%%%%%% last frame %%%%%%%%% /10
% load_EEG_video_without_ADC;
% 
% clear;
% saving_name='w043-22-12-2021_scoring'; %%%%%%%%%%%% saving name in the local computer
% folder_path='Z:\hameddata2\16 chnl EEG\w041 and w043\vids\w043'; %%%%%%%%%% read videofile from here
% fname='w043-22-12-2021_00250-converted'; %%%%%%%%%%%% video file name
% dir_path_ephys='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\chronic_2021-12-22_20-52-40'; %%%%%%%%
% dir_prefix='150'; %%%%%%%%%%%%%%
% file_dev=1; %%%%%%%%%%%%%%%%% which portion of EEG file you want to read? 10 for ane tenth of the file
% chnls=17:32;
% chnl_order=chnls([1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15 ]); 
% f0=18840; % lights off frame number
% fn=888050;%%%%%%%  ceil(vid.FrameRate*vid.Duration/file_dev)-1000;  %%%%%%%%%% last frame %%%%%%%%% /10
% load_EEG_video_without_ADC;


% clear;
% saving_name='w043-25-12-2021_scoring'; %%%%%%%%%%%% saving name in the local computer
% folder_path='Z:\hameddata2\16 chnl EEG\w041 and w043\vids\w043'; %%%%%%%%%% read videofile from here
% fname='w043-25-12-2021_00253-converted'; %%%%%%%%%%%% video file name
% dir_path_ephys='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\chronic_2021-12-25_21-45-17'; %%%%%%%%
% dir_prefix='150'; %%%%%%%%%%%%%%
% file_dev=1; %%%%%%%%%%%%%%%%% which portion of EEG file you want to read? 10 for ane tenth of the file
% chnls=17:32;
% chnl_order=chnls([1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15 ]); 
% f0=17767; % lights off frame number
% fn=886245;%%%%%%%  ceil(vid.FrameRate*vid.Duration/file_dev)-1000;  %%%%%%%%%% last frame %%%%%%%%% /10
% load_EEG_video_without_ADC;
clear;
saving_name='w043-23-12-2021_scoring'; %%%%%%%%%%%% saving name in the local computer
folder_path='Z:\hameddata2\16 chnl EEG\w041 and w043\vids\w043'; %%%%%%%%%% read videofile from here
fname='w043-23-12-2021_00251-converted2'; %%%%%%%%%%%% video file name
dir_path_ephys='Z:\hameddata2\16 chnl EEG\w041 and w043\ephys\chronic_2021-12-23_20-48-23'; %%%%%%%%
dir_prefix='150'; %%%%%%%%%%%%%%
file_dev=1; %%%%%%%%%%%%%%%%% which portion of EEG file you want to read? 10 for ane tenth of the file
chnls=17:32;
chnl_order=chnls([1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15 ]); 

f0=27920; %1st frame
fn=895800;%%%%%%%  ceil(vid.FrameRate*vid.Duration/file_dev)-1000;  %%%%%%%%%% last frame %%%%%%%%% /10
load_EEG_video_without_ADC;

