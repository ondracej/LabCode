function [] = birdvid_crop( vid, f_path_roi, ROI, frames )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function reads from video file vid and makes a cropped video with
% the ROI indicated in the input ROI. Just the frames indicated in the
% input frame will be used
% written by Hamed Yeganegi, yeganegih@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

writerObj1 = VideoWriter(f_path_roi); 
open(writerObj1);
for i=frames
    im=read(vid,i);
    imc=imcrop(im,ROI);
    writeVideo(writerObj1,imc);
end
close(writerObj1)

end

