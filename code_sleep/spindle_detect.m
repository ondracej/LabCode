function [spindleT, spindle, spindle_ext, Tspindle_st ]=spindle_detect(EEG, EMG, sr, time, A )
k=1; % counter for spindles
spindleT=cell(0); spindle=cell(0); spindle_ext=cell(0); T=diff(time(1:2));
for kk=0:1000:floor(length(EEG)/1e3)  % because of longevity od data, it is divided into ...
    % 1000 sec parts
samps=kk*sr+1:min((kk+1000)*sr,length(EEG)-5*sr);
EEG_=single(EEG(samps)); time_=single(time(samps)); t_st=min(time_); 
% spindle detection based on relevant band power and condition on EMG to
% make sure that the event has not occurred during neither wakefullness nor in REM
nwin=2^nextpow2(2*sr); % window size for PSD
Step=round(sr/10);   nover=nwin-Step;
nf=8; % number of frequency points
Feeg=linspace(12,20,nf); % frequency points for PSD
[~,Feeg,T1,Peeg]=spectrogram(EEG_, nwin , nover, Feeg, sr, 'yaxis');
dT=T1(2)-T1(1);
spindle_pow=sum(Peeg);
% A is threshold for PSD in spindle times, experimentally determined,  (uV^2)
T_up=T1(spindle_pow>A); % power in 12-20Hz should be more than A
if isempty(T_up)
    continue;
end
starts_logi=[true  diff(T_up)>2*dT];   % start of up periods (in sample)
samples=1:length(T_up);
starts=samples(starts_logi);
Tstart=T_up(starts)+t_st;
for n=1:sum(starts_logi)-1;
    if (t_st+T_up(starts(n+1)-1)+dT) - Tstart(n)>.5 & ...
       (t_st+T_up(starts(n+1)-1)+dT) - Tstart(n)<2   %criteria for min duration
%  max( EMG(time>Tstart(n) & time<t_st+T_up(starts(n+1)-1) ) )<1200 & ...% critera for sleepness
%  max( EMG(time>Tstart(n) & time<t_st+T_up(starts(n+1)-1) ) )>100 & ...% critera for NREM

        spindleT{k,1}=round(Tstart(n)-dT/2,3):T:round(t_st+T_up(starts(n+1)-1)+dT/2,3);
        spindle{k,1}=EEG(time>min(spindleT{k,1}) & time<max(spindleT{k,1}));
        spindle_ext{k,1}=EEG(time>min(spindleT{k,1})-.3 & time<max(spindleT{k,1})+.3 );

        k=k+1;
    end
end
n=sum(starts_logi);
if (1)
%     max( EMG(time>Tstart(n) & time<Tstart(n)+.5 ) )<1200 %condition for sleepness
    spindleT{k,1}=round(Tstart(n)-dT/2,3):T:round(Tstart(n)+.5,3);
    spindle{k,1}=EEG(time>min(spindleT{k,1}) & time<max(spindleT{k,1}));
    spindle_ext{k,1}=EEG(time>min(spindleT{k,1})-.3 & time<max(spindleT{k,1})+.3 );

end
Tspindle_st=[];
end

figure;
for n=1:length(spindle)
    plot(spindle{n,1}+100*n);  hold on;
    Tspindle_st(n)=round(min(spindleT{n}),3); 
end
axis tight; xlabel('Time (ms)')
    figure;
    k=4;
    subplot(k,1,1)
    plot(time_,EEG_); set(gca,'xtick',[]); xlim([min(time_) max(time_)]); ylim([-100 100])
    ylabel('EEG')
    subplot(k,1,2)
    surf(T1,Feeg,Peeg,'edgecolor','none');ylim([12 20]);xlim([0 length(samps)/sr]);view(0,90);
    set(gca,'xtick',[]); ylabel({'EEG';'Spectrogram'})
    shading interp
    subplot(k,1,3)
    plot(T1+t_st,spindle_pow,'b'); hold on;
    line(t_st+[0 length(samps)/sr],[A A],'color',[1 0 0],'linestyle','--');
    ylabel('detection')
    plot(Tspindle_st,repmat(A,1,length(Tspindle_st)),'x');  xlim([min(time_) max(time_)]);
    set(gca,'xtick',[]);
    subplot(k,1,4)
    plot(time_,EMG(samps));  axis([min(time_) max(time_) -1000 1000]); ylabel('EMG')
    xlabel('Time (sec)')
end