function [feature]=spw_feature_extract(inp, ar_order, wav_order)

% input inp contains initial raw feature vectors compacted in the rows of a
% matrix 
% AR coefficients
temp_feat=arburg(inp,ar_order);
feature.ar = (temp_feat(1:end-1,2:end));

% entropy of all nodes in a wavelet tree
for k=1:size(inp,2)-1
T = wpdec(inp(:,k),wav_order,'db1','shannon'); % for all feature vectors compute the wavelet tree
for nod=1:2^wav_order-2 % for all nodes in a tree
coefs_nod = wpcoef(T,nod); % extract the coeffs
feature.wav1(k,nod) = wentropy(coefs_nod,'shannon'); % compute the entropy
end
end

