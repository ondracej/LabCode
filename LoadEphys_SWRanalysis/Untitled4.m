a=CSDoutput'; b=a+rand(size(a));
sum(diag(a*b')) / sqrt( sum(diag(a*a')) * sum(diag(b*b')) )