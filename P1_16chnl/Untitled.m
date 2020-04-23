% raw plot of all channels
for k=1:length(snippet_times)
figure;
set(gcf, 'Position',  [100, 50, 1700, 900])
t_limm=snippet_times(k);
eegs=EEG((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs , :);
t_eegs=time((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs);
dist=.7*std( eegL(randi(length(eegs),1,10000),1));
for n=1:16
plot(t_eegs,eegs(:,n)+(n-1)*dist);  hold on
if n==1
    title(['File: ' folder_path '\' filename ]);
end
end
xlim(t_limm); ylim([-1 17]*dist)
end