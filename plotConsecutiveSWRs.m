function [] = plotConsecutiveSWRs(obj, dataRecordingObj)
            
            SWRs_ms = obj.SWR.tSWR_samps;
            nSWRs = numel(SWRs_ms);
            
            template_v = obj.SWR.mediantemplate;
            template_T = obj.SWR.template_T;
            template_peak = obj.SWR.pTemplatePeak;
            
            
            ch = obj.SWR.ch;
            Fs = obj.Session.sampleRate;
            
            preTemplate = obj.SWR.parSharpWaves.preTemplate;
            winTemplate = obj.SWR.parSharpWaves.winTemplate;
            %figure; 
            %plot(template_T, template_v)
            %obj.Session.recordingDur_s
            
            %% Get SWRs in ms,
            %allSW = [];
            
            %[allSW,tSW]=dataRecordingObj.getData(ch,(SWRs_ms),winTemplate);
            %[allSW,tSW]=dataRecordingObj.getData(ch,(SWRs_ms),winTemplate+preTemplate);
            [allSW,tSW]=dataRecordingObj.getData(ch,(SWRs_ms-preTemplate),winTemplate);
            
            allSWRs = squeeze(allSW);
            
            %{
            figure (105); clf
            for j =1:nSWRs
                plot(tSW, allSWRs(j,:))
                %ylim([-600 200])
                j
                pause
            end
            %}
            
            %% Filters
            fObj = filterData(Fs);
            
            fobj.filt.FH2=filterData(Fs);
            fobj.filt.FH2.highPassCutoff=100;
            fobj.filt.FH2.lowPassCutoff=2000;
            fobj.filt.FH2.filterDesign='butter';
            fobj.filt.FH2=fobj.filt.FH2.designBandPass;
            fobj.filt.FH2.padding=true;
            
            fobj.filt.FJLB=filterData(Fs);
            fobj.filt.FJLB.highPassCutoff=.1;
            fobj.filt.FJLB.lowPassCutoff=4;
            fobj.filt.FJLB.filterDesign='butter';
            fobj.filt.FJLB=fobj.filt.FJLB.designBandPass;
            fobj.filt.FJLB.padding=true;
            
            fobj.filt.FL=filterData(Fs);
            fobj.filt.FL.lowPassPassCutoff=35;
            fobj.filt.FL.lowPassStopCutoff=40;
            fobj.filt.FL.attenuationInLowpass=20;
            fobj.filt.FL=fobj.filt.FL.designLowPass;
            fobj.filt.FL.padding=true;
            
            fobj.filt.FLL=filterData(Fs);
            fobj.filt.FLL.lowPassPassCutoff=1;
            fobj.filt.FLL.lowPassStopCutoff=4;
            fobj.filt.FLL.attenuationInLowpass=10;
            fobj.filt.FLL=fobj.filt.FLL.designLowPass;
            fobj.filt.FLL.padding=true;
            
            
            %%
            %For recsession 67
            %exSWR_ind =  15;
            
            % For recsession 58
            exSWR_ind =  84;
            %exSWR_ind =  15;
            
            exSWR = allSW(:,exSWR_ind ,:);
            exSWRs_ms = SWRs_ms(exSWR_ind);
            %%
            figH = figure(200); clf
            
            % raw SWR example
            subplot(8, 1, [2])
            plot(tSW, squeeze(exSWR), 'k')
            hold on
            plot(template_T, template_v, 'r', 'linewidth', 1)
            axis tight
            %subplot(9, 1, [3])
            %plot(template_T, template_v, 'r', 'linewidth', 1)            
                        
            % LF SWR example
            %[exLF,t_ms] =  fobj.filt.FL.getFilteredData(exSWR);
            %hold on
            %plot(t_ms, squeeze(exLF), 'r', 'linewidth', 1)
            
            %ylim([-700 150]) % ZF
            %ylim([-1200 300])
            set(gca,'XMinorTick','on','YMinorTick','on')
            % HF SWR example
            [exHF,tmpHFT] =  fobj.filt.FH2.getFilteredData(exSWR);
            
            subplot(8, 1, [3])
            plot(tmpHFT, squeeze(exHF), 'k')
            axis tight
            %ylim([-70 70]) % ZF
            %ylim([-150 150])
            set(gca,'XMinorTick','on','YMinorTick','on')
            % larger raw data centered on example SWR
            %
            TimeWinB_ms = 60*1000;
            WinBStart_ms  = exSWRs_ms-15*1000; %ZF
            %WinBStart_ms  = exSWRs_ms-25*1000;
            
            [rawLongEx,longTms]=dataRecordingObj.getData(ch,(WinBStart_ms),TimeWinB_ms);
            %[longLF,LongLFtms] =  fobj.filt.FLL.getFilteredData(rawLongEx);
            [longLF,LongLFtms] =  fobj.filt.FL.getFilteredData(rawLongEx);
            
            %%
            
            subplot(8, 1, [1])
            plot(longTms+WinBStart_ms, squeeze(rawLongEx), 'k');
            hold on
            %plot(longTms+WinBStart_ms, squeeze(longLF), 'r');
            axis tight
            %ylim([-800 200]) % ZF
            %ylim([-1500 500]) % chikc
            
            starttime = longTms(1)+WinBStart_ms;
            endtime = longTms(end)+WinBStart_ms;
            
            SWRTimes = SWRs_ms(SWRs_ms >starttime & SWRs_ms < endtime);
            
            hold on
            %plot(SWRTimes+180, 50, 'rv')
            plot(exSWRs_ms+150, -800, 'r*')
            xtics = get(gca, 'xtick');
            xticks_s = xtics/1000;
            set(gca, 'xticklabel', xticks_s)
            set(gca,'XMinorTick','on','YMinorTick','on')
            
            title([obj.INFO.birdName ' | ' obj.DIR.dirName])
            
            %numel(spks_ms(spks_ms >= (tOn(o)-1) & spks_ms < (tOn(o)+spkWin_ms-1)));
            
            %             TimeWinB_ms = 1*60*1000; % 1 min
            %             WinBStart_ms =  250000+WinAStart_ms; % make sure to add the ref point
            %
            %              WinAStart_ms = 100;
            %             [rawLFP_A,LFPtime_A]=dataRecordingObj.getData(ch,WinAStart_ms,TimeWinA_ms);
            %             [rawLFP_A_fn,LFPtime_A_fn]=fobj.filt.FN.getFilteredData(rawLFP_A);
            %             WinBStop_ms =  WinBStart_ms+TimeWinB_ms;
            %             hold on
            %             line([WinBStart_ms WinBStop_ms], [0 0], 'color', 'r')
            %             axis tight
            %             ylim([-400 200])
            %
            
            nSWRsToPlot = 850;
            
            %% Collect SWR HFI
            
            [tmpHFV,tmpHFT] =  fobj.filt.FH2.getFilteredData(allSW);
            allSWs = squeeze(allSW);
            meanLFP = mean(allSWs(1:nSWRsToPlot,:), 1);
            
            tmpHFV_V = squeeze(tmpHFV);
            
            %figure; plot(tmpHFT, tmpHFV_V)
            
            binsSize_ms = 2;
            binsSize_samps = binsSize_ms/1000*Fs;
            HFI = [];
            for j = 1:nSWRsToPlot
                bla = buffer(tmpHFV_V(j,:), binsSize_samps);
                absBla = abs(bla);
                HFI(:,j) = sum(absBla, 1)/binsSize_samps;
            end
            
            %% Plot
            subplot(8, 1, [4 5 6])
            %imagesc(HFI', [0 2500]) %chick
            %imagesc(HFI', [0 40])
            imagesc(HFI', [0 80])
            %imagesc(HFI')
            cb = colorbar('NorthOutside');
            
            subplot(8, 1, 7)
            plot(tmpHFT, meanLFP, 'r', 'linewidth', 1.5)
            legend('mean LFP', 'Location', 'southeast')
            legend('boxoff')
            
            %ylim([-1000 200])
            %ylim([-600 50])
            axis tight
            set(gca,'XMinorTick','on','YMinorTick','on')
            
            meanHPI = mean(HFI, 2);
            
            subplot(8, 1, 8)
            plot(meanHPI, 'k', 'linewidth', 1.5)
            %ylim([200 1200]) % ZF
            %ylim([0 50]) % chick
            axis tight
            legend('mean HPI', 'Location', 'southeast')
            legend('boxoff')
            
            
            xlabel('Time (ms)')
            set(gca,'XMinorTick','on','YMinorTick','on')
            %%
            %             xtics = get(gca, 'xtick');
            %             xlabs = [];
            %             for j = 1:numel(xtics)
            %                 xlabs{j} = num2str(xtics(j)*60/Fs*1000);
            %             end
            
            %set(gca, 'xtick', xticks_s)
            %set(gca, 'xticklabel', xlabs)
            %set(gca, 'yticklabel', ytics_Hr_round)
            
            
            %%
            
            plotpos = [0 0 20 40];
            PlotDir = [obj.DIR.birdDir 'Plots' obj.DIR.dirD obj.DIR.dirName '_plots' obj.DIR.dirD];
            
            plot_filename = [PlotDir 'SWR_Detections'];
            print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
            print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
            
          
            
            
        end
        