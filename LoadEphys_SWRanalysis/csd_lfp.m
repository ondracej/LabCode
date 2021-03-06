% Assumption: channels are ordered according to depth in succh a way that
% the first is most superficial and the last is the deepest
% inpus: basically time and signal part of interest
% lines with '%%%%%%%%%' shall be modified
t0=round(rand(1)*length(time)/fs); % starting time
plot_time=[0 2.01]; % window to look at
tlim=t0+plot_time;
sampl=tlim(1)*fs:tlim(2)*fs;

t_stamps=time(sampl)'; %%%%%%%%% Time Stamps to Plot
sig2plot=spwsig(sampl,:); %%%%%%%% LFP Signal to Plot

N=size(sig2plot,2);
chnl_labels=.5:size(sig2plot,2);
spacing=100*10^-6; %%%%%%%%%%% spacing between neiboring electrodes
CSDoutput = CSD(sig2plot,fs,spacing,'inverse',5*spacing)';  %%%%%%%%%%% Give your data here, different channels in different columns
t_grid=repmat(t_stamps,length(chnl_labels)+2,1); % grid for current t values, two extra rows for start and the last full digit 
y_grid=repmat([0 ; chnl_labels' ; N] , 1,length(t_stamps)); % grid for current y values
t_grid_ext=repmat(t_stamps,10*N,1); % new fine t grid
y_grid_ext=repmat((.1:.1:N)',1,size(t_grid,2)); % new fine y grid
[csd_smoo]=interp2( t_grid , y_grid ,[CSDoutput(1,:) ; CSDoutput ; CSDoutput(end,:)],t_grid_ext,y_grid_ext, 'spline'); % CSD interpolation in a finer grid

figure
imagesc(t_stamps,(.1:.1:N)',csd_smoo, median(csd_smoo(:))+3*[-iqr(csd_smoo(:)) iqr(csd_smoo(:))]); %%%%%%%%%%%%%%%%%  fixing the color range for comparing different data
yticks(chnl_labels);  % yticklabels(num2cell(chnl_order)); 
colormap((jet)); % blue = source; red = sink
xlabel(' time (s)');      title('smoothed CSD (\color{red}sink, \color{blue}source\color{black})');
% overlaying SPW traces
dist=abs(max(sig2plot(:)))*1.5; %%%%%%%%%%%%%%%%% rescaling factor just for LFP overlays
hold on
for k = 1: N
plot( t_stamps ,sig2plot(:,k)'/dist+k-.5  ,'color',.0*[1 1 1],'linewidth',.5)
end
yticklabels({})
