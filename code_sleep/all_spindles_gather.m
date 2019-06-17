cls=NET.addAssembly('C:\ScienceBeam\eProbe\eBridge.dll'); % pathway of dll
Add='D:\Projects, Teachings\sleep Baqyatallah\rat sleep\data\stress valid data\';

% before stress files:
0={'spinv6-3b','spinv6-2b','spinV6 -b','spinN5-B','spinn4-b3','spinn4-b2','spinN4 -B'...
    ,'spinn3-B','spinN3-2b','spinN2-2','spinN1','spinN1-3b','spinN1-1'}; 
fbs={'v6-3b','v6-2b','V6 -b','N5-B','n4-b3','n4-b2','N4 -B','n3-B','N3-2b','N2-2',...
    'N1','N1-3b','N1-1'};

% load bs
n=1;
spindles_bs={};
for k=1:length(bs)
    Address=[Add fbs{k}];% adding file name (before stress)
    ch1=double(eBridge.File.Open(Address,0)); T=1/1000; time=single((1:length(ch1))*T);
    Data=load(bs{k}); 
    for l=1:length(Data.spindleT)
        samples=round(Data.spindleT{l}/T);
        spindles_bs{n}=ch1(samples);
        n=n+1;
    end
end

% post stress files:
ps={'spinv6-ps','spinv6-3ps','spinv6-2ps','spinn5-s3','spinn5-s2_','spinn5-s2',...
    'spinn4-s 2','spinn4-s3','spinn1-3stress'};
fps={'v6-ps','v6-3ps','v6-2ps','n5-s3','n5-s2_','n5-s2','n4-s 2','n4-s3','n1-3stress'};
% load bs
n=1;
spindles_ps={};
for k=1:length(ps)
    Address=[Add fps{k}];% adding file name (before stress)
    ch1=double(eBridge.File.Open(Address,0)); T=1/1000;
    Data=load(ps{k}); 
    for l=1:length(Data.spindleT)
        samples=round(Data.spindleT{l}/T);
        spindles_ps{n}=ch1(samples);
        n=n+1;
    end
end

%% filter and plot
spindles_bs_filt={};
spindles_ps_filt={};
[b,a] = butter(2,[.2 40]/(1000/2)); 
for k=1:length(spindles_bs)
spindles_bs_filt{k}=filtfilt(b,a,spindles_bs{k});
end
for k=1:length(spindles_ps)
spindles_ps_filt{k}=filtfilt(b,a,spindles_ps{k});
end

figure; hold on
for k=1:length(spindles_bs_filt)
    bs_rms(k)=rms(spindles_bs_filt{k})/length(spindles_bs_filt{k});
    plot(spindles_bs_filt{k});
end
ylim([-600 600]);

figure; hold on
for k=1:length(spindles_ps_filt)
    ps_rms(k)=rms(spindles_ps_filt{k})/length(spindles_ps_filt{k});
    plot(spindles_ps_filt{k});
end
ylim([-600 600]);

mean(bs_rms)
mean(ps_rms)
% ttest for amplitude
K=min(size(bs_rms,2),size(ps_rms,2));
N1=size(bs_rms,2);  N2=size(ps_rms,2);
bs_rms=bs_rms(randsample(N1,K));
ps_rms=ps_rms(randsample(N2,K));

[h_amp,p_amp]=ttest(bs_rms,ps_rms,'alpha',10e-2)


    
    
    
    
    
    
    
    
    
    
    
    
    
