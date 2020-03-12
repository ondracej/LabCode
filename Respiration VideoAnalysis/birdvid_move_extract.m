function [r_dif,acc_dif, last_im, last_dif] = birdvid_move_extract(f_path,frames)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function gives the position (the r in polar coordinates) of the
% center of differences in two consecutive frames and also the overall
% accumulated differences across all frames
% written by Hamed Yeganegi, yeganegih@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vidroi=VideoReader(f_path); 
im1=double(rgb2gray(read(vidroi, frames(1)))); % first x_old (in comparison)
acc_dif=zeros(size(im1)); % contains accumulated absolute value of consecutive differences 

% difining some variables that are used in the loop
y_pixls=1:size(im1,1);  y_vals=y_pixls'/sum(y_pixls); % a vector of values from 0 to 1 with ...
% a length equal to the height of the image. Also the same for length
x_pixls=1:size(im1,2);  x_vals=x_pixls'/sum(x_pixls); 
% loop through frames
im1=double(rgb2gray(read(vidroi, frames(1)))); % first x_old (in comparison)
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
  
  
  % this section of the loop is for the acc_diff (accumulated differences) that shows all of the
  % movements occuring during the specific frames of the video. It just
  % does not accumulate the whole differences in all single frames because
  % there are many speckle random points that are different in two
  % following frames. So we also make a mask and filter out the single
  % points thatt their change doesnt seem to be consistent in time. To do
  % that we compare the current difference matrix with the previous one and
  % consider a point as REAL difference only if it appears in both of these
  % matrices
  if i==frames(2), dif_old=zeros(size(dif)); end
  avg_dif=(dif+dif_old)/2;
  dif_thresh=median(avg_dif) + 8*iqr(avg_dif); % threshold for considering a point as..
  % a consistant difference
  mask=avg_dif>dif_thresh; % to make sure that these points are constantly changing, ...
  % at least in 2 consecutive frames, not just speckle noise spots
  acc_dif=acc_dif+mask.*abs(dif); % accumulated absolute value of consecutive differences
  im1=im2; % consider x_new as x_old for the next comparison
  dif_old=dif;
end
last_im=im1;
last_dif=dif;
end

