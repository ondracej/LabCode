function [feature]=spw_feature_extract(inp, ar_order, wav_order)
tic
% input inp contains initial raw feature vectors compacted in the columns of a
% matrix, each column is one time instant (pattern)
% AR coefficients
temp_feat=arburg(inp,ar_order);
feature.ar = (temp_feat(1:end-1,3:end));
ar_t=toc

tic
% entropy of all nodes in a wavelet tree
for k=1:size(inp,2)-1 % for each data point
T = wpdec(inp(:,k),wav_order,'sym4','shannon'); % for all feature vectors compute the wavelet tree
for nod=1:2^(wav_order+1)-2 % for all nodes in a tree
coefs_nod = wpcoef(T,nod); % extract the coeffs
feature.wav1(k,nod) = wentropy(coefs_nod,'shannon'); % compute the entropy
end
end
wav_t=toc

tic;
% Energy of bins
% this feature would be the power of wave in 10 blocks preceding the event
mean_removed=inp-repmat(mean(inp),size(inp,1),1);
e2=mean_removed.^2;
parts=10; % number of blocks
blck_sz=floor(size(inp,1)/parts);
for fn=1:parts % features from 1 to 10
feature.energy(:,fn)=sum(e2((fn-1)*blck_sz+1:fn*blck_sz,1:end-1));
end
t_energy=toc

end

