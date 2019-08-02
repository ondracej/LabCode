
dir = 'F:\TUM\SWR-Project\Chick-10\Ephys\2019-04-27_22-20-26'; % dir containing .continuous files

dir = 'F:\Grass\FrogSleep\CubanTreeFrog1\CubanTF1_2019-07-25_20-20-58';
%%
dataRecordingObj = OERecordingMF(dir);
dataRecordingObj = getFileIdentifiers(dataRecordingObj); % creates dataRecordingObject

%% Run the time series viewer gui
timeSeriesViewer(dataRecordingObj); % loads all the channels

%% Extract specific snippets of data
%[tmpV, t_ms] =dataRecordingObj.getData(chan, timeOnset_ms, dataDuration_ms);
[tmpV, t_ms] = dataRecordingObj.getData(5,1,20000);

