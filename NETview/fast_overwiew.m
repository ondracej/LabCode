
%% Run the code
dataDir = 'G:\Hamed\zf\71_15\18_02_2020'; % here is the directory containing the .continuous files

dataRecordingObj = OERecordingMF(dataDir);
dataRecordingObj = getFileIdentifiers(dataRecordingObj); % creates dataRecordingObject

timeSeriesViewer(dataRecordingObj); % loads all the channels