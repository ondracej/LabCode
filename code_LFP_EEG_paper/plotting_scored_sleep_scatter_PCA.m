%% scatter plot of bouts with true label
clear;
folder_add='Y:\zoologie\HamedData\LocalSWPaper\PaperData';
EEG_file='w044_LFP_';
load([folder_add '\' EEG_file]);

% color for each stage, might need to be updated each time 
%%%%%%%%%%%%%%
r=[253 145 33 ]/255; 
s=[.4 .4 1 ]; 
i=[.2 1 1 ]; 
w=[.9 .9 .3];

% first the feats a nd the labels for hevalid indices:
all_fats=feat_ref(valid_bin_ref_inds,:);
plot_inds=randsample(length(bin_label_ref),1000);
% Step 1: Standardize the data
A_standardized = zscore(all_fats(plot_inds,:));

% Step 2: Perform PCA to reduce dimensionality
[coeff, score, ~, ~, explained] = pca(A_standardized);

% Step 3: Choose the top 3 principal components
top_3_components = coeff(:, 1:3);

% Step 4: Project the original data onto the top 3 components
new_features = A_standardized * top_3_components;

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
    scatter(new_features(i, 1), new_features(i, 2), 20, color, 'filled');
    end
end

xlabel('PCt 1');
ylabel('PC 2');

title('2D Visualization with PCA');



