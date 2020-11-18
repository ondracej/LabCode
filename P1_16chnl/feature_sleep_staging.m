function [ shswt, shdct , t] = feature_sleep_staging(sig, time, win, fs)

% parameters:
% AR_order=4; %%%%%%
level=10; %%%%%%% wavelet package level
p=2; %%%%% p in p-norm

k=1;
while (k+1)*fs*win/2<length(sig)
    x_=sig((k-1)*fs*win/2+1:(k+1)*fs*win/2).*tukeywin(fs*win,.2); % window of data
    t(k)=(time((k-1)*fs*win/2+1) + time((k+1)/2*fs*win/2))/2;
    
    % AR coeffs
%     artmp =  arburg(x,AR_order);
%     ar(k,:) = artmp(2:end);
    
    % mean freq
%     mfreq(k) = meanfreq(x,fs);
    
    % stationary wavelrt (dwt without downsampling) coeffs entropy
    x=[x_ ; zeros(2^nextpow2(length(x_))-length(x_) ,1)];
    [swa,swd] = swt(x,level,'db2'); % each row of wpt is coefficients of one node
    swc=[swa(1:end,:);swd(1:end,:)];
    shswt(k,:) = shan_ent(swc); % Shannon Entropy
    shdct(k)=shan_ent(dct(x_));
%     for node=1:2^level
%         ce(k,node)=norm(Pij(node,:),p); % concentration (p-norm)
%     end
    
%     ee(k,:)=sum(log(Pij+eps),2); % log energy entropy
    
    % multiwavelet features
%     [~,h,cptmp] = dwtleader(y(:,kk));
%     he = cptmp(1); % first cumulant of Holder exponents, average of sclaes
%     cp = cptmp(2); % variance (second cumulant) of the scaling exponents
%     rh = range(h); % range of Holder exponents, how wide are the scales
k=k+1;
end
end

function [sh]=shan_ent(x)
% Shannon Entropy calculation, supposing channels are in columns of x
    E = sum(x.^2,2);    % Sum across time
    % for each node compute the entropy
    Pij = x.^2./repmat(E,1,size(x,2));
    sh = -sum(Pij.*log(Pij+eps),2); % Shannon Entropy
end
