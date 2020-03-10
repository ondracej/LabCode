%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script read video in MATLAB. Lets you select some specific part of
% it, define the ROI. Finally tracks some specific points.
% lines that zou maz change manually are commented by a couple of '%' signs
% like:  x=3; %%%%%%%%
% Execute the crop cell only if you need to make a cropped video out of the
% original video because it may take ours

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% loading the video 
folder_path='G:\Hamed\zf\71_15';
fname='18_02_2020'; %%%%%%%%%%%%
vid=VideoReader([folder_path '\' fname '.avi']);
%% selecting frame range for processig
n=vid.NumFrames;
f0=721564; % 1st frame
fn=n; % last frame
% display the first frame:
im=read(vid,950000);
imshow(im)
% defining ROI
% starting from upper left side of original image
x=512;  y=309;  w=768;  h=514;  %%%%%%%%%%%
imcrop(im,[x,y,w,h]);

%% cropping the video to the ROI and frames of interest (it will take several hours)
% Attentiion: Execute the crop cell only if you need to make a cropped video out of the
% original video because it may take ours
writerObj1 = VideoWriter([folder_path '\' fname  '_ROI.avi']);
open(writerObj1);
for i=f0: fn-100
  im=read(vid,i);
  imc=imcrop(im,[x,y,w,h]);% The dimention of the new video
  writeVideo(writerObj1,imc);  
 end

close(writerObj1)
clear vid f0 x y w h imc im 
%% reading ROI video and computing consecutive differences
vidroi=VideoReader([folder_path '\' fname  '_ROI.avi']);
im1=double(rgb2gray(read(vidroi,1))); % x_old (in comparison)
acc_dif=zeros(size(im1)); % contains accumulated absolute value of consecutive differences 

% loop through frames
% difining some variables that are used in the loop
y_pixls=1:size(im1,1);  y_pixls_sum=sum(y_pixls); 
x_pixls=(1:size(im1,2))';  x_pixls_sum=sum(x_pixls); 
clear r_dif
frames=20: 30;
for i=frames
  im2=double(rgb2gray(read(vidroi,i))); % x_new
  dif=abs(im2-im1);   % difference computation
  y_dif=sum(dif,2); % difference along vertical axis
  x_dif=sum(dif,1); % difference along horizontal axis
  % computing the weighted average of moved pixels (dif) along y and x
  y_dif_mean=y_pixls*y_dif/y_pixls_sum;
  x_dif_mean=x_dif*x_pixls/x_pixls_sum;
  
  r_dif(i-frames(1)+1)=sqrt(0*x_dif_mean^2 + y_dif_mean^2);
  dif_thresh=median(dif(:)-dif_old(:)) + 8*iqr(dif(:)-dif_old(:));
  mask=(dif-dif_old>dif_thresh); % to make sure that these points are constantly changing, ...
  % not speckle noise spots
  acc_dif=acc_dif+mask.*abs(dif); % accumulated absolute value of consecutive differences
  im1=im2; % consider x_new as x_old for the next comparison
  dif_old=dif;
end
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
  plot(frames/20,r_dif); xlabel('Time (s)') ; ylim([1200 2000]) ; ylabel('Absolute body movements')



