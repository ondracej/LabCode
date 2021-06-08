figure

n = 100;
x = linspace(-10,10,n); y = x.^2;
p = plot(x,y,'r', 'LineWidth',5);

%// modified jet-colormap
cd = [uint8(jet(n)*255) uint8(ones(n,1))].'; %'
drawnow
set(p.Edge, 'ColorBinding','interpolated', 'ColorData',cd)
%%

figure
bin_indx=find(abs(t_bins3sec-t_spot)==min(abs(t_bins3sec-t_spot))); 
EEG3sec_n=size(EEG3sec,1);
for k=1:16
    y=(EEG3sec(:,k,bin_indx))+.6*k;
    multicolorloine(round(1:EEG3sec_n)/fs,y,y,.9*jet); hold on
end
xlabel('Time (sec)')
yticklabels({}); ylim([0 16*.6+.5])

