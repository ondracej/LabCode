superf=load csd;
deeper=load csd;

corrs=correlator(superf,deeper);
figure; 
plot(corrs);