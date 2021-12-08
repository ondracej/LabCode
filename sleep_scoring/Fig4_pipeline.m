fs=30000/64;
% reshaping data in 3 sec windows, in case bins are 1.5 sec
if exist('EEG_')==1
    EEG=EEG_;
end
if size(EEG,3)>27000
new_len=floor(size(EEG,3)/2);
EEG3sec=zeros(size(EEG,1)*2,size(EEG,2),new_len);
for k=1:new_len
    EEG3sec(:,:,k)=[EEG(:,:,2*k-1);EEG(:,:,2*k)];
end
t_bins3sec=downsample(t_bins,2)+1.5/2;
mov3sec=downsample((mov+circshift(mov,-1))/2, 2);
else
mov3sec=mov;
EEG3sec=EEG;
t_bins3sec=t_bins;
end
mov3sec=mov3sec(1:size(EEG3sec,3));
clear t_bins mov k feats EEG auto_label
chnl=4; % one non-noisy channel
eeg=reshape(EEG3sec(:,chnl,:),[1,size(EEG3sec,1)*size(EEG3sec,3)]);
thresh=4*iqr(eeg);
maxes_=max(abs(EEG3sec(:,chnl,:)),[],1);
maxes=reshape(maxes_,[1,length(maxes_)]);
thresh_mov=median(mov3sec)+5*iqr(mov3sec); % threshold for separating wakes from sleep based on movement
valid_inds=find(maxes<thresh & mov3sec'<thresh_mov);
valid_inds_logic=(maxes<thresh & mov3sec'<thresh_mov);

% extracting low/high ratio (LH)
fs=30000/64;
LH=NaN(1,size(EEG3sec,3)); % low/high freq ratio
for k=1:size(EEG3sec,3)
    % settings for multitaper
    nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
    [pxx,f]=pmtm(EEG3sec(:,chnl,k),TW,nfft,round(fs));
    px_low=norm(pxx(f<8 & f>1.5));
    px_high=norm(pxx(f<49 & f>30));
    LH(k)=px_low/px_high;
end
 
% taking samples of each stage  
% we take 10% of each stage
LH_valid=LH(valid_inds);
REM_thresh=quantile(LH_valid,.1); % 10% quartile for REM
IS1_thresh=quantile(LH_valid,.45); % 10% quartile for lower IS
IS2_thresh=quantile(LH_valid,.55); % 10% quartile for upper bound of IS
SWS_thresh=quantile(LH_valid,.9); % 10% quartile for SWS
REM_valid_inds=valid_inds(LH_valid<REM_thresh); % linear index to valid_inds for REM
IS_valid_inds=valid_inds(LH_valid<IS2_thresh & LH_valid>IS1_thresh); % linear index to valid_inds for IS
SWS_valid_inds=valid_inds(LH_valid>SWS_thresh); % linear index to valid_inds for SWS


%% maximal clique extraction for each stage
% We go through all the data bins of a specific stage, and extract the
% cliques. If it is a new clique, that has never been extracted before, we
% add it to the badge of possible cliques (cliques_listed), and then for
% each bin, we just add the indices of the cliques it has.

% for REM
cliques_listed=[];
REM_cliques_address=[];
for bin_n=1:length(REM_valid_inds)
    
    [s1,~,~,~] = infer_network_correlation_analytic(EEG3sec(:,valid_chnls,REM_valid_inds(bin_n))); % extracting the statically-significant correlation pairs ...
    % in the correlation matrix. So, each entry in the s1 is either 0, or 1
    s=s1-diag(diag(s1)); % removing self loops
    [ current_cliques ] = maximalCliques( s ); % extract fully-connected subgrapohs, each clique is a column of ones and zeroes ...
    % in the output matrix
    
    % for the very first clique detected :
    if bin_n==1
        cliques_listed=current_cliques; 
        REM_cliques_address=1:size(current_cliques,2);   
        continue;
    end
    % for bin_n=2, or more:
        for current_clique_ind=1:size(current_cliques,2)
            n_matches=0; % this variable will become 1 in case the current clique matches with one of the the ones in the template
            for clique_template_ind=1:size(cliques_listed,2)
                if cliques_listed(:,clique_template_ind)==current_cliques(:,current_clique_ind)
                    REM_cliques_address=[REM_cliques_address clique_template_ind];
                    n_matches=1;
                    break;
                end
            end
            if  n_matches==0
                % we have a new clique that has not bin listed yet, so we
                % should add it to our bag of listed_cliques:
                cliques_listed=[cliques_listed current_cliques(:,current_clique_ind)];
            end
        end
end

% for IS
IS_cliques_address=[];
for bin_n=1:length(IS_valid_inds)
    
    [s1,~,~,~] = infer_network_correlation_analytic(EEG3sec(:,valid_chnls,IS_valid_inds(bin_n))); % extracting the statically-significant correlation pairs ...
    % in the correlation matrix. So, each entry in the s1 is either 0, or 1
    s=s1-diag(diag(s1)); % removing self loops
    [ current_cliques ] = maximalCliques( s ); % extract fully-connected subgrapohs, each clique is a column of ones and zeroes ...
    % in the output matrix
    % only cliques with min 3 points are accepted:

        for current_clique_ind=1:size(current_cliques,2)
            n_matches=0; % this variable will become 1 in case the current clique matches with one of the the ones in the template
            for clique_template_ind=1:size(cliques_listed,2)
                if cliques_listed(:,clique_template_ind)==current_cliques(:,current_clique_ind)
                    IS_cliques_address=[IS_cliques_address clique_template_ind];
                    n_matches=1;
                    break;
                end
            end
            if  n_matches==0
                % we have a new clique that has not bin listed yet, so we
                % should add it to our bag of listed_cliques:
                cliques_listed=[cliques_listed current_cliques(:,current_clique_ind)];
            end
        end
end

% for SWS
SWS_cliques_address=[];
for bin_n=1:length(SWS_valid_inds)
    
    [s1,~,~,~] = infer_network_correlation_analytic(EEG3sec(:,valid_chnls,SWS_valid_inds(bin_n))); % extracting the statically-significant correlation pairs ...
    % in the correlation matrix. So, each entry in the s1 is either 0, or 1
    s=s1-diag(diag(s1)); % removing self loops
    [ current_cliques ] = maximalCliques( s ); % extract fully-connected subgrapohs, each clique is a column of ones and zeroes ...
    % in the output matrix

        for current_clique_ind=1:size(current_cliques,2)
            n_matches=0; % this variable will become 1 in case the current clique matches with one of the the ones in the template
            for clique_template_ind=1:size(cliques_listed,2)
                if cliques_listed(:,clique_template_ind)==current_cliques(:,current_clique_ind)
                    SWS_cliques_address=[SWS_cliques_address clique_template_ind];
                    n_matches=1;
                    break;
                end
            end
            if  n_matches==0
                % we have a new clique that has not bin listed yet, so we
                % should add it to our bag of listed_cliques:
                cliques_listed=[cliques_listed current_cliques(:,current_clique_ind)];
            end
        end
end

% sanity check for the uniqueness of the listed cliques:
[C,~,~] = unique(cliques_listed','stable','rows');
C==cliques_listed';

%% making a figure for the incidence of cliques in each stage
% Here are the steps to calculate the rate of ocurrance of each clique
% starting from the cliques_address:
% clique_address:    1 2 1 3 2 2 3
% 0 , sort , max:    0 1 1 2 2 2 3 3 4
% diff:               1 0 1 0 0 1 0 1
% find:               1   3     6   8 
% diff:                 2    3    2         

% for REM
sorted_adds=[0 sort(REM_cliques_address) max(REM_cliques_address)+1];
add_jumps=diff(sorted_adds);
jump_locus=find(add_jumps);
REM_clique_occurance_ordinal=diff(jump_locus);
[REM_clique_occurance_sorted, REM_clique_occurance_sorted_inds]=sort(REM_clique_occurance_ordinal,'descend');


% for IS
sorted_adds=[0 sort(IS_cliques_address) max(IS_cliques_address)+1];
add_jumps=diff(sorted_adds);
jump_locus=find(add_jumps);
IS_clique_occurance_ordinal=diff(jump_locus);
[IS_clique_occurance_sorted, IS_clique_occurance_sorted_inds]=sort(IS_clique_occurance_ordinal,'descend');


% for SWS
sorted_adds=[0 sort(SWS_cliques_address)  max(SWS_cliques_address)+1];
add_jumps=diff(sorted_adds);
jump_locus=find(add_jumps);
SWS_clique_occurance_ordinal=diff(jump_locus);
[SWS_clique_occurance_sorted, SWS_clique_occurance_sorted_inds]=sort(SWS_clique_occurance_ordinal,'descend');



% picking the most-frequent cliques in SWS
% we keep the cliques that are happening at least in 10 % of the time
thresh=.1*length(SWS_valid_inds); % %10 of the times
SWS_main_cliques_ind_=find(SWS_clique_occurance_ordinal>=thresh);
SWS_available_cliques=unique(sort(SWS_cliques_address));
SWS_main_cliques_ind=SWS_available_cliques(SWS_main_cliques_ind_);
SWS_main_cliques=cliques_listed(:,SWS_main_cliques_ind);

% figure
% plot(SWS_cliques_address,'.','markersize',7); hold on
% xlabel('bin number'); ylabel('clique number')
% x=1:length(SWS_cliques_address);
% for kk=1:length(SWS_main_cliques_ind)
%     inds=SWS_cliques_address==SWS_main_cliques_ind(kk);
%     plot(x(inds),SWS_cliques_address(inds),'r.','markersize',3)
% end
%     
    
SWS_subnet_incidence=figure;
plot(SWS_clique_occurance_sorted/length(SWS_valid_inds),'.','markersize',10); hold on
line([1 length(SWS_clique_occurance_sorted)],[thresh thresh]/length(SWS_valid_inds),'linestyle','--','color',[1 .2 0]);
xlabel('clique number'); ylabel('Frequency of observation');  title('SWS')

% picking the most-frequent cliques in IS
% we keep the cliques that are happening at least in 10 % of the time
thresh=.1*length(IS_valid_inds); % %10 of the times
IS_main_cliques_ind_=find(IS_clique_occurance_ordinal>=thresh);
IS_available_cliques=unique(sort(IS_cliques_address));
IS_main_cliques_ind=IS_available_cliques(IS_main_cliques_ind_);
IS_main_cliques=cliques_listed(:,IS_main_cliques_ind);

% figure
% plot(IS_cliques_address,'.','markersize',7); hold on
% xlabel('bin number'); ylabel('clique number')
% x=1:length(IS_cliques_address);
% for kk=1:length(IS_main_cliques_ind)
%     inds=IS_cliques_address==IS_main_cliques_ind(kk);
%     plot(x(inds),IS_cliques_address(inds),'r.','markersize',3)
% end
    
IS_subnet_incidence=figure;
plot(IS_clique_occurance_sorted/length(IS_valid_inds),'.','markersize',10); hold on
line([1 length(IS_clique_occurance_sorted)],[thresh thresh]/length(IS_valid_inds),'linestyle','--','color',[1 .2 0]);
xlabel('clique number'); ylabel('Frequency of observation');  title('IS')


% picking the most-frequent cliques in REM
% we keep the cliques that are happening at least in 10 % of the time
thresh=.1*length(REM_valid_inds); % %10 of the times
REM_main_cliques_ind_=find(REM_clique_occurance_ordinal>=thresh);
REM_available_cliques=unique(sort(REM_cliques_address));
REM_main_cliques_ind=REM_available_cliques(REM_main_cliques_ind_);
REM_main_cliques=cliques_listed(:,REM_main_cliques_ind);

% figure
% plot(REM_cliques_address,'.','markersize',7); hold on
% xlabel('bin number'); ylabel('clique number')
% x=1:length(REM_cliques_address);
% for kk=1:length(REM_main_cliques_ind)
%     inds=REM_cliques_address==REM_main_cliques_ind(kk);
%     plot(x(inds),REM_cliques_address(inds),'r.','markersize',3)
% end
    
    
REM_subnet_incidence=figure;
plot(REM_clique_occurance_sorted/length(REM_valid_inds),'.','markersize',10); hold on
line([1 length(REM_clique_occurance_sorted)],[thresh thresh]/length(REM_valid_inds),'linestyle','--','color',[1 .2 0]);
xlabel('clique number'); ylabel('Frequency of observation'); title('REM')

% %% visualization of recurring co-active cluster (cliques)
% 
% % getting the coordinates of the recording sites:
% figure
% image_layout='Z:\zoologie\HamedData\P1\72-94\72-94 layout.jpg'; %%%%%%%%%%%%%%
% title(fname);
% im=imread(image_layout);
% im=.6*double(rgb2gray(imresize(im,.3)));
% imshow(int8(im)); hold on
% [x,y]=ginput(16);
% xy(:,1)=x; xy(:,2)=y;
xy =[
   74.2000  157.1000
   58.8000  172.1000
   51.5000  140.7000
   42.8000  154.7000
   41.1000  119.6000
   54.2000   96.2000
   78.2000  101.9000
   78.2000   84.2000
  113.3000   83.5000
  111.0000  101.6000
  134.1000   96.2000
  148.4000  116.0000
  135.4000  136.0000
  148.8000  150.4000
  117.7000  151.7000
  130.4000  168.4000];
%%
% first preparing the color scheme for color-coding the subnetworks by their
% corresponding ocurrance rate
rates=[SWS_clique_occurance_sorted(1:size(SWS_main_cliques,2))/length(SWS_valid_inds), ...
    IS_clique_occurance_sorted(1:size(IS_main_cliques,2))/length(IS_valid_inds), ...
    REM_clique_occurance_sorted(1:size(REM_main_cliques,2))/length(REM_valid_inds)];
cmap=winter(100);

subnets_fig=figure('Position',[10 200 1950 420]);
whole_graph=zeros(16);
whole_graph(valid_chnls,valid_chnls)=ones(length(valid_chnls)); % a fully-connected substrate minus the noisy channels
Gcorr = graph(whole_graph,'lower','omitselfloops'); % the main graph containing all the possible edges between each pair of nodes
subplot(1,3,1) % for SWS networks
hold on
for k =1:size(SWS_main_cliques,2)
    % laying out electrode sites
    x0=(max(xy(:,1))/3)*(rem(k-1,3))-min(xy(:,1))/3; % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    y0=(max(xy(:,2))/3)*floor((k-1)/3)-min(xy(:,2))/3;  % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    for ch=1:16
        scatter1 = scatter(xy(ch,1)/3+x0, xy(ch,2)/3+y0,30,'o','MarkerFaceColor',[.5 .6 .8],...
            'MarkerEdgeColor',.5*[1 1 1],'MarkerFaceAlpha',.4,...
            'MarkerEdgeAlpha',.2);
    end
    
    clique_right_size=false(16,1); % assigning zeroes to the noisy chasnnels, and constructing a 16x1 vector for the subgraph
    clique_right_size(valid_chnls)=SWS_main_cliques(:,k);
    sub=subgraph(Gcorr,clique_right_size);
    h=plot(sub,'EdgeAlpha',.8,'markersize',4,'NodeColor',[1 .6 .5]); hold on
    XData=xy(logical(clique_right_size),1);  YData=xy(logical(clique_right_size),2);
    h.XData=XData/3+x0;      h.YData=YData/3+y0; 
    h.NodeLabel = {};
    h.LineWidth = 1;
    axis([-5 max(xy(:,1)) -5 max(xy(:,2))]); axis square; axis ij
    xticks([]);  yticks([]);
    h.EdgeColor = cmap(ceil(eps+99.99*(SWS_clique_occurance_sorted(k)/length(SWS_valid_inds)-min(rates))/range(rates)),:);

end
title('SWS co-active netwoks')

whole_graph=zeros(16);
whole_graph(valid_chnls,valid_chnls)=ones(length(valid_chnls)); % a fully-connected substrate minus the noisy channels
Gcorr = graph(whole_graph,'lower','omitselfloops'); % the main graph containing all the possible edges between each pair of nodes
subplot(1,3,2) % for IS networks
hold on
for k =1:size(IS_main_cliques,2)
    % laying out electrode sites
    x0=(max(xy(:,1))/3)*(rem(k-1,3))-min(xy(:,1))/3; % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    y0=(max(xy(:,2))/3)*floor((k-1)/3)-min(xy(:,2))/3;  % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    for ch=1:16
        scatter1 = scatter(xy(ch,1)/3+x0, xy(ch,2)/3+y0,30,'o','MarkerFaceColor',[.5 .6 .8],...
            'MarkerEdgeColor',.5*[1 1 1],'MarkerFaceAlpha',.4,...
            'MarkerEdgeAlpha',.2);
    end
    
    clique_right_size=false(16,1); % assigning zeroes to the noisy chasnnels, and constructing a 16x1 vector for the subgraph
    clique_right_size(valid_chnls)=IS_main_cliques(:,k);
    sub=subgraph(Gcorr,clique_right_size);
    h=plot(sub,'EdgeAlpha',.8,'markersize',4,'NodeColor',[1 .6 .5]); hold on
    XData=xy(logical(clique_right_size),1);  YData=xy(logical(clique_right_size),2);
    h.XData=XData/3+x0;      h.YData=YData/3+y0; 
    h.NodeLabel = {};
    h.LineWidth = 1;
    axis([-5 max(xy(:,1)) -5 max(xy(:,2))]); axis square; axis ij
    xticks([]);  yticks([]);
    h.EdgeColor = cmap(ceil(eps+99.99*(IS_clique_occurance_sorted(k)/length(IS_valid_inds)-min(rates))/range(rates)),:);

end
title('IS co-active netwoks')

whole_graph=zeros(16);
whole_graph(valid_chnls,valid_chnls)=ones(length(valid_chnls)); % a fully-connected substrate minus the noisy channels
Gcorr = graph(whole_graph,'lower','omitselfloops'); % the main graph containing all the possible edges between each pair of nodes
subplot(1,3,3) % for REM networks
hold on
for k =1:size(REM_main_cliques,2)
    % laying out electrode sites
    x0=(max(xy(:,1))/3)*(rem(k-1,3))-min(xy(:,1))/3; % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    y0=(max(xy(:,2))/3)*floor((k-1)/3)-min(xy(:,2))/3;  % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    for ch=1:16
        scatter1 = scatter(xy(ch,1)/3+x0, xy(ch,2)/3+y0,30,'o','MarkerFaceColor',[.5 .6 .8],...
            'MarkerEdgeColor',.5*[1 1 1],'MarkerFaceAlpha',.4,...
            'MarkerEdgeAlpha',.2);
    end
    
    clique_right_size=false(16,1); % assigning zeroes to the noisy chasnnels, and constructing a 16x1 vector for the subgraph
    clique_right_size(valid_chnls)=REM_main_cliques(:,k);
    sub=subgraph(Gcorr,clique_right_size);
    h=plot(sub,'EdgeAlpha',.8,'markersize',4,'NodeColor',[1 .6 .5]); hold on
    XData=xy(logical(clique_right_size),1);  YData=xy(logical(clique_right_size),2);
    h.XData=XData/3+x0;      h.YData=YData/3+y0; 
    h.NodeLabel = {};
    h.LineWidth = 1;
    axis([-5 max(xy(:,1)) -5 max(xy(:,2))]); axis square; axis ij
    xticks([]);  yticks([]);
    h.EdgeColor = cmap(ceil(eps+99.99*(REM_clique_occurance_sorted(k)/length(REM_valid_inds)-min(rates))/range(rates)),:);

end
title('REM co-active netwoks')
colormap(winter);
aa=colorbar;
%aa.XTickLabel={'-12','-9','-6','-3','0','3','6','9','12'}; % 
set(aa,'ticks',0:1);
set(aa,'ticklabels',round(100*[min(rates) max(rates)])/100);
    
%% saving variables
loaded_res=load('G:\Hamed\zf\P1\labled sleep\batch_results_fig4.mat');
res=loaded_res.res;

res(n).bird=fname;
% since, some of the chsnnels are noisy, the detected sub-networks are have the length of the valid_channels. ...
% so we need to map them to 16-channel set. For example when channel 1 is
% noisy, the main_clicques is a matriy with 15 rows, instead of 16, so in
% this case we need to add a zero, to stand for the absence of channel 1
clique_REM=false(16,size(REM_main_cliques,2)); 
clique_REM(valid_chnls,:)=REM_main_cliques;
res(n).REM_main_cliques=clique_REM;

clique_IS=false(16,size(IS_main_cliques,2)); 
clique_IS(valid_chnls,:)=IS_main_cliques;
res(n).IS_main_cliques=clique_IS; 

clique_SWS=false(16,size(SWS_main_cliques,2)); 
clique_SWS(valid_chnls,:)=SWS_main_cliques;
res(n).SWS_main_cliques=clique_SWS; 

res(n).REM_clique_occurance=REM_clique_occurance_sorted;
res(n).IS_clique_occurance=IS_clique_occurance_sorted;
res(n).SWS_clique_occurance=SWS_clique_occurance_sorted;

% saving variables
save subnets_fig
saveas(subnets_fig,['Z:\zoologie\HamedData\CorrelationPaper\Figures\new story\feedback\Fig. 4\sub-networks ' fname '.fig']);
saveas(subnets_fig,['Z:\zoologie\HamedData\CorrelationPaper\Figures\new story\feedback\Fig. 4\sub-networks ' fname '.png']);
saveas(REM_subnet_incidence,['Z:\zoologie\HamedData\CorrelationPaper\Figures\new story\feedback\Fig. 4\REM_subnet_incidence' fname '.png']);
saveas(IS_subnet_incidence,['Z:\zoologie\HamedData\CorrelationPaper\Figures\new story\feedback\Fig. 4\IS_subnet_incidence' fname '.png']);
saveas(SWS_subnet_incidence,['Z:\zoologie\HamedData\CorrelationPaper\Figures\new story\feedback\Fig. 4\SWS_subnet_incidence' fname '.png']);

save('G:\Hamed\zf\P1\labled sleep\batch_results_fig4.mat','res','-nocompression')








