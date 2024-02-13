%% scatter plot of bouts with true label in 3d
% load the data
clear;
folder_add='Y:\zoologie\HamedData\LocalSWPaper\PaperData';
EEG_file='w0_LFP_';
load([folder_add '\' EEG_file]);

% color for each stage, might need to be updated each time 
%%%%%%%%%%%%%%
r=[253 145 33 ]/255; 
s=[.4 .4 1 ]; 
i=[.2 1 1 ]; 
w=[.9 .9 .3];

% first the feats a nd the labels for hevalid indices:
feat1=zscore(log10(Delta_ref_));
feat2=zscore(log10(Gamma_ref_));%;log10(Delta_);
feat3=zscore(feat_ref(valid_bin_ref_inds,6)); %log10(Gamma_);
plot_inds=randsample(sum(valid_bin_ref_inds),800);


% Step 5: Create a 3D scatter plot with colored points based on labels
% Assuming 'labels' is a cell array of strings
% Specify custom colors for each class
class_colors = containers.Map({
    'Wake', 'REM', 'IS', 'SWS'}, {w,r,i,s});

% Step 5: Create a 3D scatter plot with colored points based on labels
figure;
labels=bin_label_ref(plot_inds);
% Color each point based on the corresponding class color
for i = 1:length(labels)
    color = class_colors(labels{i});
    if strcmp(labels{i},'Wake')
        continue
    else
    hold on;
    ind=plot_inds(i);
    scatter3(feat1(ind), feat2(ind), feat3(ind), 18, color, 'filled');
    end
end
zlim([-3 4])
xlim([-4 3])
xlabel('log Delta');
ylabel('log Gamma');
zlabel('max amplitude');

title('3D Visualization of scored bins');
view(-10,30)


