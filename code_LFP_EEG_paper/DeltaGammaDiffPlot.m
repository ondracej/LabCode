%% run this code after 'automated_sleep_staging.m', also need to do clustering there


t_lim=[90 100]*60; % 5 minutes before and after for the window that counts the bins fro congruence calculation

% smoothing
windowSize=11; %%%%%%%%%%%%
Delta_smoothed = movingAverageSmoothing(Delta_, t_bin_label, windowSize);
Delta_ref_smoothed = movingAverageSmoothing(Delta_ref_, t_bin_label_ref, windowSize);
Gamma_smoothed = movingAverageSmoothing(Gamma_, t_bin_label, windowSize);
Gamma_ref_smoothed = movingAverageSmoothing(Gamma_ref_, t_bin_label_ref, windowSize);
h=figure
set(h,'position',[100 300 1000 280]);
plot(t_bin_label/60,(Delta_smoothed./Gamma_smoothed), 'color',.8*[0 0 1], 'linewidth',2 ); hold on
plot(t_bin_label_ref/60,(Delta_ref_smoothed./Gamma_ref_smoothed), 'color',.8*[1 0 0 ], 'linewidth',2); hold on
ylabel('Delta/Gamma')

ylim([-60 210])
xlim(t_lim/60)
xlabel('Time (min)');

% adding the labels of the LFP channel
r=[1 .5 0]; 
s=[.4 .4 1]; 
i=[0 .83 .98]; 
w=.3*[1 1 1];
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_bin_label (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1));
label_plot=bin_label (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label_ref
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5]/60,-10+[0 0],'color',color_order_(stage,:),'linewidth',15 );
end
% adding lael for the ref channel
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_bin_label_ref (t_bin_label_ref>=(t_lim(1)-1) & t_bin_label_ref<=(t_lim(2)+1));
label_plot=bin_label_ref (t_bin_label_ref>=(t_lim(1)-1) & t_bin_label_ref<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label_ref
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5]/60,-45+[0 0],'color',color_order_(stage,:),'linewidth',15 );
end
title('d/g, w044, smoothed in 30 sec window, dark blue: LFP, dark red: ref, top label: LFP, lower labels: ref');

