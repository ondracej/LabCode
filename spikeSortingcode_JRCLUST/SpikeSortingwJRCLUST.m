%% Spikesorting with JRCLUST - must run in matlab 2019

% https://jrclust.readthedocs.io/en/latest/usage/tutorial.html

%pathToDat = 'C:\Users\Janie\Documents\Data\SWR-Project\Chick-10\Ephys\2019-04-27_19-33-33\dat\2019-04-27_19-33-33.dat';
pathToDat = 'C:\Users\Janie\Documents\Data\SWR-Project\Chick-10\Ephys\2019-04-27_20-49-27\dat\2019-04-27_20-49-27.dat';

jrc bootstrap
% use probe silico120_1col_1 - will give 2 peakFeature
% nPeaksFeatures = 2; % (formerly nFet_use) Number of potential peaks to use when computing features
% replace this info in the .prm file
% probePad = [23, 23]; % (formerly vrSiteHW) Recording contact pad size (in m) (Height x width)
% shankMap = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]; % (formerly viShank_site) Shank ID of each site
% siteLoc = [0, 0; 0, 100; 0, 200; 0, 300; 0, 400; 0, 500; 0, 600; 0, 700; 0, 800; 0, 900; 0, 1000; 0, 1100; 0, 1200; 0, 1300; 0, 1400; 0, 1500]; % (formerly mrSiteXY) Site locations (in m) (x values in the first column, y values in the second column)
% siteMap = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]; % (formerly viSite2Chan) Map of channel index to site ID (The mapping siteMap(i) = j corresponds to the statement 'site i is stored as channel j in the recording')

cnfg = [pathToDat(1:end-3) 'prm'];

%Check probe layout
eval(['jrc probe ' cnfg]);

% Plot Traces
eval(['jrc traces ' cnfg]);
eval(['jrc preview ' cnfg]);

% Detect Spikes
eval(['jrc detect ' cnfg]);
eval(['jrc sort ' cnfg]); % if this crahses it is because nPeaksFeatures needs to be set to 2;

eval(['jrc detect-sort ' cnfg]); % and sort directly

eval(['jrc manual ' cnfg]); % manual checking of clusters
