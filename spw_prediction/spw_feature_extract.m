function [feature]=spw_feature_extract(inp, ar_order, wav_order)
tic
% input inp contains initial raw feature vectors compacted in the rows of a
% matrix 
% AR coefficients
temp_feat=arburg(inp,ar_order);
feature.ar = (temp_feat(1:end-1,2:end));
ar_t=toc

tic
% entropy of all nodes in a wavelet tree
for k=1:size(inp,2)-1 % for each data point
T = wpdec(inp(:,k),wav_order,'db1','shannon'); % for all feature vectors compute the wavelet tree
for nod=1:2^wav_order-2 % for all nodes in a tree
coefs_nod = wpcoef(T,nod); % extract the coeffs
feature.wav1(k,nod) = wentropy(coefs_nod,'shannon'); % compute the entropy
end
end
wav_t=toc

tic
% pca of the downsampled data
[~,temp_feat_pca,~]=pca(inp(1:5:end,:)');
feature.pca=temp_feat_pca(1:end-1,1:10); % we just extract the first 10 PCs
pca_t=toc
end

