f_path=[folder_path '\' fname '.avi']; %%%%%%%%%%%%%%%

frames=50000: 51000; %%%%%%% frames to be analyzed
roi_range=[300:924,800:1280];
[r_dif,acc_dif, last_im, last_dif] = birdvid_move_extract(f_path,frames,roi_range);

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
ylim([0 3000]) ;
