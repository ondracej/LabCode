
close all
clear all

pathToCodeRepository = 'C:\Users\Administrator\Documents\code\GitHub\code2018\';
addpath(genpath(pathToCodeRepository)) 
%%

vidsToAnalyze = {'F:\Grass\DataShare\Overview_20190714_00032_converted.avi'};

videoDirectory=[];

V_OBJ = videoAnalysis_OBJ(vidsToAnalyze);
%% % Loads the video and gets the number of frames, time consuming for big videos
V_OBJ = testVideos(V_OBJ);
 
%% load two videos and make syncronized video
loadTwoVidsMakePlaybackVideo(V_OBJ)

%% Rename files in directory

renameFilesinDir(V_OBJ)

%% Convert video file
%startFrame = 1;
% endFrame = nan;
startFrame = 1900;
endFrame = 2150;
FrameRateOverride = 10;
 
videoName = '20190710_09-Overview_20190714_00032_converted-short';

convertWMVToAVI(V_OBJ, startFrame, endFrame, videoName, FrameRateOverride )
 
 %% Loading and downsampling a movie
 
 doDS = 1;
 dsFrameRate = 1;
 FrameRateOverride = 10;
 convert_and_compress_video_files(V_OBJ, FrameRateOverride, doDS, dsFrameRate)
 
 %% make 1 movie from images
 imageDir = {'F:\Grass\DataShare\20190705_12-22_10tadpoles-grp2\'};
 movieName = 'Basler_acA1300-60gmNIR__23037905__20190720_143455075';
 saveDir = {'F:\Grass\Tadpoles\'};
 makeMoviesFromImages(V_OBJ, imageDir, movieName, saveDir)
 
 %% make multiple movies from images
 
 imageDir = {'F:\Grass\DataShare\10-Tadpoles_20190731_15-27\'};
 movieName = '10-Tadpoles_20190731_15-27';
 saveDir = {'F:\Grass\DataShare\'};
 VideoFrameRate = 10;
 makeMultipleMoviesFromImages(V_OBJ, imageDir, movieName, saveDir, VideoFrameRate)
 
 disp('Finished making movies...')
 %% make one movie from two sets of video images
 fileFormat = 2;  % (1)- tif, (2) -.jpg
 ImgDirs = {'F:\Grass\eBUSData\20190619\20190619_16-22\Cricket2a', 'F:\Grass\eBUSData\20190619\20190619_16-22\Cricket2b'};
 makeMovieFromImages_2Videos(V_OBJ, ImgDirs, fileFormat)
 
 %% create a photo montage from video
 createMontageFromVideo(V_OBJ)
 
 %% crom image and make a photo montage
 fileFormat = 2;  % (1)- tif, (2) -.jpg
 ImgDir = {'F:\Grass\eBUSData\20190619\20190619_17-09\editedVids\Eyes\'};
 cropImageCreateMontage(V_OBJ, ImgDir, fileFormat)

 %% make a movie with a clock 
 startFrame = 120;
 endFrame = (60*60*60)/2;
 clockRate_s = 10*30;
 makeFastMoviesWithClock(V_OBJ, startFrame, endFrame, clockRate_s)
 %% calculate OF on a defined ROI (every frame)
 
 calcOFOnDefinedRegion(V_OBJ)
 
 %% Downsampled OF calculation (downsampled)
 dsFrameRate = 2;
 FrameRateOverride = 2;
 
 calcOFOnDefinedRegion_DS(V_OBJ, dsFrameRate, FrameRateOverride)
 
 disp('Finished calculating OF...')
 close all
 
 %% calculate OF, downsampled, and on multiple videos
 
 vidDir = 'F:\Grass\Tadpoles\10Tadpoles_Grp2\20190705_12-22_10tadpoles-grp2\Videos\';
 dsFrameRate = 1;
 vidFrameRate = 10;
 saveTag = '_ROI-1';
 
 calcOFOnDefinedRegion_DS_multipleFilesInDir(V_OBJ, dsFrameRate, vidDir, vidFrameRate, saveTag)
 
 %% Plotting OF detections

 vidsToAnalyze = {'F:\Grass\FrogSleep\CubanTreeFrog1\20190702\20190702_17-03\Videos\00000000_000000003880EE37.mp4'};
 detectionsDir = 'F:\Grass\FrogSleep\CubanTreeFrog1\20190702\20190702_17-03\Videos\editedVids\OF_DS-00000000_000000003880EE37\';
 StartingAlignmentTime  = '18:00:00'; % Must be the next even time
 StartingClockTime = '17:03:00'; % Must be the next even time

dsFrameRate = 1;
V_OBJ = videoAnalysis_OBJ(vidsToAnalyze);
loadOFDetectionsAndMakePlot(V_OBJ, detectionsDir, dsFrameRate, StartingClockTime, StartingAlignmentTime)


 %% Load multiple OF detections and compare over nights
  
 detectionsDir = {'F:\Grass\FrogSleep\CubanTreeFrog1\20190620\20190620_21-27\Videos\editedVids\006858C4_OF_DSs1_fullFile.mat';
                  'F:\Grass\FrogSleep\CubanTreeFrog1\20190620\20190620_21-27\Videos\editedVids\00685891_OF_DSs1_fullFile.mat'}; 
 dsFrameRate = 1;
 StartingAlignmentTime  = '23:00:00'; % Must be the next even time
 StartingClockTime = '22:58:00'; % Must be the next even time
 
 loadMultipleOFDetectionsAndMakePlot(V_OBJ, detectionsDir, dsFrameRate, StartingClockTime, StartingAlignmentTime)
 
 %% Load OF detections and make plots
 
OFdir = 'F:\Grass\FrogSleep\OFNights\';
% OFdir = 'F:\Grass\FrogSleep\OFDays\';
 dsFrameRate = 1;
 loadDetectionsAcrossDaysAndMakePlots(V_OBJ, OFdir, dsFrameRate)
 
 %% calculating mvmnt, not working
  
OFdir = 'F:\Grass\FrogSleep\OFNights\';
% OFdir = 'F:\Grass\FrogSleep\OFDays\';
dsFrameRate = 1;

loadDetectionsCalcMvmtAcrossDaysAndMakePlots(V_OBJ, OFdir, dsFrameRate)

 
%% calc OF with two ROIs and make video
 
 calcOFandMakeVideo_2ROIs(V_OBJ)
 disp('Finished...')
 
 %% calc OF with one ROIs and make video
 calcOFandMakeVideo_1ROIs(V_OBJ)
 
 %%