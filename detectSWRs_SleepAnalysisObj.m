function [obj] = detectSWRs_SleepAnalysisObj(chan , obj, dataRecordingObj)

%% check if detected files exist
obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
SWRDir = [obj.DIR.birdDir 'SWR' obj.DIR.dirD obj.DIR.dirName '_swrs' obj.DIR.dirD];
savePath = [SWRDir  obj.Plotting.saveTxt '_SWR.mat'];

%%
Fs = obj.Session.sampleRate;
recordingDuration_s = obj.Session.recordingDur_s;

fObj = filterData(Fs);

%% Filters
fobj.filt.DS4Hz=filterData(Fs);
fobj.filt.DS4Hz.downSamplingFactor=240; % 125 samples
fobj.filt.DS4Hz.lowPassCutoff=55;
fobj.filt.DS4Hz.padding=true;
fobj.filt.DS4Hz=fobj.filt.DS4Hz.designDownSample;

%% Define duration for constructing template
nTestSegments = 20;
percentile4ScaleEstimation = 5;
rng(1); % do this to make sure template is mostly the same across iterations

seg_ms=20000;
TOn=1:seg_ms:recordingDuration_s*1000-seg_ms;
nCycles = numel(TOn);

[tmpV, t_ms] =dataRecordingObj.getData(2,TOn(1),seg_ms);

pCycle=sort(randperm(nCycles,nTestSegments));
ch = chan;
Mtest=cell(nTestSegments,1);
tTest=cell(nTestSegments,1);
for i=1:numel(pCycle)
    MTmp=dataRecordingObj.getData(ch,TOn(pCycle(i)),seg_ms);
    [Mtest{i},tTest{i}]=fobj.filt.DS4Hz.getFilteredData(MTmp);
    tTest{i}=tTest{i}'+TOn(pCycle(i));
    Mtest{i}=squeeze(Mtest{i});
end
Mtest=cell2mat(Mtest);
tTest=cell2mat(tTest);
sortedMtest=sort(Mtest);
scaleEstimator=sortedMtest(round(percentile4ScaleEstimation/100*numel(sortedMtest)));

tmpFs=fobj.filt.DS4Hz.filteredSamplingFrequency;

%% Detecting all peaks to make the template

% addParameter(parseObj,'minPeakWidth',200,@isnumeric);
% addParameter(parseObj,'minPeakInterval',1000,@isnumeric);
% addParameter(parseObj,'detectOnlyDuringSWS',true);
% addParameter(parseObj,'preTemplate',400,@isnumeric);
% addParameter(parseObj,'winTemplate',1500,@isnumeric);

% minPeakWidth = 200;
% minPeakInterval = 1000;
% preTemplate = 400;
% winTemplate = 1500;

% in ms ZF
minPeakWidth = 20;
maxPeakWidth = 130;
minPeakInterval = 200;
preTemplate = 200;
winTemplate = 600;

preTemplate = 200; %ms
winTemplate = 600; %ms

[peakVal,peakTime,peakWidth,peakProminance]=findpeaks(-Mtest,'MinPeakHeight',-scaleEstimator,'MinPeakDistance',minPeakInterval/1000*tmpFs,'MinPeakProminence',-scaleEstimator/2,'MinPeakWidth',minPeakWidth/1000*tmpFs, 'MaxPeakWidth', maxPeakWidth/1000*tmpFs,'WidthReference','halfprom');

%{
                widthTimes = peakWidth/tmpFs*1000;
                figure
                hist(widthTimes, 0:1:maxPeakWidth)
            
                figure(100);clf
                plot(Mtest)
                hold on
                plot(peakTime, 50, 'rv')
%}
%% Making the template
[allSW,tSW]=dataRecordingObj.getData(ch,tTest(peakTime)-preTemplate,winTemplate);
[FLallSW,tFLallSW]=fobj.filt.DS4Hz.getFilteredData(allSW);

template=squeeze(median(FLallSW,2));
nTemplate=numel(template);
ccEdge=floor(nTemplate/2);
[~,pTemplatePeak]=min(template);

%{
                figure(100); clf
                plot(tFLallSW, template)
%}

%% Now using the template to detect the real SWRs
seg=40000;
TOn=0:seg:recordingDuration_s*1000-seg;
TWin=seg*ones(1,numel(TOn));
nCycles=numel(TOn);

C_Height = 0.1; % for xcorrelations
C_Prom = 0.1;

absolutePeakTimes=cell(nCycles,1);
for i=1:nCycles
    [tmpM,tmpT]=dataRecordingObj.getData(ch,TOn(i),TWin(i));
    [tmpFM,tmpFT]=fobj.filt.DS4Hz.getFilteredData(tmpM);
    
    [C]=xcorrmat(squeeze(tmpFM),template);
    C=C(numel(tmpFM)-ccEdge:end-ccEdge);
    
    %{
                                figure(103); clf
                                subplot(2, 1, 1 )
                                plot(C); axis tight
    %}
    
    %C=xcorr(squeeze(tmpFM),template,'coeff');
    
    %[~,peakTime]=findpeaks(C,'MinPeakHeight',0.1,'MinPeakProminence',0.2,'WidthReference','halfprom');
    [~,peakTime]=findpeaks(C,'MinPeakHeight',C_Height ,'MinPeakProminence',C_Prom,'WidthReference','halfprom');
    
    %{
                                hold on
                                plot(peakTime, 0.1, 'rv')
                
                                subplot(2, 1, 2)
                                hold on; plot(tmpT, squeeze(tmpM))
                                plot(relPeakTime, 100, 'rv')
                                %linkaxes(h,'x');
    %}
    
    peakTime(peakTime<=pTemplatePeak)=[]; %remove peaks at the edges where templates is not complete
    relPeakTime = tmpFT(peakTime-round(pTemplatePeak/2))';
    %relPeakTime = tmpFT(peakTime-pTemplatePeak)';
    absolutePeakTimes{i}=tmpFT(peakTime-round(pTemplatePeak/2))'+TOn(i); % this seems to be more accurate
    %absolutePeakTimes{i}=tmpFT(peakTime)'+TOn(i);
    
    %h(1)=subplot(2,1,1);plot(squeeze(tmpFM));h(2)=subplot(2,1,2);plot((1:numel(C))-pTemplatePeak,C);linkaxes(h,'x');
end

%                 [allSW,tSW]=dataRecordingObj.getData(ch,(tSW),winTemplate);
%                 allSWRs = squeeze(allSW);

%% Plotting some SWRs to check
%{
                figure (105); clf
                for j =1:100
                plot(tSW, allSWRs(j,:))
                %ylim([-600 200])
                j
                pause
                end
%}

%% Saving everything in a structure

tSW=cell2mat(absolutePeakTimes);


SWR.tSWR_samps = tSW;
SWR.template_V = FLallSW;
SWR.template_T = tFLallSW;
SWR.mediantemplate = template;
SWR.pTemplatePeak = pTemplatePeak;
SWR.ch= ch;

parSharpWaves.minPeakWidth = minPeakWidth;
parSharpWaves.minPeakInterval = minPeakInterval;
parSharpWaves.preTemplate = preTemplate;
parSharpWaves.winTemplate = winTemplate;
parSharpWaves.C_MinPeakHeight = C_Height;
parSharpWaves.C_MinPeakProminence = C_Prom;
parSharpWaves.tmpFs = tmpFs;

SessionDir = obj.Session.SessionDir;

obj.Plotting.titleTxt = [obj.INFO.birdName ' | ' obj.Session.time];
obj.Plotting.saveTxt = [obj.INFO.birdName '_' obj.Session.time];
SWRDir = [obj.DIR.birdDir 'SWR' obj.DIR.dirD obj.DIR.dirName '_swrs' obj.DIR.dirD];

if exist(SWRDir, 'dir') == 0
    mkdir(SWRDir);
    disp(['Created: '  SWRDir])
end
savePath = [SWRDir  obj.Plotting.saveTxt '_SWR.mat'];

save(savePath,'SWR','parSharpWaves');
disp(['Saved:' savePath])
obj.SWR = SWR;
obj.SWR.parSharpWaves = parSharpWaves;


end



