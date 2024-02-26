%% run this code after 'automated_sleep_staging.m', also need to do clustering there


t_lim=[1 2]*3600; % 5 minutes before and after for the window that counts the bins fro congruence calculation

% smoothing
windowSize=11; %%%%%%%%%%%%
Delta_smoothed = movingAverageSmoothing(Delta_, t_bin_label, windowSize);
Delta_ref_smoothed = movingAverageSmoothing(Delta_ref_, t_bin_label_ref, windowSize);
Gamma_smoothed = movingAverageSmoothing(Gamma_, t_bin_label, windowSize);
Gamma_ref_smoothed = movingAverageSmoothing(Gamma_ref_, t_bin_label_ref, windowSize);
% fing the common part of the DG and DG_ref
DG=Delta_smoothed./Gamma_smoothed;
DG_ref=Delta_ref_smoothed./Gamma_ref_smoothed;
%
DG_range=range(DG);
DG_ref_range=range(DG_ref);
n=1;
clear DG_diff DG_diff_t label_equal
normalization_factor=1.3; %%%%%%%%%%%%%
for k=1:length(t_bin_label)
    if sum(t_bin_label_ref==t_bin_label(k))>0  % if t_bin(k) also exists in t_bin_ref
    DG_diff(n)=DG(k)/DG_range-normalization_factor*DG_ref(t_bin_label_ref==t_bin_label(k))/DG_ref_range;
    DG_diff_t(n)=t_bin_label(k);
    label_equal(n)=strcmp(bin_label(k),bin_label_ref(t_bin_label_ref==t_bin_label(k)));
    n=n+1;
    end
end


h=figure
set(h,'position',[100 300 1000 580]);
subplot(2,1,1)
plot(t_bin_label/60,100*(DG-min(DG))/range(DG), 'color',.8*[0 0 1], 'linewidth',2 ); hold on
plot(t_bin_label_ref/60,normalization_factor*100*(DG_ref-min(DG_ref))/range(DG_ref), 'color',.8*[1 0 0], 'linewidth',2); hold on
ylabel({'Normalized';'Delta/Gamma (%)'})

ylim([-60 100])
xlim(t_lim/60)

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
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5]/60,-15+[0 0],'color',color_order_(stage,:),'linewidth',15 );
end
% adding label for the ref channel
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_bin_label_ref (t_bin_label_ref>=(t_lim(1)-1) & t_bin_label_ref<=(t_lim(2)+1));
label_plot=bin_label_ref (t_bin_label_ref>=(t_lim(1)-1) & t_bin_label_ref<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label_ref
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5]/60,-45+[0 0],'color',color_order_(stage,:),'linewidth',15 );
end
title('w027, smoothed d/g with 30 sec win,    blue:LFP,  red:ref,     top labels:LFP,  bottom labels:ref');

%
subplot(2,1,2)
xlim(t_lim/60)
%
subplot(2,1,2)
ones_indices = find(~label_equal);

% Plot barcode using stem function
stem(DG_diff_t(ones_indices)/60, ~label_equal(ones_indices)*100,'Color', .7*[1 1 1],  'Marker', 'none'...
    ,'linewidth',3); hold on
stem(DG_diff_t(ones_indices)/60, ~label_equal(ones_indices)*-100,'Color', .7*[1 1 1],  'Marker', 'none'...
    ,'linewidth',3);
plot(DG_diff_t/60,DG_diff*100, 'color',0*[1 1 1], 'linewidth',.4); hold on
ylabel({'Delta/Gamma difference';' (%)'})

ylim([-70 50])
xlim(t_lim/60);
ylim([-40 40])
xlabel('Time (min)');
ylabel('Non-match labels');