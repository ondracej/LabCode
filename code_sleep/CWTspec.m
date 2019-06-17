sig=ch2(1:3000);
t = 0:T:(numel(sig)*T)-T;
level = 6;
wpt = wpdec(sig,level,'sym6');
figure;
[S,T,F] = wpspectrum(wpt,sr,'plot');