%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script reads video in MATLAB, lets you select some specific part of
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

f_path='G:\Hamed\zf\71_15\18_02_2020_ROI.avi'; %%%%%%%%%%%%%%%

frames=1000: 1200; %%%%%%% frames to be analyzed
[r_dif,acc_dif, last_im, last_dif] = birdvid_move_extract(f_path,frames);

% plotting the moving area of the footage
figure
subplot(1,3,1)
imshow(uint8(last_im)); title('Original frame')
subplot(1,3,2)
faint_im1=.4*last_im+100; % mapping to confinding the pixel intensities to 200-250 instead of ...
% full range (0-255)
difim = cat(3, faint_im1, faint_im1-5*last_dif, faint_im1-5*last_dif); % the difference just depics in Red
imshow(uint8(difim)); title('Consecutive difference')
subplot(1,3,3)
acc_difim = cat(3, faint_im1, faint_im1-1*acc_dif, faint_im1-1*acc_dif); % the difference just depics in Red
imshow(uint8(acc_difim)); title('Overall absolute difference')

figure
plot(frames(2:end)/20,r_dif(frames(2:end))); xlabel('Time (s)') ;  ylabel('Absolute body movements')
ylim([1200 2000]) ;

%% a movie shows the frames as well as extracted respiration
figure,
vidroi=VideoReader(f_path); % the video to read from
f_path_resp='G:\Hamed\zf\71_15\18_02_2020_RESPIRATION1.avi'; % address for the putput video
vid = VideoWriter(f_path_resp); % the video to be generated for depiction purpose
vid.FrameRate=10;
% vid.LosslessCompression=true; 
open(vid);
im1=double(rgb2gray(read(vidroi, frames(1)))); % first x_old (in comparison)
% difining some variables that are used in the loop
y_pixls=1:size(im1,1);  y_vals=y_pixls'/sum(y_pixls); % a vector of values from 0 to 1 with ...
% a length equal to the height of the image. Also the same for length
x_pixls=1:size(im1,2);  x_vals=x_pixls'/sum(x_pixls); 
[b,a] = butter(2,.5/(20/2)); % filter for smoothing the extracted respiration ...
% inputs: cutoff , and sampling frequency

frames=6100: 6500; %%%%%%% frames to be analyzed

for i=frames(2:end)
    % this section of the lop generates the r_dif variable,
    im2=double(rgb2gray(read(vidroi,i))); % x_new
    dif=abs(im2-im1);   % difference computation
    y_dif=sum(dif,2); % difference along vertical axis
    x_dif=sum(dif,1); % difference along horizontal axis
    % computing the weighted average of moved pixels (dif) along y and x:
    y_dif_mean=y_dif'*y_vals;
    x_dif_mean=x_dif*x_vals;
    r_dif(i)=sqrt(x_dif_mean^2 + y_dif_mean^2); % position of the center of changes in the current ...
    % following frames (r in polar coordinates)
    
    % this section makes the frames that display the difference and the
    % respiraton
    faint_im1=.4*im2+100; % mapping to confinding the pixel intensities to 200-250 instead of ...
    % full range (0-255)
    difim = cat(3, faint_im1, faint_im1-2*dif, faint_im1-2*dif); % the difference just depics in Red
    imshow(uint8(difim));
    hold on
    indx=max(i-60+1,1):i; % indexes of the most current last frams (40 feames)...
    % to show the extracted respiration for
    x_range=[50 350]; % x range location (in pixels) for the respiration plot
    interp_r=interp1(linspace(x_range(1),x_range(2),length(indx)), r_dif(indx)/2 -1230, ...
        linspace(x_range(1),x_range(2),200));
    % smooth the extracted respiration to remove the fast spiky noises
    interp_r_f=filtfilt(b,a,interp_r);
    plot(51:250, -interp_r_f,'linewidth',2,'color','g');
    frame = getframe(gcf);
    writeVideo(vid,frame); % save frame
    pause(.01)
    im1=im2; % consider x_new as x_old for the next comparison
    dif_old=dif;
end
close(vid)











