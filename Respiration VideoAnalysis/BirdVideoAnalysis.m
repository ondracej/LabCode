%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script read video in MATLAB. Lets you select some specific part of
% it, define the ROI. Finally tracks some specific points.
% lines that you must change manually are commented by a couple of '%' signs
% like:  x=3; %%%%%%%%
% Execute the crop cell only if you need to make a cropped video out of the
% original video because it may take hours

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% loading the video
folder_path='G:\Hamed\zf\71_15';
fname='18_02_2020'; %%%%%%%%%%%%
vid=VideoReader([folder_path '\' fname '.avi']);
%% selecting frame range for processig
n=vid.NumFrames; % this is an estimation of number of frame, to be safe consider ...
% something like 100 fewer frames as the last frame
f0=1; % 1st frame %%%%%%%%%
fn=n-100; % last frame %%%%%%%%%%
% display the first frame:
im=read(vid,1);
imshow(im)

%% cropping the video to the ROI and frames of interest (it will take several hours)
% Attentiion: Execute the this cell only if you need to make a cropped video out of the
% original video because it may take ours
% defining ROI for cropping
% coordinates starting from upper left side of original image in pixels
x=512;  y=309;  w=768;  h=514;  %%%%%%%%%%%
ROI=[x,y,w,h]; % The ROI for the new video
f_path_roi=[folder_path '\' fname  '_ROI.avi']; % file name for the cropped video %%%%%%%
frames=f0:f0+100;
birdvid_crop( vid, f_path_roi, ROI, frames );
clear vid f0 x y w h 
%% reading ROI video and computing consecutive differences
f_path=f_path_roi;
frames=1000: 1200; %%%%%%% frames to be analyzed
[r_dif,acc_dif] = birdvid_move_extract(f_path,frames);

% plotting the moving area of the footage
figure
subplot(1,3,1)
imshow(uint8(im1)); title('Original frame')
subplot(1,3,2)
faint_im1=.4*im1+100; % mapping to confinding the pixel intensities to 200-250 instead of ...
% full range (0-255)
difim = cat(3, faint_im1, faint_im1-5*dif, faint_im1-5*dif); % the difference just depics in Red
imshow(uint8(difim)); title('Consecutive difference')
subplot(1,3,3)
acc_difim = cat(3, faint_im1, faint_im1-1*acc_dif, faint_im1-1*acc_dif); % the difference just depics in Red
imshow(uint8(acc_difim)); title('Overall absolute difference')

figure
plot(frames(2:end)/20,r_dif(frames(2:end))); xlabel('Time (s)') ;  ylabel('Absolute body movements')
ylim([1200 2000]) ;



