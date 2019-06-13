ops.GPU                 = 1; % whether to run this code on an Nvidia GPU (much faster, mexGPUall first)		
ops.parfor              = 0; % whether to use parfor to accelerate some parts of the algorithm		
ops.verbose             = 1; % whether to print command line progress		
ops.showfigures         = 1; % whether to plot figures during optimization		
		
ops.datatype            = 'openEphys';  % binary ('dat', 'bin') or 'openEphys'		

% Works
% ops.root                = 'F:\TUM\SWR-Project\ZF-60-88\Ephys\2019-04-29_16-26-20'; % 'openEphys' only: where raw files are		
% ops.fbinary             = fullfile(ops.root, '2019-04-29_16-26-20.dat'); % will be created for 'openEphys'		


%% Works - ZF-59-15 | 18-07-21
%ops.root                = 'F:\TUM\SWR-Project\ZF-59-15\Ephys\2019-04-28_18-07-21'; % 'openEphys' only: where raw files are		
%ops.fbinary             = fullfile(ops.root, '2019-04-28_18-07-21'); % will be created for 'openEphys'		

%% Works - ZF-59-15 | 18-48-02
%ops.root                = 'F:\TUM\SWR-Project\ZF-59-15\Ephys\2019-04-28_18-48-02'; % 'openEphys' only: where raw files are		
%ops.fbinary             = fullfile(ops.root, '2019-04-28_18-48-02'); % will be created for 'openEphys'		

%% Works - ZF-59-15 | 19-34-00
%ops.root                = 'F:\TUM\SWR-Project\ZF-59-15\Ephys\2019-04-28_19-34-00'; % 'openEphys' only: where raw files are		
%ops.fbinary             = fullfile(ops.root, '2019-04-28_19-34-00'); % will be created for 'openEphys'		

%% Works - ZF-59-15 | 20-20-36
%ops.root                = 'F:\TUM\SWR-Project\ZF-59-15\Ephys\2019-04-28_20-20-36'; % 'openEphys' only: where raw files are		
%ops.fbinary             = fullfile(ops.root, '2019-04-28_20-20-36'); % will be created for 'openEphys'		

%% Works - ZF-59-15 | 21-05-36
%ops.root                = 'F:\TUM\SWR-Project\ZF-59-15\Ephys\2019-04-28_21-05-36'; % 'openEphys' only: where raw files are		
%ops.fbinary             = fullfile(ops.root, '2019-04-28_21-05-36'); % will be created for 'openEphys'		

%% Works - ZF-59-15 | TEST
ops.root                = 'F:\TUM\SWR-Project\ZF-59-15\Ephys\2019-04-28_19-34-00_test'; % 'openEphys' only: where raw files are		
ops.fbinary             = fullfile(ops.root, '2019-04-28_19-34-00_test2'); % will be created for 'openEphys'		

%%

ops.fproc               = fullfile(ops.root, 'temp_wh.dat'); % residual from RAM of preprocessed data		

ops.fs                  = 30000;        % sampling rate		(omit if already in chanMap file)
ops.NchanTOT            = 2;           % total number of channels (omit if already in chanMap file)
ops.Nchan               = 2;           % number of active channels (omit if already in chanMap file)
ops.Nfilt               = 8;           % number of clusters to use (2-4 times more than Nchan, should be a multiple of 32)     		
ops.nNeighPC            = 2; % visualization only (Phy): number of channnels to mask the PCs, leave empty to skip (12)		
ops.nNeigh              = 2; % visualization only (Phy): number of neighboring templates to retain projections of (16)		
		
% options for channel whitening		
ops.whitening           = 'full'; % type of whitening (default 'full', for 'noSpikes' set options for spike detection below)		
ops.nSkipCov            = 1; % compute whitening matrix from every N-th batch (1)		
ops.whiteningRange      = Inf; % how many channels to whiten together (Inf for whole probe whitening, should be fine if Nchan<=32)
		
% define the channel map as a filename (string) or simply an array		
%ops.chanMap             = 'F:\TUM\SWR-Project\KiloSortConfigFiles\chanMap.mat'; % make this file using createChannelMapFile.m		
%ops.chanMap             = 'F:\TUM\SWR-Project\KiloSortConfigFiles\chanMap4.mat'; % make this file using createChannelMapFile.m		
ops.chanMap             = 'F:\TUM\SWR-Project\KiloSortConfigFiles\testMap.mat'; % make this file using createChannelMapFile.m		
ops.criterionNoiseChannels = 0.2; % fraction of "noise" templates allowed to span all channel groups (see createChannelMapFile for more info). 		
% ops.chanMap = 1:ops.Nchan; % treated as linear probe if a chanMap file		
		
% other options for controlling the model and optimization		
ops.Nrank               = 2;    % matrix rank of spike template model (3)		
ops.nfullpasses         = 6;    % number of complete passes through data during optimization (6)		
ops.maxFR               = 20000;  % maximum number of spikes to extract per batch (20000)		
ops.fshigh              = 300;   % frequency for high pass filtering		
ops.fslow             = 2000;   % frequency for low pass filtering (optional)
ops.fslow             = 2000;   % frequency for low pass filtering (optional)
ops.ntbuff              = 64;    % samples of symmetrical buffer for whitening and spike detection		
ops.scaleproc           = 200;   % int16 scaling of whitened data		
ops.NT                  = 8*1024+ ops.ntbuff;% this is the batch size (try decreasing if out of memory) 		
% for GPU should be multiple of 32 + ntbuff		
		
% the following options can improve/deteriorate results. 		
% when multiple values are provided for an option, the first two are beginning and ending anneal values, 		
% the third is the value used in the final pass. 		
ops.Th               = [4 10 10];    % threshold for detecting spikes on template-filtered data ([6 12 12])		
ops.lam              = [5 20 20];   % large means amplitudes are forced around the mean ([10 30 30])		
ops.nannealpasses    = 4;            % should be less than nfullpasses (4)		
ops.momentum         = 1./[20 400];  % start with high momentum and anneal (1./[20 1000])		
ops.shuffle_clusters = 1;            % allow merges and splits during optimization (1)		
ops.mergeT           = .1;           % upper threshold for merging (.1)		
ops.splitT           = .1;           % lower threshold for splitting (.1)		
		
% options for initializing spikes from data		
ops.initialize      = 'no'; %'fromData' or 'no'		
ops.spkTh           = -6;      % spike threshold in standard deviations (4)		
ops.loc_range       = [3  1];  % ranges to detect peaks; plus/minus in time and channel ([3 1])		
ops.long_range      = [30  6]; % ranges to detect isolated peaks ([30 6])		
ops.maskMaxChannels = 5;       % how many channels to mask up/down ([5])		
ops.crit            = .65;     % upper criterion for discarding spike repeates (0.65)		
ops.nFiltMax        = 10000;   % maximum "unique" spikes to consider (10000)		
		
% load predefined principal components (visualization only (Phy): used for features)		
dd                  = load('PCspikes2.mat'); % you might want to recompute this from your own data		
ops.wPCA            = dd.Wi(:,1:7);   % PCs 		
		
% options for posthoc merges (under construction)		
ops.fracse  = 0.1; % binning step along discriminant axis for posthoc merges (in units of sd)		
ops.epu     = Inf;		
		
ops.ForceMaxRAMforDat   = 20e9; % maximum RAM the algorithm will try to use; on Windows it will autodetect.
