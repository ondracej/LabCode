function [] = batchPlotDataForOpenEphys_inputFromDatabase_multiChannel()
dbstop if error
close all

doPlot = 1;

%%
seg = 40; % seconds
%allSessionToAnalyze = [55:83];
%allSessionToAnalyze = [54:83];
allSessionToAnalyze = [60:83];

%%
[avianSWR_DB] = avian_SWR_database;
nEntries = numel(avianSWR_DB);

for q=1:numel(allSessionToAnalyze)
    
    SessionToAnalyze=allSessionToAnalyze(q);
    
    INFO=avianSWR_DB(SessionToAnalyze).INFO;
    Session=avianSWR_DB(SessionToAnalyze).Session;
    DIR=avianSWR_DB(SessionToAnalyze).DIR;
    REC=avianSWR_DB(SessionToAnalyze).REC;
    Plotting=avianSWR_DB(SessionToAnalyze).Plotting;
    
    Plotting.titleTxt = [INFO.birdName ' | ' Session.time];
    Plotting.saveTxt = [INFO.birdName '_' Session.time];
    
    %% Defining Path to data
    
    birdDir=[DIR.dataDir INFO.birdName DIR.dirD];
    
    FileSearch=Session.time;
    %allDataFiles = dir(fullfile(dataDir,textSearch));
    
    allDataDirs=dir([birdDir 'Ephys' DIR.dirD]);
    if isempty(allDataDirs)
        disp('Did not find any directory, check the file path...')
        keyboard
    end
    
    nDataDirs=numel(allDataDirs);
    for j = 1:nDataDirs
        dirName=allDataDirs(j).name;
        %match = strcmpi(dirName, FileSearch);
        match=strfind(dirName, FileSearch);
        if match
            SessionDir=[birdDir 'Ephys' DIR.dirD dirName DIR.dirD];
            disp(['Search: ' FileSearch ' matches ' dirName ])
            break
        end
    end
    
    if isempty(SessionDir)
        disp('There is a typo in the database')
        keyboard
    end
    
    PlotDir = [birdDir 'Plots' DIR.dirD dirName '_plots' DIR.dirD];
    if exist(PlotDir, 'dir') == 0
        mkdir(PlotDir);
        disp(['Created: '  PlotDir])
    end
    
    extSearch ='*.continuous*';
    allOpenEphysFiles=dir(fullfile(SessionDir,extSearch));
    nFiles=numel(allOpenEphysFiles);
    
    chanSet=REC.allChs;
    recordingDuration_s=Session.recordingDur_s;
    Fs=Session.sampleRate;
    
    %% Define Filters
    
    fObj = filterData(Fs);
    
    fobj.filt.FL=filterData(Fs);
    %fobj.filt.FL.lowPassPassCutoff=4.5;
    %fobj.filt.FL.lowPassPassCutoff=20;
    %fobj.filt.FL.lowPassStopCutoff=30;
    fobj.filt.FL.lowPassPassCutoff=30;% this captures the LF pretty well for detection
    fobj.filt.FL.lowPassStopCutoff=40;
    fobj.filt.FL.attenuationInLowpass=20;
    fobj.filt.FL=fobj.filt.FL.designLowPass;
    fobj.filt.FL.padding=true;
    
    fobj.filt.FH2=filterData(Fs);
    fobj.filt.FH2.highPassCutoff=100;
    fobj.filt.FH2.lowPassCutoff=2000;
    fobj.filt.FH2.filterDesign='butter';
    fobj.filt.FH2=fobj.filt.FH2.designBandPass;
    fobj.filt.FH2.padding=true;
    
    fobj.filt.FN =filterData(Fs);
    fobj.filt.FN.filterDesign='cheby1';
    fobj.filt.FN.padding=true;
    fobj.filt.FN=fobj.filt.FN.designNotch;
    
    %% Define Segements
    
    TOn=1:seg*Fs:(recordingDuration_s*Fs-seg*Fs);
    overlapWin=2*Fs;
    nCycles=numel(TOn);
    chanCnt = 1;
    
    for i=1:nCycles-1
%for i=1:nCycles-1        
        
        %         if i ==1
        %             thisROI = TOn(i):TOn(i+1);
        %         else
        %             thisROI = TOn(i)-overlapWin:TOn(i+1)-overlapWin;
        %         end
        
        thisROI = TOn(i):TOn(i+1)-1;
        
        offsetLP = 0;
        offsetHP = 0;
        offsetHP_R = 0;
        
        %CDC_AllData = [];
        CDC = [];
        CDC.AllData = NaN(numel(thisROI), numel(chanSet));
        
        %% start loop over channel selectiondbquit
        
        figure(100); clf %raw
        figure(101); clf % LF
        figure(102); clf % HP-R
        figure(103); clf % HP
        
        for s=chanSet
            
            
            %% Loading Data
            %s=1;
            eval(['fileAppend = ''100_CH' num2str(s) '.continuous'';'])
            fileName = [SessionDir fileAppend];
            
            [data, timestamps, info] = load_open_ephys_data(fileName);
            thisSegData_s = timestamps(1:end) - timestamps(1);
            
            samples = size(data, 1);
            sampleRate = info.header.sampleRate;
            
            %%
            if samples ~= Session.samples
                disp('Sample count mismatch..');
                keyboard
            end
            
            %% Put it in an array for the filters
            [V_uV_data_full,nshifts] = shiftdim(data',-1);
            %thisSegData = V_uV_data_full(:,:,:);
            
            SegData = V_uV_data_full(:,:, thisROI);
            SegData_s = thisSegData_s(thisROI);
            
            %DataSeg_FNotch = squeeze(fobj.filt.FN.getFilteredData(SegData));
            DataSeg_LF = squeeze(fobj.filt.FL.getFilteredData(SegData));
            DataSeg_HF = squeeze(fobj.filt.FH2.getFilteredData(SegData));
            Data_SegData = squeeze(SegData);
            
            CDC.AllData(:,chanCnt) = Data_SegData;
            CDC.SegData_s = SegData_s;
            CDC.sampleRate = sampleRate;
            CDC.maxSamples = samples;
            
            CDCSaveTxt = ['_' num2str(SegData_s(1)) '-' num2str(SegData_s(end)) 's'];
            
            chanCnt = chanCnt +1;
            
            %% Smooth for HP rect
            
            smoothWin = 0.10*Fs; % smoothing w 100 ms
            %DataSeg_LF_neg = -DataSeg_LF;
            DataSeg_rect_HF = smooth(DataSeg_HF.^2, smoothWin);
            
            %% Plotting
            if doPlot
                %% Prepare Figs and counters
                
                % Raw Data
                FigHRaw = figure(100); hold on
                plot(SegData_s, Data_SegData + offsetLP); %title( ['Raw Voltage']);
                text(SegData_s(1), Data_SegData(1)+offsetLP, ['Ch-' num2str(s)])
                axis tight
                
                % Low Frequency
                FigHLD = figure(101); hold on
                plot(SegData_s, DataSeg_LF + offsetLP);
                text(SegData_s(1), DataSeg_LF(1)+offsetLP, ['Ch-' num2str(s)])
                axis tight
                
                % High Pass Rectified
                FigHHighRect = figure(102); hold on
                plot(SegData_s, DataSeg_rect_HF + offsetHP_R);
                %text(SegData_s(1), DataSeg_rect_HF(1)+offsetHP_R, ['Ch-' num2str(s)])
                axis tight
                
                % High Pass
                FigHHigh = figure(103); hold on
                plot(SegData_s, DataSeg_HF + offsetHP);
                text(SegData_s(1), DataSeg_HF(1)+offsetHP, ['Ch-' num2str(s)])
                axis tight
                
                offsetLP  = offsetLP + Plotting.rawOffset;
                offsetHP  = offsetHP + Plotting.hpOffset;
                offsetHP_R  = offsetHP_R + Plotting.hpRectOffset;
                
            end
        end
        
        %% Final Fig modifications
        if doPlot
            
            % Raw Data
            figure(FigHRaw)
            axis tight
            ylim(Plotting.rawYlim);
            xlabel('Time [s]')
            title(['Raw Voltage: '  Plotting.titleTxt ' | ' sprintf('%03d', i)])
            saveName = [PlotDir Plotting.saveTxt '_Raw_' sprintf('%03d', i)];
            plotpos = [0 0 30 15];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            %print_in_A4(0, saveName, '-depsc', 0, plotpos);
            
            % Low Frequency
            figure(FigHLD)
            axis tight
            ylim(Plotting.rawYlim);
            title( ['LF:' Plotting.titleTxt ' | ' sprintf('%03d', i)])
            xlabel('Time [s]')
            saveName = [PlotDir Plotting.saveTxt '_LF_' sprintf('%03d', i)];
            plotpos = [0 0 30 15];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            %print_in_A4(0, saveName, '-depsc', 0, plotpos);
            
            % High Pass Rectified
            figure(FigHHighRect)
            axis tight
            ylim(Plotting.hpRectYlim);
            title( ['HF Rectified: ' Plotting.titleTxt ' | ' sprintf('%03d', i)])
            xlabel('Time [s]')
            saveName = [PlotDir Plotting.saveTxt '_HFR_' sprintf('%03d', i)];
            plotpos = [0 0 30 15];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            %print_in_A4(0, saveName, '-depsc', 0, plotpos);
            
            % High Pass
            figure(FigHHigh)
            axis tight
            ylim(Plotting.hpYlim)
            title( ['HF: ' Plotting.titleTxt ' | ' sprintf('%03d', i)])
            xlabel('Time [s]')
            saveName = [PlotDir Plotting.saveTxt '_HF_' sprintf('%03d', i)];
            plotpos = [0 0 30 15];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            %print_in_A4(0, saveName, '-depsc', 0, plotpos);
            
        end
        
        %% Saving Data
        saveName = [PlotDir Plotting.saveTxt '_CSD_' sprintf('%03d', i) '_' CDCSaveTxt '.mat'];
        save(saveName, 'CDC', '-v7.3')
        disp(['Saved: ' saveName])
    end
    
end


