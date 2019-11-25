function [feature]=spw_feature_extract(inp)

% AR coefficients
ar_order=6; %%%%%%%%%%%%%%%%
temp_feat=arburg(inp,ar_order);
feature.ar = (temp_feat(1:end-1,3:end));

end

