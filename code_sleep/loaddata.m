function [ ch1, ch2, time ] = loaddata( Address, sr )
% loading
cls=NET.addAssembly('C:\ScienceBeam\eProbe\eBridge.dll'); % pathway of dll
info=char(eBridge.File.GetProperty(Address)) % info headerline
ch1=double(eBridge.File.Open(Address,0)); 
ch2=double(eBridge.File.Open(Address,1)); 
T=1/sr;
time=single((1:length(ch1))*T);
t_max=max(time);
disp(['Data length: ' num2str(t_max/60) ' min'])
end

