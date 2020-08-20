%%%%%%%%%% if you already know the coordinates and u want toi multiply by a
%%%%%%%%%% scale

image_layout='C:\Users\Spike Sorting\Desktop\w0009-3.jpg';
xy=round([285 498; 195 541; 223 444; 144 449; 152 372; 201 279; 275 237 ; ...
          276 304; 403 306; 409 236; 503 285; 545 386; 494 447; 568 458; 410 492; 518 534]*1.21*.3); % the coeff is for...
figure
      im=imread(image_layout); %%%%%%%%% 'G:\Hamed\zf\P1\73 03\electrode_placement.jpg'
        im=.6*double(rgb2gray(imresize(im,.3)));
        imshow(int8(im)); hold on
                plot(xy(:,1),xy(:,2),'*');
                
   %  scale ratio is 1.24 for 72-00,  
   
   %%
   %%%%%%%%%%% if u want to get the coordinates by curser clicks
   
  image_layout='C:\Users\Spike Sorting\Desktop\w0009-3.jpg';
  figure
  im=imread(image_layout); %%%%%%%%% 'G:\Hamed\zf\P1\73 03\electrode_placement.jpg'
  im=.6*double(rgb2gray(imresize(im,.3)));
  imshow(int8(im)); hold on
%   [x,y]=ginput(16);
  xy(:,1)=x; xy(:,2)=y;
  plot(x,y,'*');