function [] = birdvid_crop( vid, f_path_roi, ROI, frames )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function reads from video file vid and makes a cropped video with
% the ROI indicated in the input ROI. Just the frames indicated in the
% input frame will be used
% written by Hamed Yeganegi, yeganegih@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f = waitbar(0,'Initialization for ROI video...'); % the wait bar indicates number...
% of frames processed
pause(.2)
writerObj1 = VideoWriter(f_path_roi);
open(writerObj1);

for i=frames
    im=read(vid,i);
    imc=imcrop(im,ROI);
    writeVideo(writerObj1,imc);
    if rem(i,1000)==0
        disp(['Frame ' num2str(i) ' was added to the ROI video...']);  % every 5000 ...
        % frame print the frame number
        waitbar(i/length(frames),f,['frame ' num2str(i) ' was added to the ROI video...']);           
    end
end
close(writerObj1)
close(f)
end

