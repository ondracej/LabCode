%% Create a detector object for tracking body movements.

%% creating the object for video file
vid_add='G:\Data\zf-71-76\Zoom2_00010_standard.avi';
% Create System objects for reading and displaying video and for drawing a bounding box of the object.
videoFileReader = vision.VideoFileReader(vid_add);
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
% Read the first video frame, which contains the object, define the region.
objectFrame = videoFileReader();


%% following commands to select the object region using mouse. The object must occupy the majority of the region:
figure; imshow(objectFrame);
% select the object region using a mouse. The object must occupy the majority of the region:
figure; imshow(objectFrame);
objectRegion=round(getPosition(imrect)); % creat draggle rectangle around the ROI
% Show initial frame with a red bounding box.
objectImage = insertShape(objectFrame,'Rectangle',objectRegion,'Color','red');
figure;
imshow(objectImage);
title('Red box shows object region');


%% Select interest points in the object region.
InitPoints = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion);
% Display the detected points.
pointImage = insertMarker(objectFrame,InitPoints.Location,'+','Color','white');
figure;
imshow(pointImage);
title('Detected interest points');

% Reducing points of interestin tracking
% Preselect a subset of points that have more variance over time to reduce
% computational cost
% we track points for a few frames and compute the movements of all point.
% then based on movabilities, we decide on Points of Interest (most vibrants) 
tracker_dummy = vision.PointTracker('MaxBidirectionalError',1);
% Initialize the tracker.
initialize(tracker_dummy,InitPoints.Location,objectFrame);
LastValid=InitPoints.Location; % keeps the last detectable stat of a point, since some points may temporary be hidden in some frames
n=1;
PointMoves=zeros(length(InitPoints),1);
while n<40 % just for a limited number of frames
      frame = videoFileReader();
      [points,validity] = tracker_dummy(frame);
      out = insertMarker(frame,points(validity, :),'+');
	  videoPlayer(out);
      NewLastValid(validity,:)=points(validity,:);
      % summing up movements of any tracked point
      for k=1:length(LastValid)
      dist(k)=norm(LastValid(k,:)-NewLastValid(k,:));
      end
      PointMoves= PointMoves + dist';
      LastValid=NewLastValid;
      n=n+1;
end

 move_thr=median(PointMoves)+iqr(PointMoves);
 BestPointIndx=PointMoves>move_thr;
 BestPoints=points(BestPointIndx, :);
 out = insertMarker(frame,BestPoints,'+');
 figure
 imshow(out);
 clear dist
%% Creating a tracker object and tracking points through time.
tic

tracker = vision.PointTracker('MaxBidirectionalError',1);
% Initialize the tracker.
initialize(tracker,InitPoints.Location,objectFrame);

% Read, track, display points, and results in each video frame.
LastValid=InitPoints.Location; % keeps the last detectable stat of a point, since some points may temporary be hidden in some frames
n=1;
while n<1000 %~isDone(videoFileReader)
      frame = videoFileReader();
      [points,validity] = tracker(frame);
%       out = insertMarker(frame,points(validity, :),'+');
%       videoPlayer(out);
      NewLastValid(validity,:)=points(validity,:);
      
      % summing up movements of any tracked point
      bird_move(n)=0;
      for k=1:length(LastValid)
      bird_move(n)=bird_move(n)+norm(LastValid(k,:)-NewLastValid(k,:));
      end
      
      LastValid=NewLastValid;
      n=n+1;
end
% Release the video reader and player.


release(videoPlayer);
release(videoFileReader);

TrackinTime=toc

figure
plot((1:999)*.1,bird_move)
clear bird_move