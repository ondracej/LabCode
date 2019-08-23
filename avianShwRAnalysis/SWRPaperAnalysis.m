%avianSWRAnalysis_SCRIPTS

close all
clear all
dbstop if error

% Code dependencies
pathToCodeRepository = 'C:\Users\Administrator\Documents\code\GitHub\code2018\';
pathToOpenEphysAnalysisTools = 'C:\Users\Administrator\Documents\code\GitHub\analysis-tools\';
%pathToNSKToolbox = 'C:\Users\Administrator\Documents\code\GitHub\code2018\NSKToolBox\';
pathToNSKToolbox = 'C:\Users\Administrator\Documents\code\GitHub\NET\';

addpath(genpath(pathToCodeRepository)) 
addpath(genpath(pathToOpenEphysAnalysisTools)) 
addpath(genpath(pathToNSKToolbox)) 


%% Define Session

%% Metal Electrode

%% Chick-09 | 1 MOhm Electrode in DVR, EKG, Temp noted down
%% 33 - 53




%% 16 Ch Silicon Probes

%% Chick-10 | 16-ch silicone probe in DVR (55-58)

% 55 coords_DV  = 3000;
% 56 coords_DV  = 4000;
% 57 coords_DV  = 4000;
% 58 coords_DV  = 4000;

%% ZF-59-15 | 16-ch silicone probe in DVR (59 - 63)

% 59 coords_DV  = 2000;
% 60 coords_DV  = 2500;
% 61 coords_DV  = 3000;
% 62 coords_DV  = 3500;
% 63 coords_DV  = 1500; % largest = ch 2

%% ZF-60-88 |  16-ch silicone probe in DVR (64 - 75)
% 64 coords_DV  = 1000; % 7 best chan, 5, 4, 6, 3, 9, 16 out of brain?
% 65 coords_DV  = 1000; % 2 best chan, 5:1 are inverted
% 66 coords_DV  = 2000; % spikes: 3, 16, 13, best LFP; 9, 16, 8, 1
% 67 coords_DV  = 2500;
% 68 coords_DV  = 3000;
% 69 coords_DV  = 3500;
% 70 coords_DV  = 4000;
% 71 coords_DV  = 1000; %% Inversion - very nice
% 72 coords_DV  = 1500;
% 73 coords_DV  = 2000;
% 74 coords_DV  = 3000; Cerebellum
% 75 coords_DV  = 3000; NCNM? bird died

%% LFP and EEG

%% ZF-72-81 | 2 LFP, 2 EEG (76 - 82)
% 9,10,11 LFP 1;
% 13,14,15,16 LFP2;
% 2,3 EEG1;
% 6,7 EEG2

% 76 coords_DV  = 2000; under isoflorane
% 77 coords_DV  = 2000; under isoflorane
% 78 coords_DV  = 2000;  1.5% under anesthesia';
% 79 coords_DV  = 2000; 'no isoflurane, 0%';
% 80 coords_DV  = 2000; chronic waking up
% 81 coords_DV  = 2000; chronic night
% 82 coords_DV  = 2000; chronic overnight


% 2, 3, 6, 7, 9, 10, 13, 14
%% ZF-70-86 | 2 LFP, 4 EEG (83 - 89)
%8, 10 LFP;
% 2, 12, 16, 6, 14, 5 EEG;
%4 EMG

% 83
% 84 %- too short
% 85 %- too short
% 86 %- too short
% 87
% 88
% 89
dataDir = 'F:\TUM\SWR-Project\ZF-70-86\eeg-lfpChronic_2019-05-24_19-12-50';

% 4, 2, 14, 12, 16, 6, 5, 10, 8

%% Make Channel Map

% saveDir = 'C:\Users\Administrator\Documents\code\GitHub\NET\timeSeriesViewer\electrode layouts\layout_16_A16_5mm_wAdapter.mat';
% 
% En = [5 4 6 3 9 16 8 1 11 14 12 13 10 15 7 2]';
% Ena = [5 4 6 3 9 16 8 1 11 14 12 13 10 15 7 2]';
% Enp = [];
% 
% save(saveDir, 'En', 'Ena', 'Enp')


%% Define Record

%% CSD analysis

allRecSessions = [55:75];
for j = 1:numel(allRecSessions)
    
    recSession = allRecSessions(j);
    
    D_OBJ = avianSWRAnalysis_OBJ(recSession);
    disp([D_OBJ.INFO.birdName ': ' D_OBJ.Session.time])
    
    %
    dataDir = D_OBJ.Session.SessionDir;
    dataRecordingObj = OERecordingMF(dataDir);
    dataRecordingObj = getFileIdentifiers(dataRecordingObj); % creates dataRecordingObject
    calcCSD(D_OBJ, dataRecordingObj)
end

%%
timeSeriesViewer(dataRecordingObj); % loads all the channels


%5, 4, 6, 3, 9, 16, 8, 1, 11, 14, 12, 13, 10, 15, 7, 2
%LFP scale = 500
%Spike scale = 150
%timeWin = 40000

%% Sharp Wave Detection
%detectSWRs(D_OBJ, dataRecordingObj)

%ZF
recSession = 67;
chan = 5; % 67

%Chick
recSession = 58;
chan = 2; % 57

D_OBJ = avianSWRAnalysis_OBJ(recSession);
disp([D_OBJ.INFO.birdName ': ' D_OBJ.Session.time])

%
dataDir = D_OBJ.Session.SessionDir;
dataRecordingObj = OERecordingMF(dataDir);
dataRecordingObj = getFileIdentifiers(dataRecordingObj); % creates dataRecordingObject

D_OBJ = detectSWRs_SleepAnalysisObj(chan, D_OBJ, dataRecordingObj);

%%
plotConsecutiveSWRs(D_OBJ, dataRecordingObj);

%%

calcCSD(D_OBJ, dataRecordingObj)



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Multi-channel Plot

%doPlot = 1; % Make and print plots
%seg_s = 50; % segment to plot (in s)

%D_OBJ = batchPlotDataForOpenEphys_multiChannel(D_OBJ, doPlot, seg_s);
D_OBJ = batchPlotDataForOpenEphys_multiChannel(D_OBJ); % default is doPlot, 40s
disp('Finished plotting')

%% Single Channel Plot

%D_OBJ = batchPlotDataForOpenEphys_singleChannel(D_OBJ, doPlot, seg_s); % default is doPlot, 40s
D_OBJ = batchPlotDataForOpenEphys_singleChannel(D_OBJ); % default is doPlot, 40s
 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Pre-processing for Sebastian's ShWR detections
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FullFile - creates a "_py_fullFile"

%chanOverride = 7;
%D_OBJ = prepareDataForShWRDetection_FullFile_Python(D_OBJ, chanOverride); 
[D_OBJ] = prepareDataForShWRDetection_FullFile_Python(D_OBJ);

%% Do NOT USE - use fullfile option for now
%chanOverride = [];
%durOverride = [];

%D_OBJ  = prepareDataForShWRDetection_Python(D_OBJ, chanOverride, durOverride);
%D_OBJ  = prepareDataForShWRDetection_Python(D_OBJ);

%% Confirm Detections - not actually using this for now....

% This should be in the code/SWR/Data directory % export_ripples, copy back into directory
%confirmSWR_PythonDetections(D_OBJ) % I cannot figure out how to include this in the analysis object...

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SWR Plotting
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Mean shape, saves the snippets for the detections "SWR_data.mat"


%% Remember to change the data name to x_data

useNotch =0;

[D_OBJ] = SWR_PythonDetections_shapeStatistics(D_OBJ, useNotch );

pathToChronuxToolbox = 'C:\Users\Administrator\Documents\code\GitHub\chronux\';
addpath(genpath(pathToChronuxToolbox)) 

%% Wavelet
waveletInd = 5;
useNotch = 1;
[D_OBJ] = SWR_wavelet(D_OBJ, waveletInd, useNotch );

%% Frequency raster
binSize_s = 15;
[D_OBJ] = SWR_raster(D_OBJ, binSize_s);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Spikesorting with KiloSort
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Make sure the Phy is closed before running!!!
% 
% pathToKiloSort = 'C:\Users\Administrator\Documents\code\GitHub\KiloSort\';
% pathToNumpy = 'C:\Users\Administrator\Documents\code\GitHub\npy-matlab\';
% 
% addpath(genpath(pathToKiloSort))
% addpath(genpath(pathToNumpy))
%             
% pathToYourConfigFile = 'C:\Users\Administrator\Documents\code\GitHub\code2018\KiloSortProj\KiloSortConfigFiles\'; 
% 
% % Config Files - check that the channel map is set correctly there!
% %nameOfConfigFile =  'StandardConfig_avian16Chan_ZF_6088.m';
% nameOfConfigFile =  'StandardConfig_avian16Chan_ZF_5915.m';
% %nameOfConfigFile =  'StandardConfig_avian16Chan_ZF_7281.m';
% %nameOfConfigFile =  'StandardConfig_avian16Chan_Chick10';
% runKilosortFromConfigFile(D_OBJ, pathToYourConfigFile, nameOfConfigFile)
% 
% disp(['Finished Processing ' D_OBJ.Session.SessionDir])

%%

pathToKiloSort = 'C:\Users\Administrator\Documents\code\GitHub\KiloSort2\';
pathToNumpy = 'C:\Users\Administrator\Documents\code\GitHub\npy-matlab\';

addpath(genpath(pathToKiloSort))
addpath(genpath(pathToNumpy))
            


%% Create Dat File

dataDir = 'F:\TUM\SWR-Project\ZF-60-88\Ephys\2019-04-29_16-26-20'; % leave away last slash
%chanMap = [5 4 6 3 9 16 8 1 11 14 12 13 10 15 7 2];
chanMap = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5]; % deepes first

    convertOpenEphysToRawBinary_JO(dataDir, chanMap);  % convert data, only for OpenEphys
    
%make sure to move the .dat file to the data directory
    kilosort
    %ops.fshigh = 150;   
    %ks.ops.Th = [10 4];  
    
    ks = get(gcf, 'UserData');
    ks.ops.fshigh = 300;
    ks.ops.Th = [5 3];  
    
    %%



pathToYourConfigFile = 'C:\Users\Administrator\Documents\code\GitHub\code2018\KiloSortProj\KiloSortConfigFiles'; 

% Config Files - check that the channel map is set correctly there!
%nameOfConfigFile =  'StandardConfig_avian16Chan_ZF_5915.m';
nameOfConfigFile =  'StandardConfig_avian16Chan_ZF_5915_K2.m';

%nameOfConfigFile =  'StandardConfig_avian16Chan_ZF_6088.m';
%nameOfConfigFile =  'StandardConfig_avian16Chan_ZF_6088_K2.m';

%nameOfConfigFile =  'StandardConfig_avian16Chan_Chick10.m';
%nameOfConfigFile =  'StandardConfig_avian16Chan_Chick10_K2.m';

%nameOfConfigFile =  'StandardConfig_avian16Chan_ZF_7281.m';
%nameOfConfigFile =  'StandardConfig_avian16Chan_ZF_7281_K2.m';


%root = 'F:\TUM\SWR-Project\ZF-59-15\Ephys\2019-04-28_21-05-36';
%root = 'F:\TUM\SWR-Project\ZF-59-15\Ephys\2019-04-28_18-07-21';
%root = 'F:\TUM\SWR-Project\ZF-59-15\Ephys\2019-04-28_18-48-02'; 

%chanMap = 'C:\Users\Administrator\Documents\code\GitHub\code2018\KiloSortProj\KiloSortConfigFiles\chanMap16ChanSilicon.mat';

runKilosort2fromConfigFile(D_OBJ, pathToYourConfigFile, nameOfConfigFile)
disp(['Finished Processing ' D_OBJ.Session.SessionDir])

%% Running Phy
% navigate to the data directory in cmd window (the location of the .dat file)
%> activate phy
%> phy template-gui params.py
% pip install git+https://github.com/kwikteam/phy git+https://github.com/kwikteam/phy-contrib --upgrade
%% Make sure to save which channels have which clusters on them!!

D_OBJ = avianSWRAnalysis_OBJ(recSession); 


%% Make plots of spikes aligned to SWRs

addpath(genpath('C:\Users\Administrator\Documents\code\GitHub\npy-matlab'))
addpath(genpath('C:\Users\Administrator\Documents\code\GitHub\spikes'))

ClustType = 2;
% - 0 = noise
% - 1 = mua
% - 2 = good
% - 3 = unsorted

[D_OBJ] = importPhyClusterSpikeTimes(D_OBJ, ClustType);

%% Make plots of the spikes
ClustType = 1;
if ~isfield(D_OBJ.REC, 'GoodClust_2') || ~isfield(D_OBJ.REC, 'MUAClust_1')
    disp('***Make sure to set the cluster information in the database before running!***')
else
    [D_OBJ]  = loadClustTypesAndMakeSpikePlots(D_OBJ, ClustType);    
end
disp('Finished plotting...')
%%

chanSelectionOverride = [];

ClustType = 1;

%[D_OBJ]  = loadClustTypesAndAlignToSWR_Raster(D_OBJ, chanSelectionOverride);
[D_OBJ]  = loadClustTypesAndAlignToSWR_Raster_ClustType(D_OBJ, ClustType);


%% Analysis using the Sleep code

[D_OBJ] = getFreqBandDetection(D_OBJ);

[D_OBJ] = plotDBRatio(D_OBJ);




