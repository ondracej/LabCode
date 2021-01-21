function [e]=entropy_sig(p)
inds=find(p);
e= -sum(p(inds).*log2(p(inds))); % entropy
end