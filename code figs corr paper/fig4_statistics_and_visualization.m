res=load('batch_result_dominant_networks');
nets=res.network_res;
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
for bird=1:length(nets)
rates=[nets(bird).REM_dominant_networks_incidence;...
    nets(bird).IS_dominant_networks_incidence;...
    nets(bird).SWS_dominant_networks_incidence; ];
if isempty(rates)
    continue;
end
incidences=mean(rates,2); % averaging over three nights of the bird

cmap=winter(100);
subnets_fig=figure('Position',[10 200 1800 400]);

% SWS networks
whole_graph=zeros(16);
whole_graph(1:16,1:16)=ones(length(1:16)); % a fully-connected substrate minus the noisy channels
Gcorr = graph(whole_graph,'lower','omitselfloops'); % the main graph containing all the possible edges between each pair of nodes
subplot(1,3,1) % for SWS networks
hold on

% sorting the subnetworks according to their incidence rate
SWS_inc=mean(nets(bird).SWS_dominant_networks_incidence,2);
[B,I] = sort(SWS_inc,'descend');

for k =1:min(9,size(nets(bird).SWS_dominant_networks,2))
    % laying out electrode sites
    x0=(max(xy(:,1))/3)*(rem(k-1,3))-min(xy(:,1))/3; % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    y0=(max(xy(:,2))/3)*floor((k-1)/3)-min(xy(:,2))/3;  % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    for ch=1:16
        scatter1 = scatter(xy(ch,1)/3+x0, xy(ch,2)/3+y0,30,'o','MarkerFaceColor',[.5 .6 .8],...
            'MarkerEdgeColor',.5*[1 1 1],'MarkerFaceAlpha',.3,...
            'MarkerEdgeAlpha',.2);
    end
    
    clique_right_size=false(16,1); % assigning zeroes to the noisy chasnnels, and constructing a 16x1 vector for the subgraph
    clique_right_size(1:16)=nets(bird).SWS_dominant_networks(:,I(k));
    sub=subgraph(Gcorr,clique_right_size);
    h=plot(sub,'EdgeAlpha',.6,'markersize',5,'NodeColor',[1 .6 .5]); hold on
    XData=xy(logical(clique_right_size),1);  YData=xy(logical(clique_right_size),2);
    h.XData=XData/3+x0;      h.YData=YData/3+y0; 
    h.NodeLabel = {};
    h.LineWidth = 2.5;
    axis([-5 max(xy(:,1)) -5 max(xy(:,2))]); axis square; axis ij
    xticks([]);  yticks([]);
    h.EdgeColor = cmap(ceil(eps+99.99*(B(k)-min(incidences))/range(incidences)),:);

end
title('SWS')

% IS networks
whole_graph=zeros(16);
whole_graph(1:16,1:16)=ones(length(1:16)); % a fully-connected substrate minus the noisy channels
Gcorr = graph(whole_graph,'lower','omitselfloops'); % the main graph containing all the possible edges between each pair of nodes
subplot(1,3,2) % for SWS networks
hold on

% sorting the subnetworks according to their incidence rate
IS_inc=mean(nets(bird).IS_dominant_networks_incidence,2);
[B,I] = sort(IS_inc,'descend');

for k =1:min(9,size(nets(bird).IS_dominant_networks,2))
    % laying out electrode sites
    x0=(max(xy(:,1))/3)*(rem(k-1,3))-min(xy(:,1))/3; % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    y0=(max(xy(:,2))/3)*floor((k-1)/3)-min(xy(:,2))/3;  % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    for ch=1:16
        scatter1 = scatter(xy(ch,1)/3+x0, xy(ch,2)/3+y0,30,'o','MarkerFaceColor',[.5 .6 .8],...
            'MarkerEdgeColor',.5*[1 1 1],'MarkerFaceAlpha',.3,...
            'MarkerEdgeAlpha',.2);
    end
    
    clique_right_size=false(16,1); % assigning zeroes to the noisy chasnnels, and constructing a 16x1 vector for the subgraph
    clique_right_size(1:16)=nets(bird).IS_dominant_networks(:,I(k));
    sub=subgraph(Gcorr,clique_right_size);
    h=plot(sub,'EdgeAlpha',.6,'markersize',5,'NodeColor',[1 .6 .5]); hold on
    XData=xy(logical(clique_right_size),1);  YData=xy(logical(clique_right_size),2);
    h.XData=XData/3+x0;      h.YData=YData/3+y0; 
    h.NodeLabel = {};
    h.LineWidth = 2.5;
    axis([-5 max(xy(:,1)) -5 max(xy(:,2))]); axis square; axis ij
    xticks([]);  yticks([]);
    h.EdgeColor = cmap(ceil(eps+99.99*(B(k)-min(incidences))/range(incidences)),:);

end
title([nets(bird).bird_name '   IS'])

whole_graph=zeros(16);
whole_graph(1:16,1:16)=ones(length(1:16)); % a fully-connected substrate minus the noisy channels
Gcorr = graph(whole_graph,'lower','omitselfloops'); % the main graph containing all the possible edges between each pair of nodes
subplot(1,3,3) % for REM networks
hold on

% sorting the subnetworks according to their incidence rate
REM_inc=mean(nets(bird).REM_dominant_networks_incidence,2);
[B,I] = sort(REM_inc,'descend');

for k =1:min(9,size(nets(bird).REM_dominant_networks,2))
    % laying out electrode sites
    x0=(max(xy(:,1))/3)*(rem(k-1,3))-min(xy(:,1))/3; % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    y0=(max(xy(:,2))/3)*floor((k-1)/3)-min(xy(:,2))/3;  % for plotting each sub-network we depict the electrode layout first, scaled for the plot
    for ch=1:16
        scatter1 = scatter(xy(ch,1)/3+x0, xy(ch,2)/3+y0,30,'o','MarkerFaceColor',[.5 .6 .8],...
            'MarkerEdgeColor',.6*[1 1 1],'MarkerFaceAlpha',.3,...
            'MarkerEdgeAlpha',.2);
    end
    
    clique_right_size=false(16,1); % assigning zeroes to the noisy chasnnels, and constructing a 16x1 vector for the subgraph
    clique_right_size(1:16)=nets(bird).REM_dominant_networks(:,I(k));
    sub=subgraph(Gcorr,clique_right_size);
    h=plot(sub,'EdgeAlpha',.6,'markersize',5,'NodeColor',[1 .6 .5]); hold on
    XData=xy(logical(clique_right_size),1);  YData=xy(logical(clique_right_size),2);
    h.XData=XData/3+x0;      h.YData=YData/3+y0; 
    h.NodeLabel = {};
    h.LineWidth = 2.5;
    axis([-5 max(xy(:,1)) -5 max(xy(:,2))]); axis square; axis ij
    xticks([]);  yticks([]);
    h.EdgeColor = cmap(ceil(eps+99.99*(B(k)-min(incidences))/range(incidences)),:);

end
title('REM')
colormap(winter);
aa=colorbar;
%aa.XTickLabel={'-12','-9','-6','-3','0','3','6','9','12'}; % 
set(aa,'ticks',0:1);
set(aa,'ticklabels',round(100*[min(incidences) max(incidences)])/100);

end

%% histogram of number of networks of each size
% making a histogram of the size of dominant networks for each stage for
% adult and juvenile


% for adults 
SWS_adult_size_probabilites=cell(16,1); % initialize the variable that contains the weight of the SWS networks
IS_adult_size_probabilites=cell(16,1); % initialize the variable that contains the weight of the SWS networks
REM_adult_size_probabilites=cell(16,1); % initialize the variable that contains the weight of the SWS networks

for bird=1:3 % for the adults
    % SWS:
    SWS_nets_bird=nets(bird).SWS_dominant_networks;
    if ~isempty(SWS_nets_bird)
        for nn=1:size(SWS_nets_bird,2)
            net_size=sum(SWS_nets_bird(:,nn));
            SWS_adult_size_probabilites{net_size,:}=[SWS_adult_size_probabilites{net_size,:}  nets(bird).SWS_dominant_networks_incidence(nn,:)];
        end
    end
    
    % IS:
    IS_nets_bird=nets(bird).IS_dominant_networks;
    if ~isempty(IS_nets_bird)
        for nn=1:size(IS_nets_bird,2)
            net_size=sum(IS_nets_bird(:,nn));
            IS_adult_size_probabilites{net_size,:}=[IS_adult_size_probabilites{net_size,:}  nets(bird).IS_dominant_networks_incidence(nn,:)];
        end
    end
    
    % REM:
    REM_nets_bird=nets(bird).REM_dominant_networks;
    if ~isempty(REM_nets_bird)
        for nn=1:size(REM_nets_bird,2)
            net_size=sum(REM_nets_bird(:,nn));
            REM_adult_size_probabilites{net_size,:}=[REM_adult_size_probabilites{net_size,:}  nets(bird).REM_dominant_networks_incidence(nn,:)];
        end
    end
end

% for juveniles 
SWS_juvenile_size_probabilites=cell(16,1); % initialize the variable that contains the weight of the SWS networks
IS_juvenile_size_probabilites=cell(16,1); % initialize the variable that contains the weight of the SWS networks
REM_juvenile_size_probabilites=cell(16,1); % initialize the variable that contains the weight of the SWS networks

for bird=4:10 % for the juveniles
    % SWS:
    SWS_nets_bird=nets(bird).SWS_dominant_networks;
    if ~isempty(SWS_nets_bird)
        for nn=1:size(SWS_nets_bird,2)
            net_size=sum(SWS_nets_bird(:,nn));
            SWS_juvenile_size_probabilites{net_size,:}=[SWS_juvenile_size_probabilites{net_size,:}  nets(bird).SWS_dominant_networks_incidence(nn,:)];
        end
    end
    
    % IS:
    IS_nets_bird=nets(bird).IS_dominant_networks;
    if ~isempty(IS_nets_bird)
        for nn=1:size(IS_nets_bird,2)
            net_size=sum(IS_nets_bird(:,nn));
            IS_juvenile_size_probabilites{net_size,:}=[IS_juvenile_size_probabilites{net_size,:}  nets(bird).IS_dominant_networks_incidence(nn,:)];
        end
    end
    
    % REM:
    REM_nets_bird=nets(bird).REM_dominant_networks;
    if ~isempty(REM_nets_bird)
        for nn=1:size(REM_nets_bird,2)
            net_size=sum(REM_nets_bird(:,nn));
            REM_juvenile_size_probabilites{net_size,:}=[REM_juvenile_size_probabilites{net_size,:}  nets(bird).REM_dominant_networks_incidence(nn,:)];
        end
    end
end


%% saving variables
loaded_res=load('G:\Hamed\zf\P1\labled sleep\batch_results_Fig4_pipeline.mat');
res=loaded_res.res;

res(n).experiment=fname(1:11);
% since, some of the chsnnels are noisy, the detected sub-networks are have the length of the valid_channels. ...
% so we need to map them to 16-channel set. For example when channel 1 is
% noisy, the main_clicques is a matriy with 15 rows, instead of 16, so in
% this case we need to add a zero, to stand for the absence of channel 1
clique_REM=false(16,size(REM_main_cliques,2)); 
clique_REM(1:16,:)=REM_main_cliques;
res(n).REM_main_cliques=clique_REM;

clique_IS=false(16,size(IS_main_cliques,2)); 
clique_IS(1:16,:)=IS_main_cliques;
res(n).IS_main_cliques=clique_IS; 

clique_SWS=false(16,size(SWS_main_cliques,2)); 
clique_SWS(1:16,:)=SWS_main_cliques;
res(n).SWS_main_cliques=clique_SWS; 

res(n).REM_clique_occurance=REM_clique_occurance_sorted;
res(n).IS_clique_occurance=IS_clique_occurance_sorted;
res(n).SWS_clique_occurance=SWS_clique_occurance_sorted;

res(n).REM_bins=length(REM_valid_inds);
res(n).IS_bins=length(IS_valid_inds);
res(n).SWS_bins=length(SWS_valid_inds);


save('G:\Hamed\zf\P1\labled sleep\batch_results_Fig4_pipeline.mat','res','-nocompression');








