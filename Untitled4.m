s=spw.pre(:,1);
tt=wpdec(s,4,'db2');
plot(tt)
coefs=wpcoef(tt,16);
figure; plot(coefs)