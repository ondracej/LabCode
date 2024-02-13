
% load data

fname='73-03_09_03_scoring';
load(fname);
% image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; %%%%%%%%%%%%%%
% im=imread(image_layout);
% im=.6*double(rgb2gray(imresize(im,.3)));
% imshow(int8(im)); hold on
% [x,y]=ginput(16);
%%
x=  [93
    65
    70
    47
    52
    64
    90
    90
   128
   129
   158
   171
   154
   178
   132
   163];

y=[170
   183
   153
   158
   130
   104
   111
    90
    90
   112
   105
   134
   155
   163
   172
   183];
xy=[x y];
%% EEG signal
bin_indx=9992;
smoother = designfilt('lowpassiir','FilterOrder',4, ...
    'PassbandFrequency',50,'PassbandRipple',0.5, ...
    'SampleRate',fs);

figure
a=hot(100);
cmap=colormap(1*(a(1:70,:)));

% corr matrix
EEG_filt=filtfilt(smoother, EEG3sec(:,:,bin_indx));
eeg_corr_int=zscore(EEG_filt);
c_int=corr(eeg_corr_int,'type','spearman');
% 1st plot, corr matrix
subplot(1,4,1)
imagesc(c_int,[0 1]);axis square, 
xticks([4.5 12.5]); xticklabels({'L' , 'R'});  yticks([4.5 12.5]); yticklabels({'L' , 'R'})
% getting the indexes of colors in the imagesc plot for the graph that will follow
Cindex = ceil(abs(c_int)*length(cmap)); % index for each entry
colorbar
title('1. EEG correlation')
% highly correlated channels
subplot(1,4,2)
s1=c_int>.75; % depict higher correlations
imagesc(s1.*c_int,[0 1]); axis square
xticks([4.5 12.5]); xticklabels({'L' , 'R'});  yticks([4.5 12.5]); yticklabels({'L' , 'R'})
colorbar
title('2. high correlations')
% networks

% % 
% subplot(2,3,4)
% 
% 
% for ch=1:size(EEG3sec,2)
%     scatter1 = scatter(xy(ch,1),xy(ch,2),60,'o','MarkerFaceColor',.3*[1 1 1]);
%     scatter1.MarkerFaceAlpha = .3; scatter1.MarkerEdgeAlpha =.2;
%     hold on
% end
% 
% % for plotting the whole corr matrix as a graph:
% C = graph(c_int,'lower','omitselfloops'); % graph object of c for plotting
% for i=2:length(c_int)
%     for j=1:i-1
%         edgeij=subgraph(C,[i j]);
%         % color for ij edge
%         g=plot(edgeij,'EdgeAlpha',.99, 'EdgeColor',cmap(Cindex(i,j),:),'markersize',.5); hold on
%         g.XData=xy([i j],1);  g.YData=xy([i j],2);
%         g.NodeLabel = {};     g.LineWidth = c_int(j,i)*2;
%     end
% end
% axis tight
% axis equal
% axis off

% 
subplot(1,4,3)


for ch=1:size(EEG3sec,2)
    scatter1 = scatter(xy(ch,1),xy(ch,2),60,'o','MarkerFaceColor',.3*[1 1 1]);
    scatter1.MarkerFaceAlpha = .3; scatter1.MarkerEdgeAlpha =0;
    hold on
end

% for plotting the whole corr matrix as a graph:
C = graph(s1,'lower','omitselfloops'); % graph object of c for plotting
for i=2:length(c_int)
    for j=1:i-1
        edgeij=subgraph(C,[i j]);
        % color for ij edge
        g=plot(edgeij,'EdgeAlpha',.8, 'EdgeColor',cmap(Cindex(i,j),:),'markersize',.5); hold on
        g.XData=xy([i j],1);  g.YData=xy([i j],2);
        g.NodeLabel = {};     g.LineWidth = max(c_int(j,i)*2,eps);
    end
end
axis tight
axis equal
axis off
title('3. Graph representation')
% 4th plot, clusters
subplot(1,4,4)

for ch=1:size(EEG3sec,2)
    scatter1 = scatter(xy(ch,1),xy(ch,2),60,'o','MarkerFaceColor',.3*[1 1 1]);
    scatter1.MarkerFaceAlpha = .3; scatter1.MarkerEdgeAlpha =0;
    hold on
end

s=s1-diag(diag(s1)); % removing self loops
Gcorr = graph(s,'lower','omitselfloops');
[ MC ] = maximalCliques( s ); % extract fully-connected subgrapohs (brain modules)
modules=MC(:,sum(MC)>2);
for k =1:size(modules,2)
    sub=subgraph(Gcorr,logical(modules(:,k)));
    h=plot(sub,'EdgeAlpha',.55,'markersize',.8);
    XData=xy(logical(modules(:,k)),1);  YData=xy(logical(modules(:,k)),2);
    h.XData=XData;  h.YData=YData;
    h.NodeLabel = {};
    h.LineWidth = 2.5;
    
end
axis equal
axis off
axis tight
title('4. dominant networks')