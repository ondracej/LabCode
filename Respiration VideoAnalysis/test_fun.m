%% loading the video
folder_path='Y:\HamedData\P1\72-00\02_04_2020'; %%%%%%%%%%
fname='02_04_2020_00115_converted'; %%%%%%%%%%%%
vid=VideoReader([folder_path '\' fname '.avi']);

% selecting frame range for processig

n=vid.NumFrames; % this is an estimation of number of frame, to be safe consider ...

% something like 100 fewer frames than the last frame
f0=1; % 1st frame %%%%%%%%%
fn=20*60*30; % last frame %%%%%%%%%%


%% cropping the video to the ROI and frames of interest (it will take several hours)
% Attentiion: Execute the this cell only if you need to make a cropped video out of the
% original video because it may take ours
% defining ROI for cropping
% coordinates starting from upper left side of original image in pixels
x=830;  y=300;  w=450;  h=624;  %%%%%%%%%%%
ROI=[x,y,w,h]; % The ROI for the new video
f_path_roi=[folder_path '\' fname  '_ROI.avi']; % file name for the cropped video %%%%%%%
frames=f0:fn;