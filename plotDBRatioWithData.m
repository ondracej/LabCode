 function [obj] = plotDBRatioWithData(obj)
            
            
            chanToUse = obj.REC.bestChs(1);
            SessionDir = obj.DIR.ephysDir;
            %obj.Session.SessionDir;
            
            eval(['fileAppend = ''106_CH' num2str(chanToUse) '.continuous'';'])
            fileName = [SessionDir fileAppend];
            
            [data, timestamps, info] = load_open_ephys_data(fileName);
            thisSegData_s = timestamps(1:end) - timestamps(1);
            Fs = info.header.sampleRate;
            
            totalTime = obj.Session.recordingDur_s;
            samples = obj.Session.samples;
            %totalTime = thisSegData_s(end);
            %batchDuration_s = 1*60*60; % 1 hr
            batchDuration_s = 180; % 1 hr
            batchDuration_samp = batchDuration_s*Fs;
            
            tOn_s = 1:batchDuration_s:totalTime;
            tOn_samp = tOn_s*Fs;
            nBatches = numel(tOn_samp);
            
            obj.Plotting.titleTxt = [obj.INFO.Name ' | ' obj.Session.time];
            obj.Plotting.saveTxt = [obj.INFO.Name '_' obj.Session.time];
           
            
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
            
           
            
            %% Get Filtered Data
            
            %DataSeg_FN = fobj.filt.FN.getFilteredData(thisSegData);
            %DataSeg_FL = fobj.filt.FL.getFilteredData(thisSegData);
            %DataSeg_FH2 = fobj.filt.FH2.getFilteredData(thisSegData);
            
            for b = 1:nBatches
                
                if b == nBatches
                thisData = data(tOn_samp(b):samples);
                else
                thisData = data(tOn_samp(b):tOn_samp(b)+batchDuration_samp);
                end
                
                [V_uV_data_full,nshifts] = shiftdim(thisData',-1);
                
                thisSegData = V_uV_data_full(:,:,:);
                
                
                [DataSeg_F, t_DS] = fobj.filt.F.getFilteredData(thisSegData); % t_DS is in ms
                
                t_DS_s = t_DS/1000;
                
                
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
                reductionFactor = .5; % No reduction
                
                movWin_Var = 10*reductionFactor; % 10 s
                movOLWin_Var = 9*reductionFactor; % 9 s
                
                segmentWelch = 1*reductionFactor;
                OLWelch = 0.5*reductionFactor;
                
                dftPointsWelch =  2^10;
                
                segmentWelchSamples = round(segmentWelch*fobj.filt.FFs);
                samplesOLWelch = round(segmentWelchSamples*OLWelch);
                
                movWinSamples=round(movWin_Var*fobj.filt.FFs);%obj.filt.FFs in Hz, movWin in samples
                movOLWinSamples=round(movOLWin_Var*fobj.filt.FFs);
                
                % run welch once to get frequencies for every bin (f) determine frequency bands
                [~,f] = pwelch(randn(1,movWinSamples),segmentWelchSamples,samplesOLWelch,dftPointsWelch,fobj.filt.FFs);
                
                deltaBandCutoff = 7;
                %betaBandLowCutoff = 15;
                %betaBandHighCutoff = 40;
                %betaBandLowCutoff = 25;
                %betaBandHighCutoff = 80;
                
                alphaThetaBandLowCutoff  = 8;
                alphaThetaBandHighCutoff  = 14;
                
                betaBandLowCutoff = 15;
                betaBandHighCutoff = 45;
                
                
                pfLowBand=find(f<=deltaBandCutoff);
                pfHighBand=find(f>=betaBandLowCutoff & f<betaBandHighCutoff);
                pfHighBand_alpha=find(f>=alphaThetaBandLowCutoff & f<alphaThetaBandHighCutoff);
                
                %%
                tmp_V_DS = buffer(DataSeg_F,movWinSamples,movOLWinSamples,'nodelay');
                pValid=all(~isnan(tmp_V_DS));
                
                [pxx,f] = pwelch(tmp_V_DS(:,pValid),segmentWelchSamples,samplesOLWelch,dftPointsWelch,fobj.filt.FFs);
                
                % Ratios
                deltaBetaRatioAll=zeros(1,numel(pValid));
                deltaBetaRatioAll(pValid)=(mean(pxx(pfLowBand,:))./mean(pxx(pfHighBand,:)))';
                
                deltaAlphRatioAll = zeros(1,numel(pValid));
                deltaAlphRatioAll(pValid)=(mean(pxx(pfLowBand,:))./mean(pxx(pfHighBand_alpha,:)))';
                 
                % single elements
                deltaAll=zeros(1,numel(pValid));
                deltaAll(pValid)=mean(pxx(pfLowBand,:))';
                
                betaAll=zeros(1,numel(pValid));
                betaAll(pValid)=mean(pxx(pfHighBand,:))';
                
                alphAll=zeros(1,numel(pValid));
                alphaAll(pValid)=mean(pxx(pfHighBand_alpha,:))';
                
                % Pool all data ratios
                bufferedDeltaBetaRatio=deltaBetaRatioAll;
                bufferedDelta=deltaAll;
                bufferedBeta=betaAll;
                allV_DS = squeeze(DataSeg_F);
                
                
%                 bufferedDeltaBetaRatio(i,:)=deltaBetaRatioAll;
%                 bufferedDeltaGammaRatio(i,:)=deltaGammaRatioAll;
%                 
%                 bufferedDelta(i,:)=deltaAll;
%                 bufferedBeta(i,:)=betaAll;
%                 bufferedGamma(i,:)=gammaAll;
%                 
%                 allV_BP_DS{i} = squeeze(tmp_V_BP_DS);
%                 allV_BP_DS{i} = squeeze(tmpV);
                
                
                %%
                sizestr = ['movWin =' num2str(movWin_Var) 's; movOLWin = ' num2str(movOLWin_Var) ' s'];
                Betacolor = [150 50 0]/255;
                Deltacolor = [0 50 150]/255;
                Alphacolor = [0 150 150]/255;
                
                betaAll_norm = betaAll./(max(betaAll));
                deltaAll_norm = deltaAll./(max(deltaAll));
                alphaAll_norm = alphaAll./(max(alphaAll));
                
                figh3 = figure(300); clf
                subplot(3, 1, 1)
                plot(smooth(betaAll_norm), 'color', Betacolor, 'linewidth', 1)
                hold on
                plot(smooth(deltaAll_norm), 'color', Deltacolor, 'linewidth', 1)
                plot(smooth(alphaAll_norm), 'color', Alphacolor, 'linewidth', 1)
                
                axis tight
                %ylim([0 10000])
                %set(gca, 'xtick', [])
                legTxt = [{['Beta: ' num2str(betaBandLowCutoff) '-' num2str(betaBandHighCutoff) ' Hz']} , {['Delta: < ' num2str(deltaBandCutoff) ' Hz']}, {['AlphaTheta: ' num2str(alphaThetaBandLowCutoff) '-' num2str(alphaThetaBandHighCutoff) ' Hz']} ];
                legend(legTxt)
                %xlim([0 2500])
                
                subplot(3, 1, 2)
                plot(t_DS_s, squeeze(DataSeg_F), 'k')
                axis tight
                title('V_BP_DS')
                xlabel('Time [s]')
                axis tight
                ylim([-4000 4000])
                %xlim([0 125000])
                
                deltaBetaRatioAll_norm = deltaBetaRatioAll./(max(max(deltaBetaRatioAll)));
                deltaalphaRatioAll_norm = deltaAlphRatioAll./(max(max(deltaAlphRatioAll)));
                subplot(3, 1, 3)
                axis tight
                hold on
                plot(smooth(deltaBetaRatioAll_norm, 5), 'linewidth', 1)
                hold on
                plot(smooth(deltaalphaRatioAll_norm, 5), 'linewidth', 1)
                title(['Delta/Beta Ratio | ' sizestr ])
                legTxt = [{'Delta/Beta Ratio'}, {'Delta/AlphaTheta Ratio'}];
                legend(legTxt)
              
                
                %set(gca, 'xtick', [])
                axis tight
               % xlim([0 2500])
                %%
                plotpos = [0 0 30 15];
                PlotDir = [obj.DIR.plotDir];
                
                plot_filename = [PlotDir 'DB_Ratio_seg_' sprintf('%02d',b)];
                print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
                
                
                
                %%
                
                
                  figh4 = figure(400); clf
                subplot(2, 1, 1)
                
                plot(t_DS_s, squeeze(DataSeg_F), 'k')
                axis tight
                title('V_BP_DS')
                xlabel('Time [s]')
                axis tight
                ylim([-4000 4000])
                %xlim([0 125000])
                
                subplot(2, 1, 2)
                 deltaBetaRatioAll_norm = deltaBetaRatioAll./(max(max(deltaBetaRatioAll)));
                deltaalphaRatioAll_norm = deltaAlphRatioAll./(max(max(deltaAlphRatioAll)));
                axis tight
                hold on
                %plot(smooth(deltaBetaRatioAll_norm, 5), 'linewidth', 1)
                hold on
                plot(smooth(deltaalphaRatioAll_norm, 5), 'linewidth', 1)
                title(['Delta/Beta Ratio | ' sizestr ])
                %legTxt = [{'Delta/Beta Ratio'}, {'Delta/AlphaTheta Ratio'}];
                %legend(legTxt{2})
                
                
                   plotpos = [0 0 30 15];
                PlotDir = [obj.DIR.plotDir];
                
                plot_filename = [PlotDir 'DB_Ratio_seg_Large' sprintf('%02d',b)];
                print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
                   print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
                
            end
            
        end
        