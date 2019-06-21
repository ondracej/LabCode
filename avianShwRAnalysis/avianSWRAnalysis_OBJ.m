classdef avianSWRAnalysis_OBJ < handle
    
    
    properties (Access = public)
        
        HOST
        INFO
        Session
        DIR
        REC
        Plotting
        
        ops
        
    end
    
    methods
        
        %% Plotting Raw data
        function [obj] = batchPlotDataForOpenEphys_multiChannel(obj, doPlot, seg)
            dbstop if error
            if nargin <3
                doPlot = 1;
                seg = 40; % seconds
            end
            %%
            obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
            obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
            
            %% Defining Path to data
            
            SessionDir = obj.Session.SessionDir;
            
            if isempty(SessionDir)
                disp('There is a typo in the database')
                keyboard
            end
            
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            if exist(PlotDir, 'dir') == 0
                mkdir(PlotDir);
                disp(['Created: '  PlotDir])
            end
            
            extSearch ='*.continuous*';
            allOpenEphysFiles=dir(fullfile(SessionDir,extSearch));
            nFiles=numel(allOpenEphysFiles);
            
            chanSet=obj.REC.allChs;
            recordingDuration_s=obj.Session.recordingDur_s;
            Fs=obj.Session.sampleRate;
            
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
                    if samples ~= obj.Session.samples
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
                        
                        offsetLP  = offsetLP + obj.Plotting.rawOffset;
                        offsetHP  = offsetHP + obj.Plotting.hpOffset;
                        offsetHP_R  = offsetHP_R + obj.Plotting.hpRectOffset;
                        
                    end
                end
                
                %% Final Fig modifications
                if doPlot
                    
                    % Raw Data
                    figure(FigHRaw)
                    axis tight
                    ylim(obj.Plotting.rawYlim);
                    xlabel('Time [s]')
                    title(['Raw Voltage: '  obj.Plotting.titleTxt ' | ' sprintf('%03d', i)])
                    saveName = [PlotDir obj.Plotting.saveTxt '_Raw_' sprintf('%03d', i)];
                    plotpos = [0 0 30 15];
                    print_in_A4(0, saveName, '-djpeg', 0, plotpos);
                    %print_in_A4(0, saveName, '-depsc', 0, plotpos);
                    
                    % Low Frequency
                    figure(FigHLD)
                    axis tight
                    ylim(obj.Plotting.rawYlim);
                    title( ['LF:' obj.Plotting.titleTxt ' | ' sprintf('%03d', i)])
                    xlabel('Time [s]')
                    saveName = [PlotDir obj.Plotting.saveTxt '_LF_' sprintf('%03d', i)];
                    plotpos = [0 0 30 15];
                    print_in_A4(0, saveName, '-djpeg', 0, plotpos);
                    %print_in_A4(0, saveName, '-depsc', 0, plotpos);
                    
                    % High Pass Rectified
                    figure(FigHHighRect)
                    axis tight
                    ylim(obj.Plotting.hpRectYlim);
                    title( ['HF Rectified: ' obj.Plotting.titleTxt ' | ' sprintf('%03d', i)])
                    xlabel('Time [s]')
                    saveName = [PlotDir obj.Plotting.saveTxt '_HFR_' sprintf('%03d', i)];
                    plotpos = [0 0 30 15];
                    print_in_A4(0, saveName, '-djpeg', 0, plotpos);
                    %print_in_A4(0, saveName, '-depsc', 0, plotpos);
                    
                    % High Pass
                    figure(FigHHigh)
                    axis tight
                    ylim(obj.Plotting.hpYlim)
                    title( ['HF: ' obj.Plotting.titleTxt ' | ' sprintf('%03d', i)])
                    xlabel('Time [s]')
                    saveName = [PlotDir obj.Plotting.saveTxt '_HF_' sprintf('%03d', i)];
                    plotpos = [0 0 30 15];
                    print_in_A4(0, saveName, '-djpeg', 0, plotpos);
                    %print_in_A4(0, saveName, '-depsc', 0, plotpos);
                    
                end
                
                %% Saving Data
                saveName = [PlotDir obj.Plotting.saveTxt '_CSD_' sprintf('%03d', i) '_' CDCSaveTxt '.mat'];
                save(saveName, 'CDC', '-v7.3')
                disp(['Saved: ' saveName])
            end
            
        end
        
        function [obj] = batchPlotDataForOpenEphys_singleChannel(obj, doPlot, seg)
            dbstop if error
            if nargin <3
                doPlot = 1;
                seg = 40; % seconds
            end
            
            obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
            obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
            
            %% Defining Path to data
            
            SessionDir = obj.Session.SessionDir;
            
            if isempty(SessionDir)
                disp('There is a typo in the database')
                keyboard
            end
            
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            if exist(PlotDir, 'dir') == 0
                mkdir(PlotDir);
                disp(['Created: '  PlotDir])
            end
            
            extSearch ='*.continuous*';
            allOpenEphysFiles=dir(fullfile(SessionDir,extSearch));
            nFiles=numel(allOpenEphysFiles);
            
            chanSet=obj.REC.allChs;
            recordingDuration_s=obj.Session.recordingDur_s;
            Fs=obj.Session.sampleRate;
            
            if numel(chanSet) > 1
                plotMulti = 1;
            else
                plotMulti = 0;
            end
            
            
            %% Define Filters
            
            
            
            %% Define Segements
            
            TOn=1:seg*Fs:(recordingDuration_s*Fs-seg*Fs);
            overlapWin=2*Fs;
            nCycles=numel(TOn);
            chanCnt = 1;
            
            %% start loop over channel selectiondbquit
            
            for s=chanSet
                
                %% Loading Data
                %s=1;
                eval(['fileAppend = ''100_CH' num2str(s) '.continuous'';'])
                fileName = [SessionDir fileAppend];
                
                [data, timestamps, info] = load_open_ephys_data(fileName);
                thisSegData_s = timestamps(1:end) - timestamps(1);
                
                samples = numel(data);
                sampleRate = info.header.sampleRate;
                
                %%
                if samples ~= obj.Session.samples
                    disp('Sample count mismatch..');
                    keyboard
                end
                
                for i=1:nCycles-1
                    
                    %         if i ==1
                    %             thisROI = TOn(i):TOn(i+1);
                    %         else
                    %             thisROI = TOn(i)-overlapWin:TOn(i+1)-overlapWin;
                    %         end
                    
                    thisROI = TOn(i):TOn(i+1)-1;
                    
                    offsetLP = 0;
                    offsetHP = 0;
                    offsetHP_R = 0;
                    
                    CDC = [];
                    CDC.AllData = NaN(numel(thisROI), numel(chanSet));
                    
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
                        FigH = figure(300); clf;
                        subplot(2, 1, 1)
                        plot(SegData_s, Data_SegData + offsetLP, 'k'); %title( ['Raw Voltage']);
                        text(SegData_s(1), Data_SegData(1)+obj.Plotting.rawOffset/2, ['Ch-' num2str(s)])
                        grid 'on'
                        
                        % Low Frequency
                        %plot(SegData_s, DataSeg_LF - Plotting.rawOffset, 'b');
                        
                        % High Pass Rectified
                        subplot(2, 1, 2)
                        % High Pass
                        hold on
                        plot(SegData_s, DataSeg_HF + offsetHP);
                        plot(SegData_s, DataSeg_rect_HF - obj.Plotting.hpRectOffset, 'r');
                        grid 'on'
                        
                        
                        %% Final Fig modifications
                        
                        figure(FigH)
                        subplot(2, 1, 1)
                        axis tight
                        ylim(obj.Plotting.rawYlim);
                        title(['Raw Voltage: '  obj.Plotting.titleTxt ' | ' sprintf('%03d', i)])
                        
                        subplot(2, 1, 2)
                        axis tight
                        ylim(obj.Plotting.hpRectYlim);
                        title( ['HF Rectified: ' obj.Plotting.titleTxt])
                        xlabel('Time [s]')
                        
                        saveName = [PlotDir obj.Plotting.saveTxt '_Raw-HP-singleChan_' sprintf('%03d', i)];
                        plotpos = [0 0 30 15];
                        print_in_A4(0, saveName, '-djpeg', 0, plotpos);
                        
                        
                    end
                    %% Saving Data
                    saveName = [PlotDir obj.Plotting.saveTxt '_CSD_' sprintf('%03d', i) '_' CDCSaveTxt '.mat'];
                    save(saveName, 'CDC', '-v7.3')
                    disp(['Saved: ' saveName])
                end
            end
        end
        
        %% Preparation for Sebastians SWR detection
        function [obj] = prepareDataForShWRDetection_Python(obj, chanOverride, durCutoffOverride)
            dbstop if error
            if nargin <3
                chanOverride = obj.REC.bestChs(1);
                durCutoffOverride = 1800;
            end
            
            chanToUse = chanOverride;
            durCutoff_s = durCutoffOverride;
            Fs = obj.Session.sampleRate;
            samples = obj.Session.samples;
            
            if samples > 1800*Fs
                durCutoff_s = 1800;
            end
            
            SessionDir = obj.Session.SessionDir;
            
            obj.Session.SessionDir;
            
            TOn=1:durCutoff_s*Fs:samples;
            nCycles=numel(TOn);
            
            eval(['fileAppend = ''100_CH' num2str(chanToUse) '.continuous'';'])
            fileName = [SessionDir fileAppend];
            
            [data, timestamps, info] = load_open_ephys_data(fileName);
            thisSegData_s = timestamps(1:end) - timestamps(1);
            
            saveDir = [SessionDir 'SWR-Python' obj.DIR.dirD];
            
            if exist(saveDir, 'dir') == 0
                mkdir(saveDir);
                disp(['Created: '  saveDir])
            end
            
            INFO.dataDir = fileName;
            INFO.fs = Fs;
            INFO.samples = samples;
            
            for i=1:nCycles
                dataSegs_V_raw = []; data_t_s = [];
                
                if i == nCycles
                    thisROI = TOn(i): samples;
                else
                    thisROI = TOn(i):TOn(i+1)-1;
                end
                
                disp(['Cycle=' num2str(i) '/' num2str(nCycles)])
                
                dataSegs_V_raw = data(thisROI);
                data_t_s = thisSegData_s(thisROI);
                Fs = info.header.sampleRate;
                
                disp('Saving...')
                saveName = [saveDir obj.Session.time '-Ch-' num2str(chanToUse) '_' sprintf('%03d', i) '.mat'];
                save(saveName, 'dataSegs_V_raw', 'data_t_s', 'INFO', '-v7.3')
                disp(['Saving:' saveName])
                %}
            end
            
        end
        
        function [obj] = prepareDataForShWRDetection_FullFile_Python(obj, chanOverride)
            dbstop if error
            if nargin <2
                chanOverride = obj.REC.bestChs(1);
            end
            
            chanToUse = chanOverride;
            Fs = obj.Session.sampleRate;
            samples = obj.Session.samples;
            
            SessionDir = obj.Session.SessionDir;
            obj.Session.SessionDir;
            
            eval(['fileAppend = ''100_CH' num2str(chanToUse) '.continuous'';'])
            fileName = [SessionDir fileAppend];
            
            [data, timestamps, info] = load_open_ephys_data(fileName);
            thisSegData_s = timestamps(1:end) - timestamps(1);
            
            saveDir = [SessionDir 'SWR-Python' obj.DIR.dirD];
            
            if exist(saveDir, 'dir') == 0
                mkdir(saveDir);
                disp(['Created: '  saveDir])
            end
            
            INFO.dataDir = fileName;
            INFO.fs = Fs;
            INFO.samples = samples;
            
            
            dataSegs_V_raw = data;
            data_t_s = thisSegData_s;
            Fs = info.header.sampleRate;
            
            disp('Saving...')
            saveName = [saveDir obj.Session.time '-Ch-' num2str(chanToUse) '_py_fullFile.mat'];
            save(saveName, 'dataSegs_V_raw', 'data_t_s', 'INFO', '-v7.3')
            disp(['Saved: ' saveName])
            
        end
        
        %% SWR Analysis
        function [obj] = SWR_PythonDetections_shapeStatistics(obj)
            
            SWR_Python_Dir = [obj.Session.SessionDir 'SWR-Python' obj.DIR.dirD];
            obj.DIR.SWR_Python_Dir = SWR_Python_Dir;
            
            obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
            obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
            
            
            textSearch = '*export_ripples*'; % text search for ripple detection file
            SWR_DetectionsDir = dir(fullfile(SWR_Python_Dir,textSearch));
            
            textSearch = '*_data*'; % text search for data .mat file
            SWR_DataDir = dir(fullfile(SWR_Python_Dir,textSearch));
            
            rD = load([SWR_Python_Dir SWR_DetectionsDir.name]);
            rippleDetections = double(rD.data); % ins samples of the original data file
            rippleDetectionsx50 = rippleDetections*50; % we do this cuz the resolution of the python code is 50
            nRippleDetections = numel(rippleDetectionsx50);
            
            disp('Loading data...')
            sD = load([SWR_Python_Dir SWR_DataDir.name]);
            
            swrData =  sD.dataSegs_V_raw;
            Fs =  sD.INFO.fs;
            
            %% Defining Filters
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
            
            
            %% Filtering Data
            
            [V_uV_data_full,nshifts] = shiftdim(swrData',-1);
            
            thisSegData = V_uV_data_full(:,:,:);
            thisSegData_s = sD.data_t_s;
            
            disp('Filtering...')
            %DataSeg_FNotch = squeeze(fobj.filt.FN.getFilteredData(thisSegData));
            DataSeg_HF = squeeze(fobj.filt.FH2.getFilteredData(thisSegData));
            DataSeg_LF = squeeze(fobj.filt.FL.getFilteredData(thisSegData));
            
            win_s = 1;
            win_samp = win_s*Fs;
            timestamps_samp = -win_samp:1:win_samp;
            timestamps_ms = (timestamps_samp/Fs)*1000;
            
            for j = 1:nRippleDetections
                
                if rippleDetectionsx50(j) - win_samp > 0 && rippleDetectionsx50(j)+ win_samp <  sD.INFO.samples
                    
                    thisROI = rippleDetectionsx50(j)-win_samp:rippleDetectionsx50(j)+win_samp;
                    
                    allSWRs_raw(:,j) = swrData(thisROI);
                    allSWRs_HP(:,j) = DataSeg_HF(thisROI);
                    allSWRs_LF(:,j) = DataSeg_LF(thisROI);
                    
                end
            end
            
            meanRipple_raw = nanmean(allSWRs_raw, 2);
            medianRipple_raw = nanmedian(allSWRs_raw, 2);
            sem_raw = (std(allSWRs_raw'))/(sqrt(size(allSWRs_raw, 2)));
            
            meanRipple_LF = nanmean(allSWRs_LF, 2);
            medianRipple_LF = nanmedian(allSWRs_LF, 2);
            sem_LF = (std(allSWRs_LF'))/(sqrt(size(allSWRs_LF, 2)));
            
            %meanRipple_HP = nanmean(abs(allSWRs_HP), 2);
            meanRipple_HP = nanmean(allSWRs_HP, 2);
            sumRipple_HP = sum(allSWRs_HP, 2);
            medianRipple_HP = nanmedian(allSWRs_HP, 2);
            sem_HP = (std(allSWRs_HP'))/(sqrt(size(allSWRs_HP, 2)));
            
            %%
            figH = figure(100); clf
            subplot(5, 1, [1 2 3 4])
            jbfill(timestamps_ms,[meanRipple_raw'+sem_raw],[meanRipple_raw'-sem_raw],[.5,0.5,.5],[.5,0.5,.5],[],.3);
            hold on
            plot(timestamps_ms, meanRipple_raw, 'k')
            
            jbfill(timestamps_ms,[meanRipple_LF'+sem_LF],[meanRipple_LF'-sem_LF],[.5,0.5,.5],[.5,0.5,.5],[],.3);
            hold on
            plot(timestamps_ms, meanRipple_LF, 'r')
            title( ['SWR: ' obj.Plotting.titleTxt])
            
            subplot(5, 1, 5)
            jbfill(timestamps_ms,[meanRipple_HP'+sem_HP],[meanRipple_HP'-sem_HP],[.5,0.5,.5],[.5,0.5,.5],[],.3);
            hold on
            %jbfill(timestamps_ms,[sumRipple_HP'+sem_HP],[sumRipple_HP'-sem_HP],[.5,0.5,.5],[.5,0.5,.5],[],.3);
            plot(timestamps_ms, meanRipple_HP, 'k')
            
            xlabel('Time [ms]')
            obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
            obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
            
            %%
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            figure(figH)
            saveName = [PlotDir obj.Plotting.saveTxt '_SWR_shape'];
            plotpos = [0 0 10 20];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            
            %% Package data
            SWR.allSWRs_raw = allSWRs_raw;
            SWR.allSWRs_raw_mean = meanRipple_raw;
            SWR.allSWRs_raw_median = medianRipple_raw;
            SWR.allSWRs_raw_sem = sem_raw;
            
            SWR.allSWRs_LF = allSWRs_LF;
            SWR.allSWRs_LF_mean = meanRipple_LF;
            SWR.allSWRs_LF_median = medianRipple_LF;
            SWR.allSWRs_LF_sem = sem_LF;
            
            SWR.allSWRs_HP = allSWRs_HP;
            SWR.allSWRs_HP_mean = meanRipple_HP;
            SWR.allSWRs_HP_median = medianRipple_HP;
            SWR.allSWRs_HP_sem = sem_HP;
            
            SWR.detections_samps = rippleDetectionsx50;
            SWR.timestamps_ms = timestamps_ms;
            SWR.win_samp = win_samp;
            SWR.Fs = Fs;
            
            
            %% Saving Data
            saveName = [SWR_Python_Dir 'SWR_data.mat'];
            save(saveName, 'SWR', '-v7.3')
            disp(['Saved: ' saveName])
            
        end
        
        function [obj] = SWR_wavelet(obj)
            
            
            %% Load "SWR_data.mat"
            
            textSearch = '*SWR_data.mat*'; % text search for ripple detection file
            SWR_datafile = dir(fullfile(obj.DIR.SWR_Python_Dir,textSearch));
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            
            disp('Loading...')
            sD = load([obj.DIR.SWR_Python_Dir SWR_datafile.name]);
            
            
            Fs = sD.SWR.Fs;
            
            waveletInd = 4;
            for j = 1:2
                
                if j ==1
                    RawData = sD.SWR.allSWRs_raw_mean;
                    Wavdata = sD.SWR.allSWRs_HP_mean;
                    figH = figure(100+j);clf
                    clims = [0 .5];
                    saveName = [PlotDir obj.Plotting.saveTxt '_SWR_wavelet_mean'];
                elseif j==2
                    RawData = sD.SWR.allSWRs_raw(:,waveletInd );
                    Wavdata = sD.SWR.allSWRs_HP(:,waveletInd );
                    saveName = [PlotDir obj.Plotting.saveTxt '_SWR_wavelet_single'];
                    clims = [0 20];
                    figH = figure(100+j);clf
                end
                
                %thisSegData_wav = Wavdata(1:6000);
                thisSegData_wav = Wavdata;
                [thisSegData_wav,nshifts] = shiftdim(thisSegData_wav',-1);
                
                dsf = 20;
                Fsd = Fs/dsf;
                hcf = 400;
                [n_ch,n_tr,N] = size(thisSegData_wav);
                
                [bb,aa] = butter(2,hcf/(Fs/2),'low');
                V_ds = reshape(permute(thisSegData_wav,[3 1 2]),[],n_ch*n_tr);
                V_ds = downsample(filtfilt(bb,aa,V_ds),dsf);
                V_ds = reshape(V_ds,[],n_ch,n_tr);
                
                %
                [N,n_chs,n_trials] = size(V_ds);
                nfreqs = 60;
                min_freq = 1.5;
                max_freq = 800;
                Fsd = Fs/dsf;
                min_scale = 1/max_freq*Fsd;
                max_scale = 1/min_freq*Fsd;
                wavetype = 'cmor1-1';
                scales = logspace(log10(min_scale),log10(max_scale),nfreqs);
                wfreqs = scal2frq(scales,wavetype,1/Fsd);
                
                use_ch = 1;
                cur_V = squeeze(V_ds(:,use_ch,:));
                V_wave = cwt(cur_V(:),scales,wavetype);
                V_wave = reshape(V_wave,nfreqs,[],n_trials);
                
                %% Mean PLot
                tr =1;
                ax1 = subplot(3,1,1);
                plot(sD.SWR.timestamps_ms,RawData, 'k');
                axis tight
                xlim([-300 300])
                title( ['SWR-Wavelet: ' obj.Plotting.titleTxt])
                
                ax2 = subplot(3,1,2);
                plot(sD.SWR.timestamps_ms,Wavdata, 'k');
                axis tight
                xlim([-300 300])
                
                %bla= 22:0.04:22.50;
                %set(gca, 'xtick', bla)
                
                ax3 = subplot(3,1,3);
                pcolor((1:N)/Fsd,wfreqs,abs(squeeze(V_wave(:,:,tr))));shading flat
                %set(gca,'yscale','log');
                axis tight
                ylim([0 800])
                %caxis(clims);
                caxis(clims);
                xlim([0.7 1.3])
                
                xlabel('Time [ms]')
                ylabel('Frequency [Hz]')
                
                %%
                figure(figH)
                plotpos = [0 0 10 20];
                print_in_A4(0, saveName, '-djpeg', 0, plotpos);
                
                disp('')
            end
            
        end
        
        function [obj] = SWR_raster(obj)
            
            %% Load "SWR_data.mat"
            
            textSearch = '*SWR_data.mat*'; % text search for ripple detection file
            SWR_datafile = dir(fullfile(obj.DIR.SWR_Python_Dir,textSearch));
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            
            disp('Loading...')
            sD = load([obj.DIR.SWR_Python_Dir SWR_datafile.name]);
            
            Fs = sD.SWR.Fs;
            SWRDetections_samps = sD.SWR.detections_samps;
            
            figure(100); clf
            binSize = 10;
            length_this_stim = binSize *Fs;
            TOns = 1:length_this_stim:SWRDetections_samps(end);
            nTOns = numel(TOns);
            
            allSpksFR = zeros(length_this_stim,1);
            
            spk_size_y = 0.005;
            y_offset_between_repetitions = 0.001;
            
            figH = figure(100); clf
            subplot(1, 5, [1 2 3 4])
            FreqPLot = [];
            
            for s = 1 : nTOns-1
                start_stim = TOns(s);
                stop_stim = TOns(s+1)-1;
                
                %must subtract start_stim to arrange spikes relative to onset
                
                these_spks_on_chan = SWRDetections_samps(SWRDetections_samps >= start_stim & SWRDetections_samps <= stop_stim)-start_stim;
                
                y_low =  (s * spk_size_y - spk_size_y);
                y_high = (s * spk_size_y - y_offset_between_repetitions);
                
                spk_vct = repmat(these_spks_on_chan, 2, 1); % this draws a straight vertical line
                this_run_spks = size(spk_vct, 2);
                ln_vct = repmat([y_high; y_low], 1, this_run_spks); % this defines the line height
                
                line(spk_vct, ln_vct, 'LineWidth', 0.5, 'Color', 'k');
                
                nbr_spks = size(these_spks_on_chan, 2);
                
                FreqPLot(s) = nbr_spks;
            end
            
            xtickss = 0:2*Fs:10*Fs;
            axis tight
            
            set(gca, 'xtick', xtickss)
            xtickabs = {'0', '2', '4', '6', '8', '10'};
            set(gca, 'xticklabel', xtickabs )
            xlabel('Time [s]')
            title( ['SWR-Raster: ' obj.Plotting.titleTxt])
            
            subplot(1, 5, 5); cla
            
            FreqPLot_Hz = FreqPLot/binSize;
            xes = 1:1:numel(FreqPLot_Hz);
            plot(smooth(FreqPLot_Hz), xes)
            axis tight
            xtickss = 0:0.5:2.5;
            set(gca, 'xtick', xtickss)
            xlim([0 1])
            title('SWR Rate')
            xlabel('Freq. [Hz]')
            
            saveName = [PlotDir obj.Plotting.saveTxt '_SWR_raster'];
            
            plotpos = [0 0 15 10];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            %print_in_A4(0, saveName, '-depsc', 0, plotpos);
            
            
            
        end
        
        %% Spike Sorting
        
        function [obj] = runKilosortFromConfigFile(obj, pathToConfigFile, nameOfConfigFile)
            
            run(fullfile(pathToConfigFile, nameOfConfigFile))
            
            obj.ops = ops;
            
            %% Chan Config
            %{
            Nchannels = 16;
            connected = true(Nchannels, 1);
            chanMap   = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
            %chanMap   = [1:Nchannels];
            chanMap0ind = chanMap - 1;
            xcoords   = ones(Nchannels,1);
            ycoords   = 50 * [1:16]; % 50 micron space,
            kcoords   = ones(Nchannels,1); % grouping of channels (i.e. tetrode groups)
            
            fs = 30000; % sampling frequency
            save('C:\Users\Administrator\Documents\code\GitHub\code2018\KiloSortProj\KiloSortConfigFiles\chanMap.mat', 'chanMap','connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')
            %}
            
%             Nchannels = 2;
%             connected = true(Nchannels, 1);
%             %chanMap   = [6 11 3 14 1 16 2 15 5 12 4 13 7 10 8 9];
%             chanMap   = [2 10];
%             chanMap0ind = chanMap - 1;
%             xcoords   = ones(Nchannels,1);
%             ycoords   = ones(Nchannels,1);
%             kcoords   = ones(Nchannels,1); % grouping of channels (i.e. tetrode groups)
%             
%             fs = 30000; % sampling frequency
%             save('F:\TUM\SWR-Project\KiloSortConfigFiles\testMap.mat', 'chanMap','connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')
            
% 
%             Nchannels = 16;
%             connected = true(Nchannels, 1);
%             chanMap   = [1:16];
%             chanMap0ind = chanMap - 1;
%             
%             xcoords   = ones(Nchannels,1);
%              ycoords   = ones(Nchannels,1);
%              kcoords   = ones(Nchannels,1); % grouping of channels (i.e. tetrode groups)
% 
%             fs = 30000; % sampling frequency
%             save('C:\Users\Administrator\Documents\code\GitHub\code2018\KiloSortProj\KiloSortConfigFiles\chanMap16ChanSeq.mat', 'chanMap','connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')
% 


            %%
            tic; % start timer
            %
            if ops.GPU
                gpuDevice(1); % initialize GPU (will erase any existing GPU arrays)
            end
            
            if strcmp(ops.datatype , 'openEphys')
                disp('Converting openephys file...')
                ops = convertOpenEphysToRawBInary(ops);  % convert data, only for OpenEphys
            end
            disp('Finished...')
            %
            %%
            disp('Pre-processing...')
            [rez, DATA, uproj] = preprocessData(ops); % preprocess data and extract spikes for initialization
            disp('Fitting templates...')
            rez                = fitTemplates(rez, DATA, uproj);  % fit templates iteratively
            disp('Extracting final spike times...')
            rez                = fullMPMU(rez, DATA);% extract final spike times (overlapping extraction)
            
            % AutoMerge. rez2Phy will use for clusters the new 5th column of st3 if you run this)
            %     rez = merge_posthoc2(rez);
            
            % save matlab results file
            save(fullfile(ops.root,  'rez.mat'), 'rez', '-v7.3');
            
            % save python results file for Phy
            rezToPhy(rez, ops.root);
            
            % remove temporary file
            delete(ops.fproc);
            
            disp('Finished')
            
            %%s
            
        end
        
        
        function [obj] = importPhyClusterSpikeTimes(obj, clustType)
            
            %clustType
            % - 0 = noise
            % - 1 = mua
            % - 2 = good
            % - 3 = unsorted
            
            dataDir = obj.Session.SessionDir;
          
            %% load some spikes and compute some basic things
                
                % clu is a length nSpikes vector with the cluster identities of every spike
                clu = readNPY(fullfile(dataDir,  'spike_clusters.npy')); %cluster IDs
                
                % ss is a length nSpikes vector with the spike time of every spike (in samples)
                ss = readNPY(fullfile(dataDir,  'spike_times.npy'));
                
                % [cids, cgs] = readClusterGroupsCSV(fullfile(folderNames{f},  'cluster_groups.csv'));
                [cids, cgs] = readClusterGroupsCSV(fullfile(dataDir,  'cluster_group.tsv'));
                
                % cids is length nClusters, the cluster ID numbers
                % cgs is length nClusters, the "cluster group":
                % - 0 = noise
                % - 1 = mua
                % - 2 = good
                % - 3 = unsorted
                
                ClustersInds = find(cgs==clustType);
                ClusterIDs = cids(ClustersInds);
                
                spikeTimes_samps = [];
                for j = 1:numel(ClusterIDs)
                    
                    spikeTimesInds = find(clu == ClusterIDs(j));
                    spikeTimes_samps{j} = double(ss(spikeTimesInds));
                end
                
                clust.clustType = clustType;
                clust.ClusterIDs = ClusterIDs;
                clust.spikeTimes_samps = spikeTimes_samps;
                clust.dataDir = dataDir;
                clust.cids = cids;
                clust.cgs = cgs;
                clust.cgs = cgs;
                clust.ss = ss;
                clust.clu = clu;
            
                %% Saving
                SWR_Python_Dir = [obj.Session.SessionDir 'SWR-Python' obj.DIR.dirD];
                obj.DIR.SWR_Python_Dir  = SWR_Python_Dir;
                
                saveName = [obj.DIR.SWR_Python_Dir 'ClustType-' num2str(clustType) '.mat'];
                
                save(saveName, 'clust', '-v7.3')
                disp(['Saved: ' saveName])
                
                
        end
        
        function [obj]  = loadClustTypesAndMakeSpikePlots(obj, clustType)
            dbstop if error
            
            SWR_Python_Dir = [obj.Session.SessionDir 'SWR-Python' obj.DIR.dirD];
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
            obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
            
            if clustType == 2
                clustChanPairing = obj.REC.GoodClust_2;
                clustFile = 'ClustType-2.mat';
                saveTag = 'GoodChan';
                Yss = [-300 200];
            elseif clustType == 1
                clustChanPairing = obj.REC.MUAClust_1;
                clustFile = 'ClustType-1.mat';
                saveTag = 'muaChan';
                Yss = [-300 200];
            end
            
            ChansToLoad = clustChanPairing(:,2);
            Clusts = clustChanPairing(:,1);
            
            cl = load([SWR_Python_Dir clustFile]);
            
            ClusterIDs = cl.clust.ClusterIDs;
            nClusterIDs = numel(ClusterIDs);
            spikeTimes_samps = cl.clust.spikeTimes_samps;
            
            % Make sure the clusters match
            if sum(ismember(Clusts, ClusterIDs)) ~= nClusterIDs
                disp('Cluster mismatch')
                keyboard
            end
            
            %% Load ephys file and make some plots
            
            for j = 1:nClusterIDs
                
                thisChan = ChansToLoad(j);
                thisClustSpikeTimes = spikeTimes_samps{j};
                
                eval(['fileAppend = ''100_CH' num2str(thisChan) '.continuous'';'])
                fileName = [obj.Session.SessionDir fileAppend];
                
                [data, timestamps, info] = load_open_ephys_data(fileName);
                
                Fs = info.header.sampleRate;
                win_samp = 0.010*Fs;
                timepoints_ms = (-win_samp:1:win_samp)/Fs*1000;
                
                allSpks = [];
                for sp = 1:numel(thisClustSpikeTimes)
                    
                    if thisClustSpikeTimes(sp) - win_samp > 0 && thisClustSpikeTimes(sp) + win_samp < obj.Session.samples
                        roi = thisClustSpikeTimes(sp) - win_samp : thisClustSpikeTimes(sp) + win_samp;
                        
                        %figure(100); clf;
                        %hold on
                        allSpks(:,sp) = data(roi);
                        %plot(timpoints, data(roi));
                        %ylim([-300 300])
                        %pause
                    end
                end
                
                %% Plotting
                
                figH = figure(100+j); clf
                
                meanSpk = nanmean(allSpks, 2);
                medianSpk = nanmedian(allSpks, 2);
                semSpk = (std(allSpks'))/(sqrt(size(allSpks, 2)));
                jbfill(timepoints_ms,[meanSpk'+semSpk],[meanSpk'-semSpk],[.5,0.5,.5],[.5,0.5,.5],[],.3);
                hold on
                %jbfill(timepoints_ms,[medianSpk'+semSpk],[medianSpk'-semSpk],[.5,0.5,.5],[.5,0.5,.5],[],.3);
                plot(timepoints_ms, meanSpk, 'k')
                %plot(timepoints_ms, medianSpk, 'b')
                axis tight
                ylim(Yss)
                title([obj.Plotting.titleTxt ': Channel ' num2str(thisChan) ', n = ' num2str(numel(thisClustSpikeTimes)) ' spks' ])
                xlabel('Time [ms]')
                ylabel('uV')
                
                saveName = [PlotDir obj.Plotting.saveTxt '_Spikes_Chan-' num2str(thisChan) '-' saveTag];
                
                plotpos = [0 0 15 10];
                print_in_A4(0, saveName, '-djpeg', 0, plotpos);
               disp('')
                
            end
            
        end
        
        function [obj]  = loadClustTypesAndAlignToSWR_Raster_ClustType(obj, clustType)
            %if nargin < 2    
            %    chansToUse = obj.REC.GoodClust_2(:, 2);
            %end
            
            SWR_Python_Dir = [obj.Session.SessionDir 'SWR-Python' obj.DIR.dirD];
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
            obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
            
            if clustType == 2
                clustChanPairing = obj.REC.GoodClust_2;
                clustFile = 'ClustType-2.mat';
                saveTag = 'GoodChan';
                Yss = [-300 200];
            elseif clustType == 1
                clustChanPairing = obj.REC.MUAClust_1;
                clustFile = 'ClustType-1.mat';
                saveTag = 'muaChan';
                Yss = [-300 200];
            end
            
             ChansToLoad = clustChanPairing(:,2);
             
            cl= load([SWR_Python_Dir clustFile]);
            
            ClusterIDs = cl.clust.ClusterIDs;
            nClusterIDs = numel(ClusterIDs);
            spikeTimes_samps = cl.clust.spikeTimes_samps;
            
            
            depthOrder = obj.REC.allChs; % first is deepest
            
            for o = 1:numel(spikeTimes_samps)
                thisOrderInd(o) = find(depthOrder == ChansToLoad(o)); % this is the order of the available chans from lowest to highest
            end
            
            [B, sortInds] = sort(thisOrderInd, 'ascend');
            
            %% Load SWR detection File
            textSearch = '*export_ripples.mat*'; % text search for ripple detection file
            shWDetectionsFile = dir(fullfile(obj.DIR.SWR_Python_Dir,textSearch));
           
            rD = load([obj.DIR.SWR_Python_Dir shWDetectionsFile.name]);
            rippleDetections = double(rD.data); % ins samples of the original data file
            rippleDetectionsx50 = rippleDetections*50; % we do this cuz the resolution of the python code is 50
            nRippleDetections = numel(rippleDetectionsx50);
            
            %% Now align the spikes to these events;
            
            Fs = obj.Session.sampleRate;
            spikeWin_s = 0.05; % 50 ms
            %spikeWin_s = 0.1; % 50 ms
            spikeWin_samp = spikeWin_s* Fs;
            thisMaxLength = -spikeWin_samp:spikeWin_samp;
            thisMaxLength_ms = thisMaxLength/Fs*1000;
            
            FROverChans = [];
            spikesOverChans = [];
            for q = 1:numel(spikeTimes_samps)
                
                intFR  = zeros(1,numel(thisMaxLength)); % we define a vector for integrated FR
                thisInd = sortInds(q);
               
                theseSpikeTimes = spikeTimes_samps{thisInd};
                
                allSpikes = [];
                
                for o = 1: nRippleDetections
                    thisRipple = rippleDetectionsx50(o);
                    
                    spikeWinOn = thisRipple - spikeWin_samp;
                    spikeWinOff = thisRipple + spikeWin_samp;
                    
                    these_spks_on_chan = theseSpikeTimes(theseSpikeTimes >= spikeWinOn & theseSpikeTimes <= spikeWinOff)-spikeWinOn; % Need it to be relative here
                    allSpikes{o} = these_spks_on_chan;
                    
                    nSpks = numel(these_spks_on_chan);
                    
                    % add a 1 to the FR vector for every spike
                    for ind = 1 : nSpks
                        if these_spks_on_chan(ind) ~= 0
                            intFR(these_spks_on_chan(ind)) = intFR(these_spks_on_chan(ind)) +1;
                        end
                    end
                    
                end
                
                spikesOverChans{q} = allSpikes;
                FROverChans{q} = intFR;
                
            end
            %%
            cols = {[0.2 0.3 0.6],  [0.2 0.3 0.3],  [0.2 0.3 0.01], [0.1 0.1 0.3], [0.5 0.5 0.6], [0.2 0.8 0.8]...
                    [0.3 0.3 0.6],  [0.8 0.2 0.3],  [0.2 0.4 0.9], [0.5 0.8 0.6], [0.2 0.3 0.2], [0.1 0.3 0.2]...
                    [0.5 0.3 0.6],  [0.3 0.5 0.3],  [0.8 0.5 0.6], [0.8 0.4 0.2], [0.2 0.8 0.2], [0.8 0.8 0.2]...
                    [0.8 0.3 0.6],    [0.1 0.3 0.4], [0.5 0.5 0.8], [0.8 0.3 0.8], [0.2 0.8 0.2], [0.8 0.3 0.2]};
           
        %    cols = {[0.2 0.3 0.0], [0.2 0.3 0.6],  [0.2 0.3 0.3],  [0.1 0.1 0.3], [0.5 0.5 0.6], [0.7 0.2 0.2]};
          
            %cols = {'k', 'b', 'r', 'm', 'g'
            
            
            %%
             figH = figure(104);  clf
            subplot(5, 1, [2 3 4]); cla
            cnt = 1;  
            for q = 1:numel(spikeTimes_samps)
               
                thisInd = sortInds(q);
                thisChanLabel = ChansToLoad(thisInd);
                
                allSpikes = spikesOverChans{thisInd};
                
                for o = 1: nRippleDetections
                    theseSpikes = allSpikes{o};
                    xpoints = ones(numel(theseSpikes))*cnt;
                    
                    if o ==1
                        text(0, cnt+300, ['Chan- ' num2str(thisChanLabel)])
                    end
                    
                    hold on
                    plot(theseSpikes, xpoints, '.', 'color', cols{q}, 'linestyle', 'none', 'MarkerFaceColor',cols{q},'MarkerEdgeColor',cols{q})
                    
                    cnt = cnt +1;
                    
                end
            end
            
            set(gca,'xtick',[]);
            set(gca,'ytick',[]);
            %%
            axis tight
            xlim([0 numel(thisMaxLength)])
            
            subplot(5, 1, 5); cla
            hold on
            for q = 1:numel(spikeTimes_samps)
                
                plot(thisMaxLength_ms, smooth(FROverChans{q}, 0.01*Fs), 'color', cols{q}, 'linewidth', 2)
                %plot(thisMaxLength_ms, FROverChans{q}, 'color', cols{q}, 'linewidth', 2)
                
            end
            axis tight
            xlim([-spikeWin_s*1000 +spikeWin_s*1000])
            xlabel('Time [ms]')
            %%
              textSearch = '*_data.mat*'; % text search for ripple detection file
            shWDataFile = dir(fullfile(obj.DIR.SWR_Python_Dir,textSearch));
            disp('Loading data...')
            sD = load([SWR_Python_Dir shWDataFile(1).name]);
          
            swrData =  sD.dataSegs_V_raw;
            Fs =  sD.INFO.fs;
            
            %%
            allRipples = [];
            for o = 1:5
                
              
                
                %thisRipple = rippleDetectionsx50(o);
                thisRipple = rippleDetectionsx50(o);
                
                roi = thisRipple - spikeWin_samp: thisRipple + spikeWin_samp;
              
                
                allRipples(o,:) = swrData(roi);
                
                
                %title(num2str(o))
                %axis tight
                %xlim([-50 50])
                %ylim([-400 0])
                %pause
            end
            
            meanripple = mean(allRipples);
            subplot(5, 1, 1); cla
            plot(thisMaxLength_ms, allRipples(2,:), 'color', 'k')
            title([obj.Plotting.titleTxt ': SWR-Aligned spikes - ' clustFile(1:end-4)])
            
            %%
            
            
              saveName = [PlotDir obj.Plotting.saveTxt '_SWR-AlignedSpikes-' saveTag];
                
                plotpos = [0 0 10 20];
                print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            
            
            
        end
        
        
        %% Files for NSKToolbox
        
        function [obj] = getFreqBandDetection(obj)
            chanToUse = obj.REC.bestChs(1);
            SessionDir = obj.Session.SessionDir;
            obj.Session.SessionDir;
            
            eval(['fileAppend = ''100_CH' num2str(chanToUse) '.continuous'';'])
            fileName = [SessionDir fileAppend];
            
            [data, timestamps, info] = load_open_ephys_data(fileName);
            thisSegData_s = timestamps(1:end) - timestamps(1);
            Fs = info.header.sampleRate;
            
            obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
            obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            
            %% Filters
            fObj = filterData(Fs);
            
            fobj.filt.F=filterData(Fs);
            fobj.filt.F.downSamplingFactor=120; % original is 128 for 32k
            fobj.filt.F=fobj.filt.F.designDownSample;
            fobj.filt.F.padding=true;
            fobj.filt.FFs=fobj.filt.F.filteredSamplingFrequency;
            
            fobj.filt.FL=filterData(Fs);
            %fobj.filt.FL.lowPassPassCutoff=4.5;
            %fobj.filt.FL.lowPassPassCutoff=20;
            %fobj.filt.FL.lowPassStopCutoff=30;
            fobj.filt.FL.lowPassPassCutoff=30;% this captures the LF pretty well for detection
            fobj.filt.FL.lowPassStopCutoff=40;
            fobj.filt.FL.attenuationInLowpass=20;
            fobj.filt.FL=fobj.filt.FL.designLowPass;
            fobj.filt.FL.padding=true;
            
            %fobj.filt.FL=filterData(Fs);
            %fobj.filt.FL.lowPassPassCutoff=4.5;
            %fobj.filt.FL.lowPassStopCutoff=6;
            %fobj.filt.FL.attenuationInLowpass=20;
            %fobj.filt.FL=fobj.filt.FL.designLowPass;
            %fobj.filt.FL.padding=true;
            
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
            
            %% Raw Data  - Parameters from [data]=getFreqBandDetection(obj,varargin)
            
            [V_uV_data_full,nshifts] = shiftdim(data',-1);
            thisSegData = V_uV_data_full(:,:,:);
            
            %addParameter(parseObj,'fMax',30,@isnumeric); %max freq. to examine
            %fMax = 30;
            fMax = 100;
            %addParameter(parseObj,'dftPoints',2^10,@isnumeric);
            dftPoints = 2^10';
            %addParameter(parseObj,'tStart',0,@isnumeric);
            %tStart = 0;
            %addParameter(parseObj,'win',1000*60*60,@isnumeric);
            %win = 1*60*60;
            %addParameter(parseObj,'maxDendroClusters',2,@isnumeric);
            maxDendroClusters = 2;
            
            %addParameter(parseObj,'segmentLength',1000);
            segmentLength = 1;
            %addParameter(parseObj,'WelchOL',0.5);
            WelchOL = 0.5;
            %addParameter(parseObj,'binDuration',10000);
            %binDuration = 10;
            binDuration = 10;
            
            %addParameter(parseObj,'cLim',0);
            %addParameter(parseObj,'hDendro',0);
            %addParameter(parseObj,'hSpectra',0);
            
            cLim = 0;
            hDendro = 0;
            hSpectra = 0;
            
            %%
            FMLong=fobj.filt.F.getFilteredData(thisSegData );
            
            %calculate initial parameters
            segmentSamples = round(segmentLength*fobj.filt.FFs);
            samplesOL = round(segmentSamples*WelchOL);
            samplesBin = round(binDuration*fobj.filt.FFs);
            
            nBins=floor(numel(FMLong)/samplesBin);
            
            if (numel(FMLong)/samplesBin)~=round(numel(FMLong)/samplesBin)
                nBins=nBins-1;
                FMLong=FMLong(1:(samplesBin*nBins));
                disp('Last bin in recording not included due to a missmatch between recording duration and binDuration');
            end
            
            FMLongB=reshape(FMLong,[samplesBin,nBins]);
            
            [pxx,f] = pwelch(FMLongB,segmentSamples,samplesOL,dftPoints,fobj.filt.FFs);
            %
            %figure(100); clf
            %plot(mean(10*log10(pxx)))
            p=find(f<fMax);
            pp=find(sum(pxx(p,:))<0.4e6);
            
            sPxx=pxx(p,pp);
            freqHz=f(p);
            normsPxx=bsxfun(@rdivide,sPxx,mean(sPxx,2));
            corrMat=corrcoef(normsPxx);
            
            if maxDendroClusters==2
                
                [DC,order,clusters]=DendrogramMatrix(corrMat,'linkMetric','euclidean','linkMethod','ward','maxClusters',maxDendroClusters);
                
                S1=mean(normsPxx(:,clusters==1),2);
                S2=mean(normsPxx(:,clusters==2),2);
                if mean(S1(1:3))>mean(S2(1:3))
                    crossFreq=freqHz(find(S2-S1>=0,1,'first'))
                else
                    crossFreq=freqHz(find(S1-S2>=0,1,'first'))
                end
            else
                crossFreq=[];order=[];clusters=[];
            end
            
            plotDendrogram =1;
            
            if plotDendrogram
                maxDendroClusters=2;
                
                if cLim==0
                    cLim=[];
                end
                
                if hDendro==0
                    hDendro=[];
                else
                    savePlots=[];
                end
                
                figh3 = figure(100); clf
                
                [DC,order,clusters,h]=DendrogramMatrix(corrMat,'linkMetric','euclidean','linkMethod','ward','maxClusters',maxDendroClusters,...
                    'toPlotBinaryTree',1,'cLim',cLim,'hDendro',hDendro,'plotOrderLabels',0);
                %h(3).Position=[0.9149    0.7595    0.0137    0.1667];
                ylabel(h(3),'Corr.');
                xlabel(h(2),'Segment');
                xlabel(h(1),'Distance');
                title(obj.Plotting.titleTxt)
                %%
                
                saveName = [PlotDir obj.Plotting.saveTxt '_FreqBandDetection'];
                
                plotpos = [0 0 25 15];
                print_in_A4(0, saveName, '-djpeg', 0, plotpos);
                %print_in_A4(0, saveName, '-depsc', 0, plotpos);
            end
            
        end
        
        
        function [obj] = plotDBRatio(obj)
            
            
            chanToUse = obj.REC.bestChs(1);
            SessionDir = obj.Session.SessionDir;
            obj.Session.SessionDir;
            
            eval(['fileAppend = ''100_CH' num2str(chanToUse) '.continuous'';'])
            fileName = [SessionDir fileAppend];
            
            [data, timestamps, info] = load_open_ephys_data(fileName);
            thisSegData_s = timestamps(1:end) - timestamps(1);
            Fs = info.header.sampleRate;
            
            obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
            obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            
            
            %% Filters
            
            fObj = filterData(Fs);
            
            fobj.filt.F=filterData(Fs);
            fobj.filt.F.downSamplingFactor=120; % original is 128 for 32k
            fobj.filt.F=fobj.filt.F.designDownSample;
            fobj.filt.F.padding=true;
            fobj.filt.FFs=fobj.filt.F.filteredSamplingFrequency;
            
            %fobj.filt.FL=filterData(Fs);
            %fobj.filt.FL.lowPassPassCutoff=4.5;
            %fobj.filt.FL.lowPassStopCutoff=6;
            %fobj.filt.FL.attenuationInLowpass=20;
            %fobj.filt.FL=fobj.filt.FL.designLowPass;
            %fobj.filt.FL.padding=true;
            
            fobj.filt.FL=filterData(Fs);
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
            
            %% Raw Data
            
            [V_uV_data_full,nshifts] = shiftdim(data',-1);
            
            thisSegData = V_uV_data_full(:,:,:);
            
            %% Get Filtered Data
            
            DataSeg_FN = fobj.filt.FN.getFilteredData(thisSegData);
            DataSeg_FL = fobj.filt.FL.getFilteredData(thisSegData);
            DataSeg_FH2 = fobj.filt.FH2.getFilteredData(thisSegData);
            [DataSeg_F, t_DS] = fobj.filt.F.getFilteredData(thisSegData);
            
            bla = squeeze(DataSeg_F);
            figure; plot(bla(1:1000));
            
            thisSegData_s = timestamps(1:end) - timestamps(1);
            
            %%
            
            %% Raw Data  - Parameters from data=getDelta2BetaRatio(obj,varargin)
            
            % This is all in ms
            %             addParameter(parseObj,'movLongWin',1000*60*30,@isnumeric); %max freq. to examine
            %             addParameter(parseObj,'movWin',10000,@isnumeric);
            %             addParameter(parseObj,'movOLWin',9000,@isnumeric);
            %             addParameter(parseObj,'segmentWelch',1000,@isnumeric);
            %             addParameter(parseObj,'dftPointsWelch',2^10,@isnumeric);
            %             addParameter(parseObj,'OLWelch',0.5);
            %
            reductionFactor = .05; % No reduction
            
            movWin_Var = 10*reductionFactor; % 10 s
            movOLWin_Var = 9*reductionFactor; % 9 s
            
            segmentWelch = 1*reductionFactor;
            OLWelch = 0.5*reductionFactor;
            
            dftPointsWelch =  2^10;
            %dftPointsWelch =  256;
            
            segmentWelchSamples = round(segmentWelch*fobj.filt.FFs);
            samplesOLWelch = round(segmentWelchSamples*OLWelch);
            
            movWinSamples=round(movWin_Var*fobj.filt.FFs);%obj.filt.FFs in Hz, movWin in samples
            movOLWinSamples=round(movOLWin_Var*fobj.filt.FFs);
            
            % run welch once to get frequencies for every bin (f) determine frequency bands
            [~,f] = pwelch(randn(1,movWinSamples),segmentWelchSamples,samplesOLWelch,dftPointsWelch,fobj.filt.FFs);
            
            deltaBandCutoff = 4;
            %betaBandLowCutoff = 15;
            %betaBandHighCutoff = 40;
            %betaBandLowCutoff = 25;
            %betaBandHighCutoff = 80;
            
            betaBandLowCutoff = 7;
            betaBandHighCutoff = 10;
            
            
            pfLowBand=find(f<=deltaBandCutoff);
            pfHighBand=find(f>=betaBandLowCutoff & f<betaBandHighCutoff);
            
            %%
            tmp_V_DS = buffer(DataSeg_F,movWinSamples,movOLWinSamples,'nodelay');
            pValid=all(~isnan(tmp_V_DS));
            
            [pxx,f] = pwelch(tmp_V_DS(:,pValid),segmentWelchSamples,samplesOLWelch,dftPointsWelch,fobj.filt.FFs);
            
            % Ratios
            deltaBetaRatioAll=zeros(1,numel(pValid));
            deltaBetaRatioAll(pValid)=(mean(pxx(pfLowBand,:))./mean(pxx(pfHighBand,:)))';
            
            % single elements
            deltaAll=zeros(1,numel(pValid));
            deltaAll(pValid)=mean(pxx(pfLowBand,:))';
            
            betaAll=zeros(1,numel(pValid));
            betaAll(pValid)=mean(pxx(pfHighBand,:))';
            
            % Pool all data ratios
            bufferedDeltaBetaRatio=deltaBetaRatioAll;
            bufferedDelta=deltaAll;
            bufferedBeta=betaAll;
            allV_DS = squeeze(DataSeg_F);
            
            %%
            sizestr = ['movWin =' num2str(movWin_Var) 's; movOLWin = ' num2str(movOLWin_Var) ' s'];
            Betacolor = [150 50 0]/255;
            Deltacolor = [0 50 150]/255;
            
            figh3 = figure(300); clf
            subplot(3, 1, 1)
            plot(betaAll*100, 'color', Betacolor, 'linewidth', 1)
            hold on
            plot(deltaAll, 'color', Deltacolor, 'linewidth', 1)
            axis tight
            %ylim([0 10000])
           %set(gca, 'xtick', [])
            legTxt = [{['Beta: ' num2str(betaBandLowCutoff) '-' num2str(betaBandHighCutoff) ' Hz']} , {['Delta: < ' num2str(deltaBandCutoff) ' Hz']} ];
            legend(legTxt)
            xlim([0 2500])
            
            subplot(3, 1, 2)
            plot(t_DS, squeeze(DataSeg_F), 'k')
            axis tight
            title('V_BP_DS')
            xlabel('Time [s]')
            axis tight
            xlim([0 125000])
            
            deltaBetaRatioAll_norm = deltaBetaRatioAll./(max(max(deltaBetaRatioAll)));
            subplot(3, 1, 3)
            axis tight
            hold on
            plot(smooth(deltaBetaRatioAll_norm, 5), 'linewidth', 1)
            title(['Delta/Beta Ratio | ' sizestr ])
            %set(gca, 'xtick', [])
            axis tight
            xlim([0 2500])
            %%
            plotpos = [0 0 20 30];
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            
            plot_filename = [PlotDir 'DB_Ratio'];
            print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
            
            
        end
        
        
        
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% ~~~~~Functions called by constructor
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function obj = getSessionInfo(obj,rfc)
            
            disp('Getting session info...')
            
            [avianSWR_DB] = avian_SWR_database(); % This is the database
            
            obj.HOST = gethostname;
            obj.INFO = avianSWR_DB(rfc).INFO;
            obj.Session = avianSWR_DB(rfc).Session;
            obj.DIR = avianSWR_DB(rfc).DIR;
            obj.REC = avianSWR_DB(rfc).REC;
            obj.Plotting = avianSWR_DB(rfc).Plotting;
            
            
        end
        
        function [obj] = findSessionDir(obj)
            
            birdDir=[obj.DIR.dataDir obj.INFO.birdName obj.DIR.dirD];
            
            FileSearch=obj.Session.time;
            %allDataFiles = dir(fullfile(dataDir,textSearch));
            
            allDataDirs=dir([birdDir 'Ephys' obj.DIR.dirD]);
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
                    SessionDir=[birdDir 'Ephys' obj.DIR.dirD dirName obj.DIR.dirD];
                    disp(['Search: ' FileSearch ' matches ' dirName ])
                    break
                end
            end
            
            obj.Session.SessionDir = SessionDir;
            obj.DIR.birdDir = birdDir;
            obj.DIR.dirName = dirName;
        end
        
    end
    
    methods (Hidden)
        %class constructor
        function obj = avianSWRAnalysis_OBJ(rfc)
            
            obj = getSessionInfo(obj, rfc);
            obj = findSessionDir(obj);
            
        end
    end
    
end
