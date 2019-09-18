function [col]=opt_color(n)

% Example:
% a plot of 20 random line plots optimally! colored:
% x=1:100;
% y=randn(20,100); 
% cols=opt_color(50)/255;
% figure;
% hold on
% for k=1:20
% plot(x, y(k,:)+2*k , 'color', cols(k,:)); 
% end

% Description
% this function produces a matrix of RGB colorblinded-friendly colors.
% It starts from a set of already-designated colors to be
% differentiable for color-blindedd people (sourse: http://mkweb.bcgsc.ca/biovis2012/)
% if more colors are needed the functions interpolates to generates more
% colors

base_colors=[
    0   0   0
    0  73  73
    0  146  146
    255 109 182
    255 182 119
    73  0  146
    0  109 219
    182 109 255
    109 182 255
    182 219 255
    146 0   0
    146 73  0
    219 209 0
    36  255 36
    255 255 109];
if n<=15
    col=base_colors(1:n,:);
else
    R=interp1(1:15,base_colors(:,1),(1:n)*14/(n-1)+(n-15)/(n-1));
    G=interp1(1:15,base_colors(:,2),(1:n)*14/(n-1)+(n-15)/(n-1));
    B=interp1(1:15,base_colors(:,3),(1:n)*14/(n-1)+(n-15)/(n-1));
    col=[R' G' B'];
end
col=col/255; % scaling to be in range [0 1]
end