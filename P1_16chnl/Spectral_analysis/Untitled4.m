
clc
tt=0:.01:20*pi;
ss=sin(tt);
bins=20;
ps=hist(ss,bins)/length(ss);
pt=hist(tt,bins)/length(tt);
figure
bar(ps);
figure
bar(pt);
shss=sum(-log(ps).*ps)
shtt=sum(-log(pt).*pt)