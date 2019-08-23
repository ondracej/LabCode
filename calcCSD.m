
        function [] = calcCSD(obj, dataRecordingObj)
            
            Fs = obj.Session.sampleRate;
            recordingDuration_s = obj.Session.recordingDur_s;
            
            %SessionDir = obj.Session.SessionDir;
            %obj.Session.SessionDir;
            obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
            obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            
            
            fObj = filterData(Fs);
            
            fobj.filt.DS4Hz=filterData(Fs);
            fobj.filt.DS4Hz.downSamplingFactor=240; % 125 samples
            %fobj.filt.DS4Hz.lowPassCutoff=4;
            fobj.filt.DS4Hz.lowPassCutoff=35;
            fobj.filt.DS4Hz.padding=true;
            fobj.filt.DS4Hz=fobj.filt.DS4Hz.designDownSample;
            tmpFs=fobj.filt.DS4Hz.filteredSamplingFrequency;
            
            fobj.filt.FN =filterData(Fs);
            fobj.filt.FN.filterDesign='cheby1';
            fobj.filt.FN.padding=true;
            fobj.filt.FN=fobj.filt.FN.designNotch;
            
            %             fobj.filt.FL=filterData(Fs);
            %             fobj.filt.FL.lowPassPassCutoff=4.5;
            %             fobj.filt.FL.lowPassStopCutoff=6;
            %             fobj.filt.FL.attenuationInLowpass=20;
            %             fobj.filt.FL=fobj.filt.FL.designLowPass;
            %             fobj.filt.FL.padding=true;
            %             tmpFs=fobj.filt.FL.filteredSamplingFrequency;
            
            %seg_ms = 10000;
            seg_ms = 10000;
            
            TOn=1:seg_ms:recordingDuration_s*1000-seg_ms;
            nCycles = numel(TOn);
            
            %chanSelection = [2 7 15 10 13 12 14 11 1 8 16 9 3 6 4 5];
            chanSelection = [5 4 6 3 9 16 8 1 11 14 12 13 10 15 7 2]; %lowest
            
            nChans = numel(chanSelection);
            
            xticks = 0:tmpFs:seg_ms/1000*tmpFs;
            xlabs = [];
            for o = 1:numel(xticks)
                xlabs{o} = num2str(xticks(o)/tmpFs*1000);
            end
            
            for i = 1:nCycles
                allCDS = [];
                disp([num2str(i) '/' num2str(nCycles)])
                
                for j = 1:nChans
                    thisChan = chanSelection(j);
                    [MTmp, traw ] =dataRecordingObj.getData(thisChan,TOn(i),seg_ms);
                    [M_notch,t_notch]=fobj.filt.FN.getFilteredData(MTmp);
                    [Mtest,tTest]=fobj.filt.DS4Hz.getFilteredData(MTmp);
                    %[Mtest,tTest]=fobj.filt.FL.getFilteredData(MTmp);
                    
                    allCDS(:,j) = squeeze(Mtest);
                    allCDS_raw(:,j) = squeeze(M_notch);
                    
                end
                
                [CSDoutput, unitsCurrent, unitsLength]  = CSD(allCDS./1000,tmpFs,1E-4,'inverse',4E-4);
                %[CSDoutput]  = CSD(allCDS,tmpFs,1E-4);
                
                allCSDOutput{i} = CSDoutput;
                %%
                figure(100); clf
                
                pos = [0.05 0.70 0.9 0.25];
                axes('position',pos );cla
                invertChanSelection = 16:-1:1;
                chanSelectionInvert = fliplr(chanSelection);
                
                %subplot(3, 1, 1)
                offset = 0;
                for s = 1:nChans
                    thisChan = invertChanSelection(s);
                    hold on
                    plot((traw +TOn(i))/1000, allCDS_raw(:,thisChan)+offset, 'k')
                    offset = offset+150;
                end
                axis tight
                ylim([-400 2700]);
                
                %subplot(3, 1, 2)
                pos = [0.05 0.43 0.9 0.25];
                axes('position',pos );cla
                offset = 0;
                for s = 1:nChans
                    thisChan = invertChanSelection(s);
                    hold on
                    plot((tTest +TOn(i))/1000, allCDS(:,thisChan)+offset, 'k')
                    text((tTest(1) +TOn(i))/1000, allCDS(1,thisChan)+offset(1), [num2str(chanSelectionInvert(s))])
                    offset = offset+150;
                end
                axis tight
                %yss = ylim;
                ylim([-400 2700]);
                
                %subplot(3, 1, 3)
                pos = [0.05 0.05 0.9 0.35];
                axes('position',pos );cla
                
                imagesc(CSDoutput', [-5000 5000])
                colormap(flipud(jet)); % blue = source; red = sink
                cb = colorbar('SouthOutside');
                cb.Label.String = [unitsCurrent '/' unitsLength '^{3}'];
                set(gca,'Ytick',[1:1:size(allCDS,2)]);
                %set(gca, 'YTickLabel',[1:1:size(allCDS,2)]); % electrode number
                set(gca, 'YTickLabel',[chanSelection]); % electrode number
                
                set(gca, 'xtick', xticks)
                set(gca, 'xticklabel', xlabs)
                ylabel('Electrode');
                xlabel('Time [s]');
                %%
                saveName = [PlotDir obj.Plotting.saveTxt '_CSD_' sprintf('%03d', i)];
                plotpos = [0 0 20 30];
                print_in_A4(0, saveName, '-djpeg', 0, plotpos);
                
            end
            saveName = [PlotDir obj.Plotting.saveTxt '_AllCSD.mat'];
            save(saveName, 'allCSDOutput', 'chanSelection', 'tmpFs')
            
            
        end