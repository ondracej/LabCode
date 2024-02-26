%% visualization of the temporal dynamics of congruence duirng SWS between DVR and base channel
clear ;
s=[.35 .35 1];
r=[253 145 33]/255;
folder_name='Y:\zoologie\HamedData\LocalSWPaper\PaperData\new_scorings';
bird_name='w027'; %%%%%%%%%%%%%
t_lim=22000/20+[0 12*3600]; %%%%%%%%%%%%%% 
load([folder_name '\' bird_name '_lfp']); 
bin_label=labels_;
t_bin_label=t_DG;
load([folder_name '\' bird_name '_l_a']);
bin_label_ref=labels_;
t_bin_label_ref=t_DG;

inds_in_range=t_DG>=t_lim(1) & t_DG<=t_lim(2);
t_bin_in_range=t_DG(inds_in_range);

for bin=1:length(t_bin_in_range)
    % congruence
    [sws_congruence(bin) , sws_bins_ref(bin), sws_bins(bin)]= moving_cngruence_sws(t_DG,t_bin_in_range(bin),...
            bin_label_ref,bin_label, t_bin_label_ref, t_bin_label);
end
%%
t1=1; %%%%%%
t_lim=[t1 t1+3]*3600;
figure('position',[200 400 700 300]);
subplot(3,1,1)
plot(t_bin_in_range/60,sws_bins_ref/101, 'color',s,'linewidth',1.5); hold on
xlim(t_lim/60)
xticklabels([]); box off
ylabel('p(SWS) L ant')
ylim([0 1])

subplot(3,1,2)
plot(t_bin_in_range/60,sws_bins/101, 'color',s,'linewidth',1.5); hold on
xlim(t_lim/60)
xticklabels([]); box off
ylabel('p(SWS) DVR')
ylim([0 1])

% congruence
subplot(3,1,3)
plot(t_bin_in_range/60,sws_congruence*100, 'color','k','linewidth',1.5); hold on 
xlim(t_lim/60)
xlabel('Time (min)'); box off
ylabel('SWS cong (%)')
ylim([0 100])


%% visualization of the temporal dynamics of congruence duirng REM

load([folder_name '\' bird_name '_lfp']); 
bin_label=labels_;
t_bin_label=t_DG;
load([folder_name '\' bird_name '_l_a']);
bin_label_ref=labels_;
t_bin_label_ref=t_DG;

inds_in_range=t_DG>=t_lim(1) & t_DG<=t_lim(2);
t_bin_in_range=t_DG(inds_in_range);

for bin=1:length(t_bin_in_range)
    % congruence
    [rem_congruence(bin) , rem_bins_ref(bin), rem_bins(bin)]= moving_cngruence_rem(t_DG,t_bin_in_range(bin),...
            bin_label_ref,bin_label, t_bin_label_ref, t_bin_label);
end
rem_congruence(rem_congruence==1)=zeros(1,sum(rem_congruence==1));
%%
t1=1; %%%%%%
t_lim=[t1 t1+3]*3600;
figure('position',[200 400 700 300]);
subplot(3,1,1)
plot(t_bin_in_range/60,rem_bins_ref/101, 'color',r,'linewidth',1.5); hold on
xlim(t_lim/60)
xticklabels([]); box off
ylabel('p(rem) L ant')
ylim([0 1])

subplot(3,1,2)
plot(t_bin_in_range/60,rem_bins/101, 'color',r,'linewidth',1.5); hold on
xlim(t_lim/60)
xticklabels([]); box off
ylabel('p(rem) DVR')
ylim([0 1])

% congruence
subplot(3,1,3)
plot(t_bin_in_range/60,rem_congruence*100, 'color','k','linewidth',1.5); hold on 
xlim(t_lim/60)
xlabel('Time (min)'); box off
ylabel('rem cong (%)')
ylim([0 100])
%%

% saing varibles
folder_add='Z:\HamedData\LocalSWPaper\PaperData';
save([folder_add '\' bird_name '_cong_temporal'],'rem_bins_ref','rem_bins','rem_congruence'...
    ,'sws_bins_ref','sws_bins','sws_congruence','t_bin_in_range');
