%%%%%%%%%% if you already know the coordinates and u want toi multiply by a
%%%%%%%%%% scale

image_layout='G:\Hamed\zf\P1\73 03\electrode_placement.jpg'; %%%%%%%%%%%%%%
% xy=[95,190;85,205;67,162;60,180;61,135;109,105;77,106;112,84;156,82;156,106;188,99;200,130;...
%     193,164;205,177;166,182;178,203]; %%%%%%%%%%%%%%%%
figure
      im=imread(image_layout); %%%%%%%%% 'G:\Hamed\zf\P1\73 03\electrode_placement.jpg'
        im=.6*double(rgb2gray(imresize(im,.3)));
        imshow(int8(im)); hold on
                plot(xy(:,1),xy(:,2),'*');
                
   %  scale ratio is 1.24 for 72-00,  
   
   %%
   %%%%%%%%%%% if u want to get the coordinates by curser clicks
   
  image_layout='Z:\zoologie\HamedData\P1\72-00\72-00 layout.jpg';% 'G:\Hamed\zf\P1\73 03\electrode_placement.jpg';
  figure
  im=imread(image_layout); %%%%%%%%% 'G:\Hamed\zf\P1\73 03\electrode_placement.jpg'
  im=.6*double(rgb2gray(imresize(im,.3)));
  imshow(int8(im)); hold on
  [x,y]=ginput(16);
  xy(:,1)=x; xy(:,2)=y;
  plot(x,y,'*');