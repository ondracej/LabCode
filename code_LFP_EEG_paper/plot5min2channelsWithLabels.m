% load the LFP signal first
clear;
folder_add='Y:\zoologie\HamedData\LocalSWPaper\PaperData';
LFP_file='w027_LFP_';
EEG_file='w027_ref';
load([folder_add '\' LFP_file]);

fs=30000/128;
bpFilt = designfilt('bandpassiir','FilterOrder',4,'HalfPowerFrequency1',1,'HalfPowerFrequency2',40, ...
    'SampleRate',fs);

% reconstructing the sgnal form the array organization
LFP=reshape(ref_binned',1,size(ref_binned,1)*size(ref_binned,2));
LFP=filtfilt(bpFilt,LFP);

% building the corresponding t for LFP
t_new=t_feat-1.5;
t_new=repmat(t_new',1,1406);

t_in_between=linspace(0,3,1407);
fine_grined=repmat(t_in_between(1:end-1),size(t_new,1),1); % repeating the fine-grinded time for the whole t_fean length
t_new=t_new+fine_grined;
t_new=reshape(t_new',1,numel(t_new));

t_LFP=[(t_new(1)-3)+t_in_between(1:end-1) t_new t_new(end)+t_in_between(2:end)];

LFP_label=bin_label_ref;
t_LFP_label=t_bin_label_ref;

%% load the EEG signal and do the same to the EEG
load([folder_add '\' EEG_file]);
% reconstructing the sgnal form the array organization
EEG=reshape(ref_binned',1,size(ref_binned,1)*size(ref_binned,2));
EEG=filtfilt(bpFilt,EEG);

% building the corresponding t for EEG

t_new=t_feat-1.5;
t_new=repmat(t_new',1,1406);

t_in_between=linspace(0,3,1407);
fine_grined=repmat(t_in_between(1:end-1),size(t_new,1),1); % repeating the fine-grinded time for the whole t_fean length
t_new=t_new+fine_grined;
t_new=reshape(t_new',1,numel(t_new));

t_EEG=[(t_new(1)-3)+t_in_between(1:end-1) t_new t_new(end)+t_in_between(2:end)];

EEG_label=bin_label;
t_EEG_label=t_bin_label;
%% visualization of a piece of EEG with stages indicated

r=[1 .5 0]; 
s=[.4 .4 1]; 
i=[0 .83 .98]; 
w=[1 1 1];
t0=14460;
t_lim=t0+[0 2*60]; %randsample(36000,1)+3600+[0 30]; % t lim for visualization

inds=t_LFP<t_lim(2) & t_LFP>t_lim(1); 

figure('position',[100 200 1000 250]);
subplot(1,1,1)
plot (t_LFP,LFP,'color',0*[1 1 1]);
xlim(t_lim/60);
hold on % scale coeff for vizualization 
ylim([-110 100]);

% adding colored shades indicating stage of sleep for any 2-sec bin 
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_LFP_label(t_LFP_label>=(t_lim(1)-1) & t_LFP_label<=(t_lim(2)+1));
label_plot=LFP_label (t_LFP_label>=(t_lim(1)-1) & t_LFP_label<=(t_lim(2)+1)); %%%%%%%%%% bin_label or LFP_label
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5],-100+[0 0],'color',color_order_(stage,:),'linewidth',15 );
end
xlim(t_lim)
xlabel('Time (minute)');
ylabel({'LFP';'Amplitude (\muV)'})
title('scoring example 3, two minutes');
%% for EEG
inds=t_EEG<t_lim(2) & t_EEG>t_lim(1); 

subplot(2,1,2)
plot (t_EEG,EEG*1.5,'color',0*[1 1 1]);
xlim(t_lim);
hold on % scale coeff for vizualization 
ylim([-150 150]);

% adding colored shades indicating stage of sleep for any 2-sec bin 
t_bin_plot=t_EEG_label(t_EEG_label>=(t_lim(1)-1) & t_EEG_label<=(t_lim(2)+1));
label_plot=EEG_label (t_EEG_label>=(t_lim(1)-1) & t_EEG_label<=(t_lim(2)+1)); %%%%%%%%%% bin_label or EEG_label
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5],-100+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
xlabel('Time (sec)');
ylabel({'front L EEG';'Amplitude (\muV)'})


