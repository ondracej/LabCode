%% visualization of the temporal dynamics of congruence duirng SWS between DVR and base channel
t_lim=t_dark; % 5 minutes before and after for the window that counts the bins fro congruence calculation
clear t_bin_center_ref t_bin_center_lfp SWS_prob_ref SWS_prob_lfp sws_congruence sws_bins
h=figure;

inds_in_range=t_bin_label>=t_lim(1) & t_bin_label<=t_lim(2);
t_bin_in_range=t_bin_label(inds_in_range);
for bin=1:length(t_bin_in_range)
    % congruence
    [sws_congruence(bin) , sws_bins_ref(bin), sws_bins(bin)]= moving_cngruence_sws(t_feat,t_bin_in_range(bin),valid_bin_inds,valid_bin_ref_inds,...
    bin_label_ref,bin_label, t_bin_label_ref, t_bin_label);
end

subplot(3,1,1)
plot(t_bin_in_range/60,sws_bins_ref/101, 'color',s,'linewidth',1.5); hold on
xlim(t_lim/60)
xlabel('Time (min)');
ylabel('p(SWS) L ant')
ylim([0 1])

subplot(3,1,2)
plot(t_bin_in_range/60,sws_bins/101, 'color',s,'linewidth',1.5); hold on
xlim(t_lim/60)
xlabel('Time (min)');
ylabel('p(SWS) DVR')
set(h,'position',[100 300 1000 400]);
ylim([0 1])

% congruence
subplot(3,1,3)
plot(t_bin_in_range/60,sws_congruence*100, 'color',s,'linewidth',1.5); hold on 
xlim(t_lim/60)
xlabel('Time (min)');
ylabel('SWS cong (%)')
ylim([0 100])


%% visualization of the temporal dynamics of congruence duirng rem between DVR and base channel
clear t_bin_center_ref t_bin_center_lfp rem_prob_ref rem_prob_lfp rem_congruence rem_bins
for bin=1:length(t_bin_in_range)
    % congruence
    [rem_congruence(bin) , rem_bins_ref(bin), rem_bins(bin)]= moving_cngruence_rem(t_feat,t_bin_in_range(bin),valid_bin_inds,valid_bin_ref_inds,...
    bin_label_ref,bin_label, t_bin_label_ref, t_bin_label);
end
g=figure;
subplot(3,1,1)
plot(t_bin_in_range/60,rem_bins_ref/101, 'color',r,'linewidth',1.5);
xlim(t_lim/60)
xlabel('Time (min)');
ylabel('p(REM) L ant')
ylim([0 1])

subplot(3,1,2)
plot(t_bin_in_range/60,rem_bins/101, 'color',r,'linewidth',1.5);
xlim(t_lim/60)
xlabel('Time (min)');
ylabel('p(REM) DVR')
set(g,'position',[100 300 1000 400]);
ylim([0 1])

% congruence
subplot(3,1,3)
plot(t_bin_in_range/60,rem_congruence*100, 'color',r,'linewidth',1.5);
xlim(t_lim/60)
xlabel('Time (min)');
ylabel('REM cong (%)')
ylim([0 100])


% saing varibles
folder_add='Z:\HamedData\LocalSWPaper\PaperData';
save([folder_add '\' bird_name '_cong_temporal'],'rem_bins_ref','rem_bins','rem_congruence'...
    ,'sws_bins_ref','sws_bins','sws_congruence','t_bin_in_range');
