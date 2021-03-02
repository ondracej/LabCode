ff=find(f<50);% the powers below line 50 Hz 
for k=inds
    for freq=2:2:max(f(f<49))
    featspxx(freq/2,k)=sum(pxx(f<freq & f>freq-2,k));
    end
end