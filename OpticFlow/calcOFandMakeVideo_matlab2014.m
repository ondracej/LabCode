function [] = calcOFandMakeVideo()
dbstop if error

if isunix
    dirD = '/';
elseif ispc
    dirD = '\';
end

%% Input video data
%select directory of the video file to analyze
VidDir = 'C:\Users\user\Documents\TUM_BIOLOGIE_STUDIUM_BACHELOR\Bachelor_Thesis\Matlab_test_optical_flow\'; 
% Specify the video
videoToAnalyze = 'turtletest.avi'; 
addpath(VidDir)
AnalysisNumber = 1; % in case you want to analyze several versions

%% Define Analysis Directory
% Select the output directory
OFDir = 'C:\Users\user\Documents\TUM_BIOLOGIE_STUDIUM_BACHELOR\Bachelor_Thesis\Matlab_test_optical_flow\'; 
% In case the directory doesn't exist yet, creating it
if exist(OFDir, 'dir') == 0
    mkdir(OFDir);
end

%% Load the Video

vidToLoad = [VidDir videoToAnalyze]; % might need a '.avi' for windows

[pathstr,name,ext] = fileparts(vidToLoad);

OFSaveName = ['OF-FullFile-' name '__' sprintf('%02d',AnalysisNumber)];

%% Reading in Video and calculatate optic flow 

VideoObj = VideoReader(vidToLoad)%, 'Tag', 'CurrentVideo');

nFrames = VideoObj.NumberOfFrames;
VideoFrameRate = VideoObj.FrameRate;
vidHeight = VideoObj.Height;
vidWidth = VideoObj.Width;
vidFormat = VideoObj.VideoFormat;

% Specifying the videoreader and create required video object
videoReader = vision.VideoFileReader(vidToLoad,'ImageColorSpace','Intensity','VideoOutputDataType','uint8');
%converter = im2uint8(I); 
% Calculating two windows for the optical flow by the use of the Lucas-Kanade method for optic flow determination, individual ajustments on the noise threshold might be useful 
opticalFlow1 = opticalFlowLK('NoiseThreshold',0.09);
opticalFlow2 = opticalFlowLK('NoiseThreshold',0.09);

% Creating a counter for stepping through each frame
mCnt = 1;
disp('Extracting frames and calculating the optical flow...')
close all
%% Stepping through each single frame and calculate the optical flow
FrameOn = 1;
FrameOff = nFrames;
for frame_ind = FrameOn+1 : FrameOff
    mov(mCnt).cdata = read(VideoObj,frame_ind);
    frame = mov(mCnt).cdata;
    im = im2uint8(frame);
    if mCnt == 1
        figure(1)
        % Open the first frame for ROI1
        imshow(im)
        disp('Select 1st ROI')
        % Choose 1st Region of Interest (ROI)
        rectim1 = getrect; %choose 1st ROI
        rectim1=ceil(rectim1); 
        figure(2)
        % Open the first frame for ROI2
        imshow(im)
        disp('Select 2nd ROI')
        drawnow;
        % Choose 2nd ROI
        rectim2 = getrect;
        rectim2=ceil(rectim2);
        
        % Starting a counter to measure the time for the calculation
        tic
    end
        im1 = im(rectim1(2):rectim1(2)+rectim1(4),rectim1(1):rectim1(1)+rectim1(3)); %choose this ROI part of the frame to calculate the optic flow
        im2 = im(rectim2(2):rectim2(2)+rectim2(4),rectim2(1):rectim2(1)+rectim2(3));
        of1 = estimateFlow(opticalFlow1,im1);
        of2 = estimateFlow(opticalFlow2,im2);
        
        % Magnitude of the optical flow in ROI1
        VM1 = abs(of1.Magnitude);
        % Length of the x-velocity vector in ROI1
        VX1 = abs(of1.Vx);
        % Length of the y-velocity vector in ROI1
        VY1 = abs(of1.Vy);
        % Magnitude of the optical flow in ROI1
        VM2 = abs(of1.Magnitude);
        % length of the x-velocity vector in ROI2
        VX2 = abs(of2.Magnitude);
        % length of the y-velocity vector in ROI2
        VY2 = abs(of2.Vy);
        
        % mean magnitude for every pixel in ROI1
        meanVM1=mean(mean(VM1));
        % Stepping through each frame
        fVM1(mCnt)=meanVM1;
        % mean velocity in x direction for every pixel in ROI1
        meanVX1=mean(mean(VX1));
        % Stepping through each frame
        fVX1(mCnt)=meanVX1;
        % mean velocity in y direction for every pixel in ROI1
        meanVY1=mean(mean(VY1));
        % Stepping through each frame
        fVY1(mCnt)=meanVY1;
        % mean magnitude for every pixel in ROI2
        meanVM2=mean(mean(VM2));
        % Stepping through each frame
        fVM2(mCnt)=meanVM2;
        %mean velocity in x for every pixel in ROI2
        meanVX2=mean(mean(VX2)); 
        fVX2(mCnt)=meanVX2;
        %mean velocity in y for every pixel in ROI2
        meanVY2=mean(mean(VY2)); 
        fVY2(mCnt)=meanVY2;
        mCnt =mCnt +1;
        disp(strcat('Frame: ',num2str(frame_ind ),' is done'));
end
% Suppressing artifact at the first frame
fVM1(1)=0;
fVX1(1)=0; 
fVY1(1)=0; 
fVM2(1)=0;
fVX2(1)=0;
fVY2(1)=0; 

 % Ending the time counter
 toc

%% Creating a moving line for plotting the velocities of the optical flow

redcolor = [150 50 0];
bluecolor = [0 50 150];
graycolor = [70 70 70];

redcolorline = [150 50 0]/255;
bluecolorline = [0 50 150]/255;
graycolorline = [70 70 70]/255;

timepoints = (FrameOn:1:FrameOff-1)/25; %in seconds, "/25" corresponds to the framerate, for a different framerate of the input video change this value accordingly

close all

%% Creating a plot for the magnitude of the optical flow for ROI1
fVM1=fVM1./(max(max(fVM1)));
% Open a new window to display fVM1
fig100= figure(100); plot(fVM1) 

fcnt = 1;

for p = 1:numel(timepoints)
    cla
    plot(timepoints, fVM1, 'color', bluecolorline)
    %plot(timepoints, smooth(fV1, smoothWin) , 'color', bluecolorline)
    title('Mean magnitude for ROI1');
    hold on
    line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
    axis tight
    xlabel('Time [s]')
    ylabel('Intensity')
     ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
    FM1(fcnt) = getframe(ax,rect);     
    fcnt = fcnt+1;
end
%close(fig100)
%% Creating a plot for the x-velocity vectors for ROI1
fVX1=fVX1./(max(max(fVX1)));

fig200= figure(200); plot(fVX1)

fcnt = 1;

for p = 1:numel(timepoints)
    cla
    plot(timepoints, fVX1, 'color', bluecolorline)
    %plot(timepoints, smooth(fV1, smoothWin) , 'color', bluecolorline)
    title('Mean x-velocity for ROI1');
    hold on
    line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
    axis tight
    xlabel('Time [s]')
    ylabel('Intensity')
     ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
    FX1(fcnt) = getframe(ax,rect);     
    fcnt = fcnt+1;
%   hold off
end

%% Creating a plot for the y-velocity vector for ROI1
fVY1=fVY1./(max(max(fVY1)));

fig300= figure(300); plot(fVY1)

fcnt = 1;

for p = 1:numel(timepoints)
    cla
    plot(timepoints, fVY1, 'color', bluecolorline)
    title('Mean y-velocity for ROI1');
    hold on
    line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
    axis tight
    xlabel('Time [s]')
    ylabel('Intensity')
     ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
    FY1(fcnt) = getframe(ax,rect);
    fcnt = fcnt+1;
end

%% Creating a plot for the magnitude of the optical flow for ROI2
fVM2=fVM2./(max(max(fVM2)));

fig400= figure(400); plot(fVM2)

fcnt = 1;

for p = 1:numel(timepoints)
    cla
    plot(timepoints, fVM2, 'color', redcolorline)
    %plot(timepoints, smooth(fV1, smoothWin) , 'color', bluecolorline)
    title('Mean magnitude for ROI2');
    hold on
    line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
    axis tight
    xlabel('Time [s]')
    ylabel('Intensity')
     ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
    FM2(fcnt) = getframe(ax,rect);     
    fcnt = fcnt+1;
end

%% Creating a plot for the x-velocity vector for ROI2
fVX2=fVX2./(max(max(fVX2)));

fig500= figure(500); plot(fVX2)

fcnt = 1;

for p = 1:numel(timepoints)
    cla
    plot(timepoints, fVX2, 'color', redcolorline)
    %plot(timepoints, smooth(fV1, smoothWin) , 'color', bluecolorline)
    title('Mean x-velocity for ROI2');
    hold on
    line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
    axis tight
    xlabel('Time [s]')
    ylabel('Intensity')
     ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
    FX2(fcnt) = getframe(ax,rect);
    fcnt = fcnt+1;
end
%% Creating a plot for the y-velocity vector for ROI2
fVY2=fVY2./(max(max(fVY2)));

fig600= figure(600); plot(fVY2)

fcnt = 1;

for p = 1:numel(timepoints)
    cla
    plot(timepoints, fVY2, 'color', redcolorline)
    %plot(timepoints, smooth(fV1, smoothWin) , 'color', bluecolorline)
    hold on
    line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
    title('Mean y-velocity for ROI2');
    hold on
    line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
    axis tight
    xlabel('Time [s]')
    ylabel('Intensity')
    axis tight
     ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
    FY2(fcnt) = getframe(ax,rect);
    fcnt = fcnt+1;
end
%% 
OF.fVM1 = fVM1;
OF.fVX1 = fVX1;
OF.fVY1 = fVY1;
OF.fVM2 = fVM2;
OF.fVX2 = fVX2;
OF.fVY2 = fVY2;
save([pathstr dirD 'OF-' OFSaveName '__ROIs.mat'], 'OF');

%% Saving
plot_filenameVid = [pathstr dirD 'OF_VID-' name '.avi'];

vid1 = VideoReader(vidToLoad, 'Tag', 'CurrentVideo');
outputVideo = VideoWriter(plot_filenameVid);
outputVideo.FrameRate = VideoFrameRate ; 
open(outputVideo);

%shapeInserter1 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32([0 0 255]));

shapeInserter1 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32(bluecolor));
shapeInserter2 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32(redcolor));
rectim1 = int32(rectim1);
rectim2 = int32(rectim2);

%% create a nice video output by concatenating images 
 disp('Optical flow frame grabbing...')

i=1;
for frame_ind = FrameOn+1 : FrameOff -1
    img1 = read(vid1,frame_ind);
    img1 = step(shapeInserter1,img1,rectim1); %insert the ROIs
    img1 = step(shapeInserter2,img1,rectim2); %insert the ROIs
    
    img2 = FY2(i).cdata;
    img3 = FY1(i).cdata;
    img2 = imresize(img2,[size(FY1(1).cdata,1) size(FY1(1).cdata,2)]);
   
    img4 = vertcat(img2,img3);
    scale=size(img4,1)/size(img1,1);
    img5 = imresize(img1,scale);
    img5 = imresize(img5,[size(img4,1) size(img5,2)]);
    imgf = horzcat(img5,img4);

    % play video
    %videoPlayer(imgf);

    % record new video
    writeVideo(outputVideo, imgf);
    i=i+1;
end
close(outputVideo);
disp('Done!')


end