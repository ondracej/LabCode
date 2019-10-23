function [] = calcDifferenceFrameandMakeVideoOri()

dbstop if error

if isunix
    dirD = '/';
elseif ispc
    dirD = '\';
end

%% Input video data
VidDir = 'C:\Users\user\Documents\TUM_BIOLOGIE_STUDIUM_BACHELOR\Bachelor_Thesis\Matlab_test_optical_flow\';
videoToAnalyze = 'turtletest.avi';
addpath(VidDir)
AnalysisNumber = 1; % in case you want to analyze several versions

%% Define Analysis Directory

OFDir = 'C:\Users\user\Documents\TUM_BIOLOGIE_STUDIUM_BACHELOR\Bachelor_Thesis\Matlab_test_optical_flow\';

if exist(OFDir, 'dir') == 0
    mkdir(OFDir);
end

%% Load Video

vidToLoad = [VidDir videoToAnalyze]; % might need a '.avi' for windows

[pathstr,name,ext] = fileparts(vidToLoad);

OFSaveName = ['DF-FullFile-' name '__' sprintf('%02d',AnalysisNumber)];

%% Reading in Video and calculatate optic flow 

VideoObj = VideoReader(vidToLoad)%, 'Tag', 'CurrentVideo');

nFrames = VideoObj.NumberOfFrames;
VideoFrameRate = VideoObj.FrameRate;
vidHeight = VideoObj.Height;
vidWidth = VideoObj.Width;
vidFormat = VideoObj.VideoFormat;

videoReader = vision.VideoFileReader(vidToLoad,'ImageColorSpace','Intensity','VideoOutputDataType','uint8'); % create required video objects

mCnt = 1;
disp('Extracting frames and calculating the gray value difference...')
close all
%%
FrameOn = 1;
FrameOff = nFrames;
for frame_ind = FrameOn+1 : FrameOff
    mov(mCnt).cdata = read(VideoObj,frame_ind);
    frame = mov(mCnt).cdata;
    im = im2uint8(frame);
    if mCnt == 1
        figure(1)
        imshow(im) %open the first frame
        disp('Select 1st ROI')
        %rectim1 = getrect; %choose 1st ROI
        rectim1 = getrect; %choose 1st ROI
        rectim1=ceil(rectim1); 
        figure(2)
        imshow(im) %open the first frame
        disp('Select 2nd ROI')
        drawnow;
        rectim2 = getrect; %choose 2nd ROI
        rectim2=ceil(rectim2);
        %im11 = im(rectim1(2):rectim1(2)+rectim1(4),rectim1(1):rectim1(1)+rectim1(3)); %choose this ROI part of the frame to calculate the optic flow
        %im21 = im(rectim2(2):rectim2(2)+rectim2(4),rectim2(1):rectim2(1)+rectim2(3));
        %mCnt = 2;
        % Starting a counter to measure the time for the calculation
        tic
    end
        im1 = im(rectim1(2):rectim1(2)+rectim1(4),rectim1(1):rectim1(1)+rectim1(3)); %choose this ROI part of the frame to calculate the optic flow
        im2 = im(rectim2(2):rectim2(2)+rectim2(4),rectim2(1):rectim2(1)+rectim2(3));
        
        %% Calculating the difference between two frames
        % For ROI1:
        DF1 = imsubtract(im1(mCnt),im1(mCnt+1));
        % Using the 2D Wiener-filter to remove noise, might need to set
        % individual threshold values where [m n] give the size of the
        % neighbourhood pixels, standard is [3 3], noise value was set to
        % 0.09
        dwf1 = wiener2(DF1,[3 3],0.09);
        % Alternative median filter:
%         df1 = medfilt2(DF1,[2 2]);
        
        % For ROI2:
        DF2 = imsubtract(im2(mCnt),im2(mCnt+1));
        dwf2 = wiener2(DF2,[3 3],0.09);
%         df2 = medfilt2(DF2,[2 2]);
        
        df1 = abs(dwf1);
        df2 = abs(dwf2);
        
        dV1(mCnt)=df1;
        dV2(mCnt)=df2;

        mCnt =mCnt +1;
        disp(strcat('Frame: ',num2str(frame_ind ),' is done'));
  
end
dV1(1)=0;% suppress the artifact at the first frame 
dV2(1)=0; 

% Ending the time counter
 toc

%% Plot the optic flow with a moving line
dV1=dV1./(max(max(dV1)));

redcolor = [150 50 0];
bluecolor = [0 50 150];

redcolorline = [150 50 0]/255;
bluecolorline = [0 50 150]/255;

timepoints = (FrameOn:1:FrameOff-1)/25; %in seconds, "/25" corresponds to the framerate, for a different framerate of the input video change this value accordingly

close all

fig100= figure(100); plot(dV1)
fcnt = 1;

for p = 1:numel(timepoints)
    cla
    plot(timepoints, dV1, 'color', bluecolorline)
    %plot(timepoints, smooth(fV1, smoothWin) , 'color', bluecolorline)
    hold on
    line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
    title('Mean Gray Levels for ROI1');
    axis tight
    xlabel('Time [s]')
    ylabel('Intensity')
    ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
    F1(fcnt) = getframe(ax,rect);
    fcnt = fcnt+1;
end

%close(fig100)

dV2=dV2./(max(max(dV2)));
fig200 = figure(200); plot(dV2)
fcnt = 1;

for p = 1:numel(timepoints)
    cla
    plot(timepoints, dV2, 'color', redcolorline)
    hold on
   line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
   title('Mean Gray Levels for ROI2');
    axis tight
    xlabel('Time [s]')
    ylabel('Intensity')
    ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
    F2(fcnt) = getframe(ax,rect);
    fcnt = fcnt+1;
end
%close(fig200);
%%

DF.dV1 = dV1;
DF.dV2 = dV2;
save([pathstr dirD 'DF-' OFSaveName '__ROIs.mat'], 'DF');

%% Saving
plot_filenameVid = [pathstr dirD 'DF_VID-' name '.avi'];

vid1 = VideoReader(vidToLoad, 'Tag', 'CurrentVideo');
outputVideo = VideoWriter(plot_filenameVid);
outputVideo.FrameRate = VideoFrameRate; 
open(outputVideo);

shapeInserter1 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32(bluecolor));
shapeInserter2 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32(redcolor));
rectim1 = int32(rectim1);
rectim2 = int32(rectim2);

%% create a nice video output by concatenating images 
 disp('Difference frame grabbing')

i=1;
for frame_ind = FrameOn+1 : FrameOff -1
    img1 = read(vid1,frame_ind);
    img1 = step(shapeInserter1,img1,rectim1); %insert the ROIs
    img1 = step(shapeInserter2,img1,rectim2); %insert the ROIs
    
    img2 = F1(i).cdata;
    img3 = F2(i).cdata;
    img2 = imresize(img2,[size(F2(1).cdata,1) size(F2(1).cdata,2)]);
   
    img4 = vertcat(img2,img3);
    scale=size(img4,1)/size(img1,1);
    img5 = imresize(img1,scale);
    img5 = imresize(img5,[size(img4,1) size(img5,2)]);
    imgf = horzcat(img5,img4);

     %play video
%      videoFReader = vision.VideoFileReader(vid1);
%      videoPlayer = vision.VideoPlayer;

    % record new video
    writeVideo(outputVideo, imgf);
    i=i+1;
end
close(outputVideo);
disp('Done!')

end