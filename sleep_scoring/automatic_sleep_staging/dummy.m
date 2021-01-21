
figure
ind=strcmp(label,'Wake'); 
vals=median(movement(ind,:),2);  
histogram(vals,120, 'Normalization', 'Probability'); hold on

ind=strcmp(label,'REM'); 
vals=median(movement(ind,:),2); 
histogram(vals(1:362),8, 'Normalization', 'Probability');
xlim([1400 3000])

 
figure
ind=strcmp(label,'Wake'); 
vals1=mean(movement(ind,:),2); 
sum(vals1>1560)/length(vals1)
histogram(vals1,160); hold on

ind=strcmp(label,'REM'); 
vals2=mean(movement(ind,:),2); 
sum(vals2<1560)/length(vals2)

histogram(vals2(1:362),7);
line([1530 1530],[0 180])

createfigure(vals1, vals2, [1530 1530], [0 .6])
