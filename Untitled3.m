T = wpdec(spw.pre(1,:),wav_order,'db1','shannon'); % for all feature vectors compute the wavelet tree
T = wpdec(inp(:,k),wav_order,'db1','shannon'); % for all feature vectors compute the wavelet tree

