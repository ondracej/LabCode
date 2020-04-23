k0=20001;
lim=1000;
d1=r_dif(samps)'; % some part of trhe r_diff signal

figure('Renderer', 'painters', 'Position', [40 40 1400 1100])
y_lim=[-1000 3000];
x_lim=[k0 lim*20]/20;
for k=1:1:lim
    samps=k0:k*20;
    d1=r_dif(samps)'; % some part of trhe r_diff signal



subplot(2,1,1)
plot(samps/20,d1,'b'), ylim(y_lim); xlim(x_lim)
title('Overall absolute difference')
subplot(2,1,2) % show frames of the bird position
vidroi=VideoReader(f_path); % the video to read from
im1=double(rgb2gray(read(vidroi, frames(k*20)))); % first x_old (in comparison)
imshow(uint8(im1),'Border','tight');

end