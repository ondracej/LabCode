%% Making dat files from openEphys format

pathToCodeRepository = 'D:\github\LabCode\';
addpath(genpath(pathToCodeRepository)) 

chanMap = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5]; % deepes first
dataDir = 'D:\Janie\ZF-60-88\exp1_2019-04-29_14-43-33'; % make sure there is no \ at the end
convertOpenEphysToRawBinary_JO(dataDir, chanMap);  % need to move the .dat file into the data dir

