% extracting the bird ID
data=load('G:\Hamed\zf\P1\labled sleep\batch_results2'); % the file containing the batch result of all birds
sleep_vars=data.res; % the variable containing the results
sleep_vars(6).bird='w016_08-08_scoring'; % instead of w0016...
bird_names={'72-00','73-03','72-94','w009_','w016_','w0018','w0020','w021_'};

%  extracting the ID for each bird (1 to 8)
for bird_n=1:length(sleep_vars)
    % finding the name of the bird
    bird_name_long=sleep_vars(bird_n).bird; % like 72-94_08_09_2021
    bird_name=bird_name_long(1:5); % like 72-94
    
    % finding the bird index (1 to 8)
    for i=1:length(bird_names)
        if strcmp(bird_names{i},bird_name)
            bird_id(bird_n)=i;
            break
        end
    end
end

% valid channels for each bird
valid_chnls=cell(1,8);
valid_chnls{1}=[1:5 7:16];
valid_chnls{2}=1:16;
valid_chnls{3}=[1:10 12:16];
valid_chnls{4}=[1:8 10:16];
valid_chnls{5}=[1:6 8:10 12 13 15 16];
valid_chnls{6}=[1:6 8:10 12:16];
valid_chnls{7}=[1:6 8:10 12 13 15 16];
valid_chnls{8}=[1:6 8:10 12 13 15 16];

% averaging the local wave incidence across birds
% for adults
chnl_count=zeros(1,16);
acc_loc_wav=zeros(1,16);
acc_LH=zeros(1,16);
for bird_ind=1:length(sleep_vars)
    % finding the bird ID
    bird_name_long=sleep_vars(bird_ind).bird; % like 72-94_08_09_2021
    bird_name=bird_name_long(1:5); 
    for i=1:length(bird_names)
        if strcmp(bird_names{i},bird_name)
            current_bird_id=i;
            break
        end
    end
        
    if current_bird_id<=3 % if adult
        for k=1:length(valid_chnls{current_bird_id})
            bird_valid_chnls=valid_chnls{current_bird_id};
            chnl=bird_valid_chnls(k);
            acc_loc_wav(chnl)=acc_loc_wav(chnl)+sleep_vars(bird_ind).local_wave_per_chnl(k);
            acc_LH(chnl)=acc_LH(chnl)+sleep_vars(bird_ind).LH_chnls(k);
            chnl_count(chnl)=chnl_count(chnl)+1;
        end
    end
end
adu_avg_loc_wav=acc_loc_wav./chnl_count;
adu_avg_LH=acc_LH./chnl_count;

% local wave frequency per cannel
figure
image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; %%%%%%%%%%%%%%
im=imread(image_layout);
im=.6*double(rgb2gray(imresize(im,.3)));
imshow(int8(im)); hold on
% [x,y]=ginput(16);
% xy(:,1)=x; xy(:,2)=y;
cm=autumn(200)*1; % colormap
max_val=max(adu_avg_loc_wav);
min_val=min(adu_avg_loc_wav);
for ch=1:size(adu_avg_loc_wav,2)
    rel_val=(adu_avg_loc_wav(ch)-min_val)/(max_val-min_val);
    scatter1 = scatter(x(ch),y(ch),300,'o','MarkerFaceColor',...
        cm(ceil(rel_val*200+eps),:),'MarkerEdgeColor',cm(ceil(rel_val*200+eps),:));
    scatter1.MarkerFaceAlpha = 1; scatter1.MarkerEdgeAlpha =.9;
    hold on
end
set(gcf, 'Position',[200 , 200, 600, 500]);
axis equal
title('adult average local wave incidence per channel');

% average sleep depth variable per channel
figure
imshow(int8(im)); hold on
% [x,y]=ginput(16);
% xy(:,1)=x; xy(:,2)=y;
cm=autumn(200)*1; % colormap
max_val=max(adu_avg_LH);
min_val=min(adu_avg_LH);
for ch=1:size(adu_avg_LH,2)
    rel_val=(adu_avg_LH(ch)-min_val)/(max_val-min_val);
    scatter1 = scatter(x(ch),y(ch),300,'o','MarkerFaceColor',...
        cm(ceil(rel_val*200+eps),:),'MarkerEdgeColor',cm(ceil(rel_val*200+eps),:));
    scatter1.MarkerFaceAlpha = 1; scatter1.MarkerEdgeAlpha =.9;
    hold on
end
set(gcf, 'Position',[200 , 200, 600, 500]);
axis equal
title('adult average sleep depth per channel');

% averaging the local wave incidence across birds
%% for juvenile
chnl_count=zeros(1,16);
acc_loc_wav=zeros(1,16);
acc_LH=zeros(1,16);
for bird_ind=1:length(sleep_vars)
    % finding the bird ID
    bird_name_long=sleep_vars(bird_ind).bird; % like 72-94_08_09_2021
    bird_name=bird_name_long(1:5); 
    for i=1:length(bird_names)
        if strcmp(bird_names{i},bird_name)
            current_bird_id=i;
            break
        end
    end
        
    if any(current_bird_id==[4 5 6 8]) % if juvenile
        for k=1:length(valid_chnls{current_bird_id})
            bird_valid_chnls=valid_chnls{current_bird_id};
            chnl=bird_valid_chnls(k);
            acc_loc_wav(chnl)=acc_loc_wav(chnl)+sleep_vars(bird_ind).local_wave_per_chnl(k);
            acc_LH(chnl)=acc_LH(chnl)+sleep_vars(bird_ind).LH_chnls(k);
            chnl_count(chnl)=chnl_count(chnl)+1;
        end
    end
end
adu_avg_loc_wav=acc_loc_wav./chnl_count;
adu_avg_LH=acc_LH./chnl_count;

% local wave frequency per cannel
figure
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009 layout.jpg'; %%%%%%%%%%%%%%
im=imread(image_layout);
im=.6*double(rgb2gray(imresize(im,.3)));
imshow(int8(im)); hold on
[x,y]=ginput(16);
xy(:,1)=x; xy(:,2)=y;
cm=autumn(200)*1; % colormap: parula
max_val=max(adu_avg_loc_wav);
min_val=min(adu_avg_loc_wav);
for ch=1:size(adu_avg_loc_wav,2)
    rel_val=(adu_avg_loc_wav(ch)-min_val)/(max_val-min_val);
    scatter1 = scatter(x(ch),y(ch),300,'o','MarkerFaceColor',...
        cm(ceil(rel_val*200+eps),:),'MarkerEdgeColor',cm(ceil(rel_val*200+eps),:));
    scatter1.MarkerFaceAlpha = 1; scatter1.MarkerEdgeAlpha =.9;
    hold on
end
set(gcf, 'Position',[200 , 200, 600, 500]);
axis equal
title('juvenile average local wave incidence per channel');

% average sleep depth variable per channel
figure
imshow(int8(im)); hold on
% [x,y]=ginput(16);
% xy(:,1)=x; xy(:,2)=y;
cm=autumn(200)*1; % colormap
max_val=max(adu_avg_LH);
min_val=min(adu_avg_LH);
for ch=1:size(adu_avg_LH,2)
    rel_val=(adu_avg_LH(ch)-min_val)/(max_val-min_val);
    scatter1 = scatter(x(ch),y(ch),300,'o','MarkerFaceColor',...
        cm(ceil(rel_val*200+eps),:),'MarkerEdgeColor',cm(ceil(rel_val*200+eps),:));
    scatter1.MarkerFaceAlpha = 1; scatter1.MarkerEdgeAlpha =.9;
    hold on
end
set(gcf, 'Position',[200 , 200, 600, 500]);
axis equal
title('juvenile average sleep depth per channel');









