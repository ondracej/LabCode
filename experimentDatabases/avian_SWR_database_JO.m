function [avianSWR_DB] = avian_SWR_database()

if ispc
    DataDir = 'F:\TUM\SWR-Project\';
    dirD = '\';
elseif isunix
    DataDir = [];
    dirD = '/';
end
    
    

%% turtleSleepDataBase
%% Sleeping Files Only

rfc = 1;

% ElectrodeName = 1MOhm tungesten = 1; 16-Ch Silicone Probe = 2; Hand-built (3) ECoG = 4; Poly2 = 5; tetrode = 6
% BrainArea = DVR = 1; Cortex = 2
% birdAnesthesia = (1) ketamine/xylaxine; (2) isoflurane, (3) none

%% Birds

% Chick-02 = (1) Session 1:13
% Chick-03 = (2) Sessions 14:
% Chick-05 = (3)
% Chick-06 = (4)
% Chick-09 = (5)
% Chick-10 = (6)
% AA19 = (7)
% AA42 = (8)
% AC23 = (9)
% U1 = (10)
% P54 = (11)
% AD24 = (12)
% AD25 = (13)
% AD33 = (14)
% AD15 = (15)
% AC20 = (16)
% AC21 = (17)
% L27 = (18)
% Y7 = (19) f - 498
% L24 = () m 250 - no good data
% P12 = (20) m -572
% R4 = (21) m -588g
% YS3 = (23) m 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chick-02
%% 1 MOhm Electrode in DVR
%% (1) Chick-02  | 30.04.2018 - 11-29-26

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 36205568;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '11-29-26';
avianSWR_DB(rfc).Session.RecStartTime  = '11:29:26';
avianSWR_DB(rfc).Session.RecStopTime  = '11:49:00';
avianSWR_DB(rfc).Session.coords_DV  = 499;
avianSWR_DB(rfc).Session.comments  = 'penetration 1; v light anesthesia ';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (2) Chick-02  | 30.04.2018 - 12-17-41

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 36769792;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '12-17-41';
avianSWR_DB(rfc).Session.RecStartTime  = '12:17:41';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 927;
avianSWR_DB(rfc).Session.comments  = 'penetration 1; rhythmic activity';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (3) Chick-02  | 30.04.2018 - 12-39-47

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 36197376;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '12-39-47';
avianSWR_DB(rfc).Session.RecStartTime  = '12:39:47';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1288;
avianSWR_DB(rfc).Session.comments  = 'penetration 1; ShWRs, waking up at end';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (4) Chick-02  | 30.04.2018 - 13-33-53

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 36590592;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '13-33-53';
avianSWR_DB(rfc).Session.RecStartTime  = '13:33:53';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1510;
avianSWR_DB(rfc).Session.comments  = 'penetration 2; tetrode, also awake at end';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (5) Chick-02  | 30.04.2018 - 13-58-40

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 41584640;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '13-58-40';
avianSWR_DB(rfc).Session.RecStartTime  = '13:58:40';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2090;
avianSWR_DB(rfc).Session.comments  = 'penetration 2; tetrode, not good multiunit';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-600 200];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (6) Chick-02  | 30.04.2018 - 14-30-53

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 37168128;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '14-30-53';
avianSWR_DB(rfc).Session.RecStartTime  = '14:30:53';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2075;
avianSWR_DB(rfc).Session.comments  = 'penetration 3; noisy, waking up, signal saturated';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (7) Chick-02  | 30.04.2018 - 14-55-41

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 36423680;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '14-55-41';
avianSWR_DB(rfc).Session.RecStartTime  = '14:55:41';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2202;
avianSWR_DB(rfc).Session.comments  = 'penetration 3; just after inj, some oscillations';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (8) Chick-02  | 30.04.2018 - 15-19-16

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 38779904;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '15-19-16';
avianSWR_DB(rfc).Session.RecStartTime  = '15:19:16';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1806;
avianSWR_DB(rfc).Session.comments  = 'penetration 4; 15 min recording';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (9) Chick-02  | 30.04.2018 - 16-03-12

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 46622720;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '16-03-12';
avianSWR_DB(rfc).Session.RecStartTime  = '16:03:12';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2207;
avianSWR_DB(rfc).Session.comments  = 'penetration 4; 25 min recording';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (10) Chick-02  | 30.04.2018 - 16-30-56

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 54784000;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '16-30-56';
avianSWR_DB(rfc).Session.RecStartTime  = '16:30:56';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2526;
avianSWR_DB(rfc).Session.comments  = 'penetration 4; 30 min recording';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (11) Chick-02  | 30.04.2018 - 16-30-56

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 54784000;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '16-30-56';
avianSWR_DB(rfc).Session.RecStartTime  = '16:30:56';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2526;
avianSWR_DB(rfc).Session.comments  = 'penetration 4; 30 min recording';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (12) Chick-02  | 30.04.2018 - 17-05-32

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 39103488;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '17-05-32';
avianSWR_DB(rfc).Session.RecStartTime  = '17:05:32';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2998;
avianSWR_DB(rfc).Session.comments  = 'penetration 4;';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (13) Chick-02  | 30.04.2018 - 17-29-04

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 37787648;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '17-29-04';
avianSWR_DB(rfc).Session.RecStartTime  = '17:29:04';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3513;
avianSWR_DB(rfc).Session.comments  = 'penetration 4; nice ShWRs';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (14) Chick-02  | 30.04.2018 - 17-56-36

avianSWR_DB(rfc).INFO.birdName  = 'Chick-02';
avianSWR_DB(rfc).INFO.birdID  = 1;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '10.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 20;
avianSWR_DB(rfc).INFO.birdWeight_g  = 161;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 36791296;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '30.04.2018';
avianSWR_DB(rfc).Session.time  = '17-56-36';
avianSWR_DB(rfc).Session.RecStartTime  = '17:56:36';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4042;
avianSWR_DB(rfc).Session.comments  = 'penetration 4';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1]; %[1:4 13:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 5000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chick-03
%% 1 MOhm Electrode in DVR
%% (15) Chick-03  | 04.05.2018 - 16-41-50

avianSWR_DB(rfc).INFO.birdName  = 'Chick-03';
avianSWR_DB(rfc).INFO.birdID  = 2;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '24.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 10;
avianSWR_DB(rfc).INFO.birdWeight_g  = 77;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 61209600;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '05.05.2018';
avianSWR_DB(rfc).Session.time  = '16-41-50';
avianSWR_DB(rfc).Session.RecStartTime  = '16:41:50';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2092;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1; inj 0.05, 30 min';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [1];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (16) Chick-03  | 04.05.2018 - 17-17-52

avianSWR_DB(rfc).INFO.birdName  = 'Chick-03';
avianSWR_DB(rfc).INFO.birdID  = 2;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '24.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 10;
avianSWR_DB(rfc).INFO.birdWeight_g  = 77;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 72237056;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '05.05.2018';
avianSWR_DB(rfc).Session.time  = '17-17-52';
avianSWR_DB(rfc).Session.RecStartTime  = '17:17:52';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2519;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1; fewer ShWRs, 40 min';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [1];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (17) Chick-03  | 04.05.2018 - 18-03-09

avianSWR_DB(rfc).INFO.birdName  = 'Chick-03';
avianSWR_DB(rfc).INFO.birdID  = 2;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '24.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 10;
avianSWR_DB(rfc).INFO.birdWeight_g  = 77;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 44575744;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '05.05.2018';
avianSWR_DB(rfc).Session.time  = '18-03-09';
avianSWR_DB(rfc).Session.RecStartTime  = '18:03:09';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3013;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1; inj 0.05, heat on 20 min';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [1];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (18) Chick-03  | 04.05.2018 - 18-31-35

avianSWR_DB(rfc).INFO.birdName  = 'Chick-03';
avianSWR_DB(rfc).INFO.birdID  = 2;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '24.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 10;
avianSWR_DB(rfc).INFO.birdWeight_g  = 77;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 41128960;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '05.05.2018';
avianSWR_DB(rfc).Session.time  = '18-31-35';
avianSWR_DB(rfc).Session.RecStartTime  = '18:31:35';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1510;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2; ';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [1];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (19) Chick-03  | 04.05.2018 - 18-55-50

avianSWR_DB(rfc).INFO.birdName  = 'Chick-03';
avianSWR_DB(rfc).INFO.birdID  = 2;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '24.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 10;
avianSWR_DB(rfc).INFO.birdWeight_g  = 77;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 47988736;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '05.05.2018';
avianSWR_DB(rfc).Session.time  = '18-55-50';
avianSWR_DB(rfc).Session.RecStartTime  = '18:55:50';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1900;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2; ShWRs';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [1];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (20) Chick-03  | 04.05.2018 - 19-24-56

avianSWR_DB(rfc).INFO.birdName  = 'Chick-03';
avianSWR_DB(rfc).INFO.birdID  = 2;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '24.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 10;
avianSWR_DB(rfc).INFO.birdWeight_g  = 77;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 60496896;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '05.05.2018';
avianSWR_DB(rfc).Session.time  = '19-24-56';
avianSWR_DB(rfc).Session.RecStartTime  = '19:24:56';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2411;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2; ShWRs';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [1];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (21) Chick-03  | 04.05.2018 - 19-59-19

avianSWR_DB(rfc).INFO.birdName  = 'Chick-03';
avianSWR_DB(rfc).INFO.birdID  = 2;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '24.04.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 10;
avianSWR_DB(rfc).INFO.birdWeight_g  = 77;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 72527872;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '05.05.2018';
avianSWR_DB(rfc).Session.time  = '19-59-19';
avianSWR_DB(rfc).Session.RecStartTime  = '19:59:19';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2820;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2; ShWRs';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [1];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chick-05 - Missing this data
%% 1 MOhm Electrode in DVR
%% (22) Chick-05  | 31.10.2018 - 15-19-02

avianSWR_DB(rfc).INFO.birdName  = 'Chick-05';
avianSWR_DB(rfc).INFO.birdID  = 3;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '01.10.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 30;
avianSWR_DB(rfc).INFO.birdWeight_g  = 310;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 72527872;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '31.10.2018';
avianSWR_DB(rfc).Session.time  = '15-19-02';
avianSWR_DB(rfc).Session.RecStartTime  = '15:19:02';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2473;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1; some ShWRs, not very much HP';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;


%% (23) Chick-05  | 31.10.2018 - 16-02-25

avianSWR_DB(rfc).INFO.birdName  = 'Chick-05';
avianSWR_DB(rfc).INFO.birdID  = 3;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '01.10.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 30;
avianSWR_DB(rfc).INFO.birdWeight_g  = 310;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.Date  = '31.10.2018';
avianSWR_DB(rfc).Session.time  = '16-02-25';
avianSWR_DB(rfc).Session.RecStartTime  = '16:02:25';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3003;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1; some big artifacts, waking up';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (24) Chick-05  | 31.10.2018 - 16-35-42

avianSWR_DB(rfc).INFO.birdName  = 'Chick-05';
avianSWR_DB(rfc).INFO.birdID  = 3;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '01.10.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 30;
avianSWR_DB(rfc).INFO.birdWeight_g  = 310;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.Date  = '31.10.2018';
avianSWR_DB(rfc).Session.time  = '16-35-42';
avianSWR_DB(rfc).Session.RecStartTime  = '16:35:42';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1; some ShWRs';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (25) Chick-05  | 31.10.2018 - 17-04-40

avianSWR_DB(rfc).INFO.birdName  = 'Chick-05';
avianSWR_DB(rfc).INFO.birdID  = 3;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '01.10.18';
avianSWR_DB(rfc).INFO.birdAge_dph  = 30;
avianSWR_DB(rfc).INFO.birdWeight_g  = 310;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.Date  = '31.10.2018';
avianSWR_DB(rfc).Session.time  = '17-04-40';
avianSWR_DB(rfc).Session.RecStartTime  = '17:04:40';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2864;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 7000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 3000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chick-06 - Missing this data
%% 1 MOhm Electrode in DVR
%% (26) Chick-06  | 15.03.2019 - 17-26-39

avianSWR_DB(rfc).INFO.birdName  = 'Chick-06';
avianSWR_DB(rfc).INFO.birdID  = 4;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.02.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 16;
avianSWR_DB(rfc).INFO.birdWeight_g  = 139;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.Date  = '15.03.2019';
avianSWR_DB(rfc).Session.time  = '17-26-39';
avianSWR_DB(rfc).Session.RecStartTime  = '17:26:39';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 6000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 2000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (27) Chick-06  | 15.03.2019 - 18-01-01

avianSWR_DB(rfc).INFO.birdName  = 'Chick-06';
avianSWR_DB(rfc).INFO.birdID  = 4;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.02.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 16;
avianSWR_DB(rfc).INFO.birdWeight_g  = 139;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.Date  = '15.03.2019';
avianSWR_DB(rfc).Session.time  = '18-01-01';
avianSWR_DB(rfc).Session.RecStartTime  = '18:01:01';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 6000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 2000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (28) Chick-06  | 15.03.2019 - 18-34-48

avianSWR_DB(rfc).INFO.birdName  = 'Chick-06';
avianSWR_DB(rfc).INFO.birdID  = 4;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.02.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 16;
avianSWR_DB(rfc).INFO.birdWeight_g  = 139;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.Date  = '15.03.2019';
avianSWR_DB(rfc).Session.time  = '18-34-48';
avianSWR_DB(rfc).Session.RecStartTime  = '18:34:48';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 6000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 2000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (29) Chick-06  | 15.03.2019 - 19-14-35

avianSWR_DB(rfc).INFO.birdName  = 'Chick-06';
avianSWR_DB(rfc).INFO.birdID  = 4;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.02.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 16;
avianSWR_DB(rfc).INFO.birdWeight_g  = 139;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.Date  = '15.03.2019';
avianSWR_DB(rfc).Session.time  = '19-14-35';
avianSWR_DB(rfc).Session.RecStartTime  = '19:14:35';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 6000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 2000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (30) Chick-06  | 15.03.2019 - 19-46-02

avianSWR_DB(rfc).INFO.birdName  = 'Chick-06';
avianSWR_DB(rfc).INFO.birdID  = 4;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.02.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 16;
avianSWR_DB(rfc).INFO.birdWeight_g  = 139;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.Date  = '15.03.2019';
avianSWR_DB(rfc).Session.time  = '19-46-02';
avianSWR_DB(rfc).Session.RecStartTime  = '19:46:02';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 6000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 2000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (31) Chick-06  | 15.03.2019 - 20-19-17

avianSWR_DB(rfc).INFO.birdName  = 'Chick-06';
avianSWR_DB(rfc).INFO.birdID  = 4;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.02.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 16;
avianSWR_DB(rfc).INFO.birdWeight_g  = 139;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.Date  = '15.03.2019';
avianSWR_DB(rfc).Session.time  = '20-19-17';
avianSWR_DB(rfc).Session.RecStartTime  = '20:19:17';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 6000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 2000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (32) Chick-06  | 15.03.2019 - 20-52-50

avianSWR_DB(rfc).INFO.birdName  = 'Chick-06';
avianSWR_DB(rfc).INFO.birdID  = 4;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.02.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 16;
avianSWR_DB(rfc).INFO.birdWeight_g  = 139;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.Date  = '15.03.2019';
avianSWR_DB(rfc).Session.time  = '20-52-50';
avianSWR_DB(rfc).Session.RecStartTime  = '20:52:50';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [1:16];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 12;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 6000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 2000;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chick-09
%% 1 MOhm Electrode in DVR, EKG, Temp noted down
%% (33) Chick-09  | 28.03.2019 - 12-02-02

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 54556672;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '12-02-02';
avianSWR_DB(rfc).Session.RecStartTime  = '12:02:02';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1509;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;


%% (34) Chick-09  | 28.03.2019 - 12-33-32

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 54534144;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '12-33-32';
avianSWR_DB(rfc).Session.RecStartTime  = '12:33:32';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (35) Chick-09  | 28.03.2019 - 13-05-51

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 9863168;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '13-05-51';
avianSWR_DB(rfc).Session.RecStartTime  = '13:05:51';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 1';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (36) Chick-09  | 28.03.2019 - 13-26-20

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 54433792;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '13-26-20';
avianSWR_DB(rfc).Session.RecStartTime  = '13:26:20';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, start to see ShWRs';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (37) Chick-09  | 28.03.2019 - 13-57-43

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56248320;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '13-57-43';
avianSWR_DB(rfc).Session.RecStartTime  = '13:57:43';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, start to see ShWRs';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (38) Chick-09  | 28.03.2019 - 14-43-07

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 59531264;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '14-43-07';
avianSWR_DB(rfc).Session.RecStartTime  = '14:43:07';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, start to see ShWRs';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (39) Chick-09  | 28.03.2019 - 15-20-50

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 60167168;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '15-20-50';
avianSWR_DB(rfc).Session.RecStartTime  = '15:20:50';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, start to see ShWRs';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (40) Chick-09  | 28.03.2019 - 15-57-47

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 27448320;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '15-57-47';
avianSWR_DB(rfc).Session.RecStartTime  = '15:57:47';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, start to see ShWRs, alarm going off';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (41) Chick-09  | 28.03.2019 - 16-27-28

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 22188032;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '16-27-28';
avianSWR_DB(rfc).Session.RecStartTime  = '16:27:28';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;


%% (42) Chick-09  | 28.03.2019 - 16-44-32

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 70693888;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '16-44-32';
avianSWR_DB(rfc).Session.RecStartTime  = '16:44:32';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (43) Chick-09  | 28.03.2019 - 17-25-40

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56270848;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '17-25-40';
avianSWR_DB(rfc).Session.RecStartTime  = '17:25:40';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 5000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (44) Chick-09  | 28.03.2019 - 17-57-40

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 57769984;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '17-57-40';
avianSWR_DB(rfc).Session.RecStartTime  = '17:57:40';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 5500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (45) Chick-09  | 28.03.2019 - 18-39-42

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 54892544;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '18-39-42';
avianSWR_DB(rfc).Session.RecStartTime  = '18:39:42';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 6000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, HR not on signal';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (46) Chick-09  | 28.03.2019 - 19-10-15

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 26798080;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '19-10-15';
avianSWR_DB(rfc).Session.RecStartTime  = '19:10:15';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 6000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, Woke up';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (47) Chick-09  | 28.03.2019 - 19-30-47

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 16937984;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '19-30-47';
avianSWR_DB(rfc).Session.RecStartTime  = '19:30:47';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 6000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, ok, upside down HR, alarm';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (48) Chick-09  | 28.03.2019 - 19-41-23

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 2343936;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '19-41-23';
avianSWR_DB(rfc).Session.RecStartTime  = '19:41:23';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 6000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, No pump';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (49) Chick-09  | 28.03.2019 - 19-43-07

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 54429696;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '19-43-07';
avianSWR_DB(rfc).Session.RecStartTime  = '19-43-07';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 6500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, No pump';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (50) Chick-09  | 28.03.2019 - 20-14-20

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56355840;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '20-14-20';
avianSWR_DB(rfc).Session.RecStartTime  = '20-14-20';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 6000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, No pump';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 1000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 800];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (51) Chick-09  | 28.03.2019 - 20-47-41

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 54690816;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '20-47-41';
avianSWR_DB(rfc).Session.RecStartTime  = '20-47-41';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 5500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, No pump';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 4000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 1000];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (52) Chick-09  | 28.03.2019 - 21-19-01

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 54866944;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '21-19-01';
avianSWR_DB(rfc).Session.RecStartTime  = '21:19:01';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 5000;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, No pump';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 4000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 1000];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (53) Chick-09  | 28.03.2019 - 21-50-29

avianSWR_DB(rfc).INFO.birdName  = 'Chick-09';
avianSWR_DB(rfc).INFO.birdID  = 5;
avianSWR_DB(rfc).INFO.birdSex  = 'M';
avianSWR_DB(rfc).INFO.birdDOB  = '15.01.2019';
avianSWR_DB(rfc).INFO.birdAge_dph  = 71;
avianSWR_DB(rfc).INFO.birdWeight_g  = 750;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 1; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = '1MOhm-W';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 16392192;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.03.2019';
avianSWR_DB(rfc).Session.time  = '21-50-29';
avianSWR_DB(rfc).Session.RecStartTime  = '21:50:29';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4500;
avianSWR_DB(rfc).Session.comments  = 'Penetration 2, No pump';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [10];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = 10;
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 4000;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-200 1000];
avianSWR_DB(rfc).Plotting.hpOffset = 50;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chick-10
%% 16-ch silicone probe in DVR
%% (54) Chick-10  | 27.04.2019 - 19-33-33

avianSWR_DB(rfc).INFO.birdName  = 'Chick-10';
avianSWR_DB(rfc).INFO.birdID  = 6;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.03.19';
avianSWR_DB(rfc).INFO.birdAge_dph  = 30;
avianSWR_DB(rfc).INFO.birdWeight_g  = 356;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 110481408;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '27.04.2019';
avianSWR_DB(rfc).Session.time  = '19-33-33';
avianSWR_DB(rfc).Session.RecStartTime  = '19:33:33';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = '1 hr recording';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [8, 1, 12];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (55) Chick-10  | 27.04.2019 - 20-49-27

avianSWR_DB(rfc).INFO.birdName  = 'Chick-10';
avianSWR_DB(rfc).INFO.birdID  = 6;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.03.19';
avianSWR_DB(rfc).INFO.birdAge_dph  = 30;
avianSWR_DB(rfc).INFO.birdWeight_g  = 356;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 97014784;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '27.04.2019';
avianSWR_DB(rfc).Session.time  = '20-49-27';
avianSWR_DB(rfc).Session.RecStartTime  = '20:49:27';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3000;
avianSWR_DB(rfc).Session.comments  = '1 hr recording, moving a bit at end';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [2, 3, 12];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 100;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (56) Chick-10  | 27.04.2019 - 21-51-18

avianSWR_DB(rfc).INFO.birdName  = 'Chick-10';
avianSWR_DB(rfc).INFO.birdID  = 6;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.03.19';
avianSWR_DB(rfc).INFO.birdAge_dph  = 30;
avianSWR_DB(rfc).INFO.birdWeight_g  = 356;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 8943616;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '27.04.2019';
avianSWR_DB(rfc).Session.time  = '21-51-18';
avianSWR_DB(rfc).Session.RecStartTime  = '21:51:18';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4000;
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (57) Chick-10  | 27.04.2019 - 21-58-36

avianSWR_DB(rfc).INFO.birdName  = 'Chick-10';
avianSWR_DB(rfc).INFO.birdID  = 6;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.03.19';
avianSWR_DB(rfc).INFO.birdAge_dph  = 30;
avianSWR_DB(rfc).INFO.birdWeight_g  = 356;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';


avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 35026944;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '27.04.2019';
avianSWR_DB(rfc).Session.time  = '21-58-36';
avianSWR_DB(rfc).Session.RecStartTime  = '21:58:36';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4000;
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [9, 2, 12, 10];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (58) Chick-10  | 27.04.2019 - 22-20-26

avianSWR_DB(rfc).INFO.birdName  = 'Chick-10';
avianSWR_DB(rfc).INFO.birdID  = 6;
avianSWR_DB(rfc).INFO.birdSex  = '0';
avianSWR_DB(rfc).INFO.birdDOB  = '27.03.19';
avianSWR_DB(rfc).INFO.birdAge_dph  = 30;
avianSWR_DB(rfc).INFO.birdWeight_g  = 356;
avianSWR_DB(rfc).INFO.birdAnesthesia  = 1;

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 1 MOhm tungesten
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 111778816;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '27.04.2019';
avianSWR_DB(rfc).Session.time  = '22-20-26';
avianSWR_DB(rfc).Session.RecStartTime  = '22:20:26';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4000;
avianSWR_DB(rfc).Session.comments  = '1 hr recording, moving a bit at end';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [9, 2, 12, 10];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ZF-59-15
%% 16-ch silicone probe in DVR
%% (59) ZF-59-15  | 28.04.2019 - 18-07-21

avianSWR_DB(rfc).INFO.birdName  = 'ZF-59-15';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 58064896;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.04.2019';
avianSWR_DB(rfc).Session.time  = '18-07-21';
avianSWR_DB(rfc).Session.RecStartTime  = '18:07:21';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = '30 min';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 30;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 80;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;


%% (60) ZF-59-15  | 28.04.2019 - 18-48-02

avianSWR_DB(rfc).INFO.birdName  = 'ZF-59-15';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 58972160;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.04.2019';
avianSWR_DB(rfc).Session.time  = '18-48-02';
avianSWR_DB(rfc).Session.RecStartTime  = '18:48:02';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2500;
avianSWR_DB(rfc).Session.comments  = '~30 min';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 30;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 80;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;


%% (61) ZF-59-15  | 28.04.2019 - 19-34-00

avianSWR_DB(rfc).INFO.birdName  = 'ZF-59-15';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 57880576;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.04.2019';
avianSWR_DB(rfc).Session.time  = '19-34-00';
avianSWR_DB(rfc).Session.RecStartTime  = '19:34:00';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3000;
avianSWR_DB(rfc).Session.comments  = '~30 min, added heat';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;
avianSWR_DB(rfc).REC.GoodClust_2  = [3 10; 4 2; 10 14; 11 7 ; 15 15; 19 9];
avianSWR_DB(rfc).REC.MUAClust_1  = [1 12; 12 9; 13 13; 18 7; 23 15; 24 1; 28 6; 29 3; 30 8; 31 10 ; 41 11];

avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 30;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 80;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;


%% (62) ZF-59-15  | 28.04.2019 - 20-20-36

avianSWR_DB(rfc).INFO.birdName  = 'ZF-59-15';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56411136;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.04.2019';
avianSWR_DB(rfc).Session.time  = '20-20-36';
avianSWR_DB(rfc).Session.RecStartTime  = '20:20:36';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3500;
avianSWR_DB(rfc).Session.comments  = 'added saline, out of range';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 30;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 80;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;


%% (63) ZF-59-15  | 28.04.2019 - 21-05-36

avianSWR_DB(rfc).INFO.birdName  = 'ZF-59-15';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56186880;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '28.04.2019';
avianSWR_DB(rfc).Session.time  = '21-05-36';
avianSWR_DB(rfc).Session.RecStartTime  = '21:05:36';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1500;
avianSWR_DB(rfc).Session.comments  = 'ch 7 is really good';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 30;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 80;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ZF-60-88
%% 16-ch silicone probe in DVR
%% (64) ZF-60-88  | 29.04.2019 - 14-43-33

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 32457728;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '14-43-33';
avianSWR_DB(rfc).Session.RecStartTime  = '14:43:33';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1000;
avianSWR_DB(rfc).Session.comments  = '15 min';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (65) ZF-60-88  | 29.04.2019 - 15-02-55

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56004608;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '15-02-55';
avianSWR_DB(rfc).Session.RecStartTime  = '15:02:55';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1000;
avianSWR_DB(rfc).Session.comments  = '30 min';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;


%% (66) ZF-60-88  | 29.04.2019 - 15-48-05

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56749056;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '15-48-05';
avianSWR_DB(rfc).Session.RecStartTime  = '15:48:05';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = 'v nice';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (67) ZF-60-88  | 29.04.2019 - 16-26-20

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56230912;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '16-26-20';
avianSWR_DB(rfc).Session.RecStartTime  = '16:26:20';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2500;
avianSWR_DB(rfc).Session.comments  = 'v nice';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (68) ZF-60-88  | 29.04.2019 - 17-08-54

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56048640;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '17-08-54';
avianSWR_DB(rfc).Session.RecStartTime  = '17:08:54';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3000;
avianSWR_DB(rfc).Session.comments  = 'v nice';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (69) ZF-60-88  | 29.04.2019 - 17-45-18

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 55942144;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '17-45-18';
avianSWR_DB(rfc).Session.RecStartTime  = '17:45:18';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3500;
avianSWR_DB(rfc).Session.comments  = 'area x?';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (70) ZF-60-88  | 29.04.2019 - 18-19-50

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56198144;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '18-19-50';
avianSWR_DB(rfc).Session.RecStartTime  = '18:19:50';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 4000;
avianSWR_DB(rfc).Session.comments  = 'area x?';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (71) ZF-60-88  | 29.04.2019 - 18-56-00

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 56357888;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '18-56-00';
avianSWR_DB(rfc).Session.RecStartTime  = '18:56:00';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1000;
avianSWR_DB(rfc).Session.comments  = 'same responses?';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (72) ZF-60-88  | 29.04.2019 - 19-28-30

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 57723904;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '19-28-30';
avianSWR_DB(rfc).Session.RecStartTime  = '19:28:30';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 1500;
avianSWR_DB(rfc).Session.comments  = 'similar to above';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (73) ZF-60-88  | 29.04.2019 - 20-09-13

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 22313984;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '20-09-13';
avianSWR_DB(rfc).Session.RecStartTime  = '20:09:13';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = 'CSD here';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (74) ZF-60-88  | 29.04.2019 - 20-42-10

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 3; % Cerebellum
avianSWR_DB(rfc).INFO.brainAreaName  = 'Cerebellum';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 38030336;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '20-42-10';
avianSWR_DB(rfc).Session.RecStartTime  = '20:42:10';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3000;
avianSWR_DB(rfc).Session.comments  = 'Cerebellum recording';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;


%% (75) ZF-60-88  | 29.04.2019 - 21-19-52

avianSWR_DB(rfc).INFO.birdName  = 'ZF-60-88';
avianSWR_DB(rfc).INFO.birdID  = 7;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 2; % 16 chan silicone probe
avianSWR_DB(rfc).INFO.electrodeName  = 'Probe 1EF6';
avianSWR_DB(rfc).INFO.brainAreaN  = 4; % Around NCM
avianSWR_DB(rfc).INFO.brainAreaName  = 'NCM?';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 18356224;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '29.04.2019 ';
avianSWR_DB(rfc).Session.time  = '21-19-52';
avianSWR_DB(rfc).Session.RecStartTime  = '21:19:52';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 3000;
avianSWR_DB(rfc).Session.comments  = 'NCM is recording, bird died';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 800;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 200;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 200;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% ZF-72-81
%% 2 LFP, 2 EEG
%% (76) ZF-72-81 | 16.05.2019 - 19-18-21

avianSWR_DB(rfc).INFO.birdName  = 'ZF-72-81';
avianSWR_DB(rfc).INFO.birdID  = 8;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 21241856;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '16.05.2019';
avianSWR_DB(rfc).Session.time  = '19-18-21';
avianSWR_DB(rfc).Session.RecStartTime  = '19:18:21';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = '10 min, under anesthesia';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [9 10 11 13 14 15 16 2 3 6 7 ]; %9,10,11 LFP 1; 13,14,15,16 LFP2; 2,3 EEG1; 6,7 EEG2
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 200;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 20;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 40;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (77) ZF-72-81 | 16.05.2019 - 19-54-11

avianSWR_DB(rfc).INFO.birdName  = 'ZF-72-81';
avianSWR_DB(rfc).INFO.birdID  = 8;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 19875840;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '16.05.2019';
avianSWR_DB(rfc).Session.time  = '19-54-11';
avianSWR_DB(rfc).Session.RecStartTime  = '19:54:11';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = '10 min, under anesthesia';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [9 10 11 13 14 15 16 2 3 6 7 ]; %9,10,11 LFP 1; 13,14,15,16 LFP2; 2,3 EEG1; 6,7 EEG2
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 200;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 20;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 40;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (78) ZF-72-81 | 16.05.2019 - 20-05-43

avianSWR_DB(rfc).INFO.birdName  = 'ZF-72-81';
avianSWR_DB(rfc).INFO.birdID  = 8;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 63168512;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '16.05.2019';
avianSWR_DB(rfc).Session.time  = '20-05-43';
avianSWR_DB(rfc).Session.RecStartTime  = '20:05:43';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = '30 min, 1.5% under anesthesia';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [9 10 11 13 14 15 16 2 3 6 7 ]; %9,10,11 LFP 1; 13,14,15,16 LFP2; 2,3 EEG1; 6,7 EEG2
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 200;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 20;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 40;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;


%% (79) ZF-72-81 | 16.05.2019 - 20-42-00

avianSWR_DB(rfc).INFO.birdName  = 'ZF-72-81';
avianSWR_DB(rfc).INFO.birdID  = 8;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 5069824;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '16.05.2019';
avianSWR_DB(rfc).Session.time  = '20-42-00';
avianSWR_DB(rfc).Session.RecStartTime  = '20:42:00';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = 'no isoflurane, 0%';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [9 10 11 13 14 15 16 2 3 6 7 ]; %9,10,11 LFP 1; 13,14,15,16 LFP2; 2,3 EEG1; 6,7 EEG2
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 200;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 20;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 40;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (80) ZF-72-81 | 16.05.2019 - 21-14-10

avianSWR_DB(rfc).INFO.birdName  = 'ZF-72-81';
avianSWR_DB(rfc).INFO.birdID  = 8;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 3; % none

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 22995968;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '16.05.2019';
avianSWR_DB(rfc).Session.time  = '21-14-10';
avianSWR_DB(rfc).Session.RecStartTime  = '21:14:10';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [9 10 11 13 14 15 16 2 3 6 7 ]; %9,10,11 LFP 1; 13,14,15,16 LFP2; 2,3 EEG1; 6,7 EEG2
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 100;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 20;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 40;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (81) ZF-72-81 | 16.05.2019 - 21-26-59 - Overnight

avianSWR_DB(rfc).INFO.birdName  = 'ZF-72-81';
avianSWR_DB(rfc).INFO.birdID  = 8;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 3; % none

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 168258560; 
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '16.05.2019';
avianSWR_DB(rfc).Session.time  = '21-26-59';
avianSWR_DB(rfc).Session.RecStartTime  = '21:26:59';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [9 10 11 13 14 15 16 2 3 6 7 ]; %9,10,11 lateral LFP ; 13,14,15,16 Medial LFP; 2,3 medial EEG1; 6,7 lateral EEG2
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [11];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 100;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 20;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 40;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% (82) ZF-72-81 | 16.05.2019 - 23-21-04 - Overnight

avianSWR_DB(rfc).INFO.birdName  = 'ZF-72-81';
avianSWR_DB(rfc).INFO.birdID  = 8;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 3; % none

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.sampleRate = 30000;
avianSWR_DB(rfc).Session.samples  = 1.0148e+09;
avianSWR_DB(rfc).Session.recordingDur_s  = avianSWR_DB(rfc).Session.samples/avianSWR_DB(rfc).Session.sampleRate;
avianSWR_DB(rfc).Session.recordingDur_hr  = avianSWR_DB(rfc).Session.recordingDur_s/3600;
avianSWR_DB(rfc).Session.Date  = '16.05.2019';
avianSWR_DB(rfc).Session.time  = '23-21-04';
avianSWR_DB(rfc).Session.RecStartTime  = '23:21:04';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000;
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.dirD= dirD;

avianSWR_DB(rfc).REC.allChs  = [6 11 3 14 1 16 2 15 5 12 4 13 7 10 8 9]; %9,10,11 LFP 1; 13,14,15,16 LFP2; 2,3 EEG1; 6,7 EEG2
avianSWR_DB(rfc).REC.nChs  = numel(avianSWR_DB(rfc).REC.allChs);
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.rawOffset = 100;
avianSWR_DB(rfc).Plotting.rawYlim = [-avianSWR_DB(rfc).Plotting.rawOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.rawOffset];
avianSWR_DB(rfc).Plotting.hpRectOffset = 20;
avianSWR_DB(rfc).Plotting.hpRectYlim = [-avianSWR_DB(rfc).Plotting.hpRectOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpRectOffset];
avianSWR_DB(rfc).Plotting.hpOffset = 40;
avianSWR_DB(rfc).Plotting.hpYlim = [-avianSWR_DB(rfc).Plotting.hpOffset avianSWR_DB(rfc).REC.nChs*avianSWR_DB(rfc).Plotting.hpOffset];

rfc = rfc+1;

%% ZF-70-86
%% 2 LFP, 4 EEG
%% (83) ZF-70-86 | 23.05.2019 - 21-37-05

avianSWR_DB(rfc).INFO.birdName  = 'ZF-70-86 ';
avianSWR_DB(rfc).INFO.birdID  = 9;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.Date  = '23.05.2019';
avianSWR_DB(rfc).Session.time  = '21-37-05';
avianSWR_DB(rfc).Session.RecStartTime  = '21:37:05';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000; %??
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.base = '';
avianSWR_DB(rfc).DIR.ephys = [avianSWR_DB(rfc).DIR.base   'ephys' dirD];
avianSWR_DB(rfc).DIR.videoDir  = [avianSWR_DB(rfc).DIR.base   'videos' dirD];
avianSWR_DB(rfc).DIR.plotDir  = [avianSWR_DB(rfc).DIR.base   'plots' dirD];

avianSWR_DB(rfc).REC.allChs  = [];
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.range = 500;
avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.hpOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;

rfc = rfc+1;

%% (77) ZF-70-86 | 23.05.2019 - 21-54-18 - short

avianSWR_DB(rfc).INFO.birdName  = 'ZF-70-86 ';
avianSWR_DB(rfc).INFO.birdID  = 9;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.Date  = '23.05.2019';
avianSWR_DB(rfc).Session.time  = '21-54-18';
avianSWR_DB(rfc).Session.RecStartTime  = '21:54:18';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000; %??
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.base = '';
avianSWR_DB(rfc).DIR.ephys = [avianSWR_DB(rfc).DIR.base   'ephys' dirD];
avianSWR_DB(rfc).DIR.videoDir  = [avianSWR_DB(rfc).DIR.base   'videos' dirD];
avianSWR_DB(rfc).DIR.plotDir  = [avianSWR_DB(rfc).DIR.base   'plots' dirD];

avianSWR_DB(rfc).REC.allChs  = [];
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.range = 500;
avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.hpOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;

rfc = rfc+1;

%% (77) ZF-70-86 | 23.05.2019 - 21-55-43 - short

avianSWR_DB(rfc).INFO.birdName  = 'ZF-70-86 ';
avianSWR_DB(rfc).INFO.birdID  = 9;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.Date  = '23.05.2019';
avianSWR_DB(rfc).Session.time  = '21-55-43';
avianSWR_DB(rfc).Session.RecStartTime  = '21:55:43';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000; %??
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.base = '';
avianSWR_DB(rfc).DIR.ephys = [avianSWR_DB(rfc).DIR.base   'ephys' dirD];
avianSWR_DB(rfc).DIR.videoDir  = [avianSWR_DB(rfc).DIR.base   'videos' dirD];
avianSWR_DB(rfc).DIR.plotDir  = [avianSWR_DB(rfc).DIR.base   'plots' dirD];

avianSWR_DB(rfc).REC.allChs  = [];
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.range = 500;
avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.hpOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;

rfc = rfc+1;


%% (78) ZF-70-86 | 23.05.2019 - 21-56-18 - short

avianSWR_DB(rfc).INFO.birdName  = 'ZF-70-86 ';
avianSWR_DB(rfc).INFO.birdID  = 9;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.Date  = '23.05.2019';
avianSWR_DB(rfc).Session.time  = '21-56-18';
avianSWR_DB(rfc).Session.RecStartTime  = '21:56:18';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000; %??
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.base = '';
avianSWR_DB(rfc).DIR.ephys = [avianSWR_DB(rfc).DIR.base   'ephys' dirD];
avianSWR_DB(rfc).DIR.videoDir  = [avianSWR_DB(rfc).DIR.base   'videos' dirD];
avianSWR_DB(rfc).DIR.plotDir  = [avianSWR_DB(rfc).DIR.base   'plots' dirD];

avianSWR_DB(rfc).REC.allChs  = [];
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.range = 500;
avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.hpOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;

rfc = rfc+1;


%% (78) ZF-70-86 | 23.05.2019 - 21-58-55

avianSWR_DB(rfc).INFO.birdName  = 'ZF-70-86 ';
avianSWR_DB(rfc).INFO.birdID  = 9;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.Date  = '23.05.2019';
avianSWR_DB(rfc).Session.time  = '21-58-55';
avianSWR_DB(rfc).Session.RecStartTime  = '21:58:55';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000; %??
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.base = '';
avianSWR_DB(rfc).DIR.ephys = [avianSWR_DB(rfc).DIR.base   'ephys' dirD];
avianSWR_DB(rfc).DIR.videoDir  = [avianSWR_DB(rfc).DIR.base   'videos' dirD];
avianSWR_DB(rfc).DIR.plotDir  = [avianSWR_DB(rfc).DIR.base   'plots' dirD];

avianSWR_DB(rfc).REC.allChs  = [];
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.range = 500;
avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.hpOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;

rfc = rfc+1;

%% (79) ZF-70-86 | 23.05.2019 - 23-06-05

avianSWR_DB(rfc).INFO.birdName  = 'ZF-70-86 ';
avianSWR_DB(rfc).INFO.birdID  = 9;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 2; % Isoflurane

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.Date  = '23.05.2019';
avianSWR_DB(rfc).Session.time  = '23-06-05';
avianSWR_DB(rfc).Session.RecStartTime  = '23:06:05';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000; %??
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.base = '';
avianSWR_DB(rfc).DIR.ephys = [avianSWR_DB(rfc).DIR.base   'ephys' dirD];
avianSWR_DB(rfc).DIR.videoDir  = [avianSWR_DB(rfc).DIR.base   'videos' dirD];
avianSWR_DB(rfc).DIR.plotDir  = [avianSWR_DB(rfc).DIR.base   'plots' dirD];

avianSWR_DB(rfc).REC.allChs  = [];
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.range = 500;
avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.hpOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;

rfc = rfc+1;

%% (80) ZF-70-86 | 23.05.2019 - 00-08-59 -- Overnight

avianSWR_DB(rfc).INFO.birdName  = 'ZF-70-86 ';
avianSWR_DB(rfc).INFO.birdID  = 9;
avianSWR_DB(rfc).INFO.birdSex  = 'F';
avianSWR_DB(rfc).INFO.birdDOB  = '';
avianSWR_DB(rfc).INFO.birdAge_dph  = [];
avianSWR_DB(rfc).INFO.birdWeight_g  = [];
avianSWR_DB(rfc).INFO.birdAnesthesia  = 3; % None

avianSWR_DB(rfc).INFO.electrodeType  = 3; % Self made: 2, Tungsten LFP, 2 EEG
avianSWR_DB(rfc).INFO.electrodeName  = 'Self-Made, Tungsten EEG';
avianSWR_DB(rfc).INFO.brainAreaN  = 1; % DVR
avianSWR_DB(rfc).INFO.brainAreaName  = 'DVR, Cortex';

avianSWR_DB(rfc).Session.Date  = '23.05.2019';
avianSWR_DB(rfc).Session.time  = '00-08-59';
avianSWR_DB(rfc).Session.RecStartTime  = '00:08:59';
avianSWR_DB(rfc).Session.RecStopTime  = '';
avianSWR_DB(rfc).Session.coords_DV  = 2000; %??
avianSWR_DB(rfc).Session.comments  = '';
avianSWR_DB(rfc).Session.n = rfc;

avianSWR_DB(rfc).DIR.dataDir = DataDir;
avianSWR_DB(rfc).DIR.base = '';
avianSWR_DB(rfc).DIR.ephys = [avianSWR_DB(rfc).DIR.base   'ephys' dirD];
avianSWR_DB(rfc).DIR.videoDir  = [avianSWR_DB(rfc).DIR.base   'videos' dirD];
avianSWR_DB(rfc).DIR.plotDir  = [avianSWR_DB(rfc).DIR.base   'plots' dirD];

avianSWR_DB(rfc).REC.allChs  = [];
avianSWR_DB(rfc).REC.bestChs  = [];
avianSWR_DB(rfc).REC.otherChs  = [];
avianSWR_DB(rfc).REC.hasEMG  = 0;
avianSWR_DB(rfc).REC.cscEMG  = [];
avianSWR_DB(rfc).REC.hasEOG  = 0;
avianSWR_DB(rfc).REC.csc_EOG  = []';
avianSWR_DB(rfc).REC.hasEKG  = 0;
avianSWR_DB(rfc).REC.cscEKG  = 0;

avianSWR_DB(rfc).Plotting.range = 500;
avianSWR_DB(rfc).Plotting.rawOffset = 500;
avianSWR_DB(rfc).Plotting.hpOffset = 500;
avianSWR_DB(rfc).Plotting.hpRectOffset = 500;

rfc = rfc+1;

