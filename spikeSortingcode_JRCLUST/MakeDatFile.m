%% Making dat files from openEphys format

pathToCodeRepository = 'C:\Users\Janie\Documents\GitHub\code2018\';
addpath(genpath(pathToCodeRepository)) 

chanMap = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5]; % deepes first
dataDir = 'C:\Users\Janie\Documents\Data\SWR-Project\Chick-10\Ephys\2019-04-27_20-49-27'; % make sure there is no \ at the end
convertOpenEphysToRawBinary_JO(dataDir, chanMap);  % need to move the .dat file into the data dir

