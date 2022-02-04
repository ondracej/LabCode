figure
N=[50]; %%%% Teager shift parameter
n1=3.696*length(ADC)/10;
len=round(length(ADC)/(10*2^9));
subplot(5,1,1)
x=ADC(n1:n1+len);
plot(x);
axis([xlim,median(x)+iqr(x)*[-1.2 .5]]);
title('original ADC')
subplot(5,1,2)
x=teager(ADC(n1:n1+len),N);
plot(x);
axis([xlim,median(x)+iqr(x)*[-10 20]]);
title(['with Teager parameter: ' num2str(N)])
subplot(5,1,3)
y=x.*(x<.5 & x>-.5);
plot(y);
axis([xlim,median(y)+iqr(y)*[-10 20]]);
title('outliers removed');
subplot(5,1,4)
z=y>0.0750;
plot(z)
axis([xlim,[0 1.3]]);
title('corrected ADC');
subplot(5,1,5)
plot(z(find(z>0))-z(find(z>0)-1))
title('diff of corrected ADC');
axis([xlim,[-1.1 1.3]]);




figure
[counts,centers] = hist(x,1000);
bar(centers,log(counts));


