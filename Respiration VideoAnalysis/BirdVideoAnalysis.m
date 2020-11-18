%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script reads video in MATLAB, lets you select some specific part of
% it, define the ROI. Finally extract the overall movements.
% lines that you must change manually are commented by a couple of '%' signs
% like:  x=3; %%%%%%%%
% Execute the crop cell only if you need to make a cropped video out of the
% original video because it may take hours

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
birdvid_crop( vid, f_path_roi, ROI, frames );
clear x y w h
%% reading ROI video and computing consecutive differences
tic
f_path=[folder_path '\' fname '.avi']; %%%%%%%%%%%%%%%

frames=f0: fn; %%%%%%% frames to be analyzed
roi_y=100:924;  roi_x=100:1200; %%%%%%%%%%%%% where is the region of interest?
[r_dif,acc_dif, last_im, last_dif] = birdvid_move_extract(f_path,frames,roi_y,roi_x);

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
ylim([0 mean(r_dif)+20*iqr(r_dif)]) ;
toc

%% Detrending concequtive difference signal for extraction of respiration
% cutting a piece of data 
k0=1;
samps=1:10*60*20;
d1=r_dif(samps)'; % some part of trhe r_diff signal
d2=detrend(d1);
s=circshift(d1,1,1);
L  = 60; % filter length
mu = .005; % learning ratio
blmsf = dsp.LMSFilter('Length',L,'StepSize',mu,'Method','Normalized LMS' );
[y,e] = blmsf(s,d1);

figure
y_lim=[-1000 10*iqr(r_dif)];
x_lim=[k0 samps(end)]/20;
subplot(2,1,1)
plot(samps/20,d1,'b'), ylim(y_lim); xlim(x_lim)
title('Overall absolute difference')
subplot(2,1,2) % show frames of the bird position
vidroi=VideoReader(f_path); % the video to read from
n_im=3; % number of frames
f_im=round(linspace(x_lim(1)*20,x_lim(end)*20,n_im))
for num_im=1:n_im
    im1=double(rgb2gray(read(vidroi, frames(f_im(num_im))))); % first x_old (in comparison)
    if num_im==1
        im_row=im1; 
    else
    im_row=[im_row im1];
    end
    imshow(uint8(im_row),'Border','tight');
end

%% a movie shows the frames as well as extracted respiration
figure,
vidroi=VideoReader(f_path); % the video to read from
f_path_resp=[folder_path '\' fname  '_ROI_RESPIRATION1.avi']; % address for the putput video
vid = VideoWriter(f_path_resp); % the video to be generated for depiction purpose
vid.FrameRate=20;
frames=50000: 51000; %%%%%%% frames to be analyzed
open(vid);
im1=double(rgb2gray(read(vidroi, frames(1)))); % first x_old (in comparison)
% difining some variables that are used in the loop
y_pixls=1:size(im1,1);  y_vals=y_pixls'/sum(y_pixls); % a vector of values from 0 to 1 with ...
% a length equal to the height of the image. Also the same for length
x_pixls=1:size(im1,2);  x_vals=x_pixls'/sum(x_pixls); 
[b,a] = butter(2,9/(20/2)); % filter for smoothing the extracted respiration ...
% inputs: cutoff , and sampling frequency


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
    pause(.0)
    im1=im2; % consider x_new as x_old for the next comparison
    dif_old=dif;
end
close(vid)











