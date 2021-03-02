function [conn_mat_, conn_mat] = extract_network(EEG_epochs, edge_probab, image_layout, xy, titl)
% 4 subplots for the corr matrix, the highly correlated nodes on the corr
% matrix, the network, and the sub newtworks
conn_mat_=zeros(size(EEG_epochs,2),size(EEG_epochs,2),size(EEG_epochs,3));
% computing the temporal correlation matrix for each epoch and the network
for k=1:size(EEG_epochs,3)
    [conn_mat_(:,:,k),~,~,~] = infer_network_correlation_analytic(EEG_epochs(:,:,k));
end
conn_mat=mean(conn_mat_,3)+diag(ones(1,size(conn_mat_,1)));

figure
subplot(2,2,1)
% 2nd plot, highly correlated chnls
imagesc(conn_mat,[0 1]); colorbar; axis square, colormap(parula); title([titl ' average connectivity'])
xticks([4.5 12.5]); xticklabels({'L' , 'R'});  yticks([4.5 12.5]); yticklabels({'L' , 'R'})
% getting the indexes of colors in the imagesc plot for the graph that will follow
cmap=colormap(parula);
Cindex = ceil(abs(conn_mat)*length(cmap)); % index for each entry

subplot(2,2,2)
imagesc(conn_mat>edge_probab,[0 1]); colorbar; axis square, 
title([num2str(edge_probab) ' probability connectivity']) 
xticks([4.5 12.5]); xticklabels({'L' , 'R'});  yticks([4.5 12.5]); yticklabels({'L' , 'R'})

subplot(2,2,3)
% reading and displaying the layout of electrode placements
im=imread(image_layout); %%%%%%%%%
im=.6*double(rgb2gray(imresize(im,.3)));
imshow(int8(im)); hold on
% for plotting the whole corr matrix as a graph:
C = graph(conn_mat,'lower','omitselfloops'); % graph object of c for plotting
for i=2:length(conn_mat)
    for j=1:i-1
        edgeij=subgraph(C,[i j]);
        % color for ij edge
        g=plot(edgeij,'EdgeAlpha',.99, 'EdgeColor',cmap(Cindex(i,j),:),'linewidth',.3,'markersize',.5);
        g.XData=xy([i j],1);  g.YData=xy([i j],2);
        g.NodeLabel = {};     g.LineWidth = 1;
    end
end

subplot(2,2,4)
% 4th plot, clusters
imshow(int8(im)); hold on
s=mean(conn_mat_,3)>edge_probab; % removing self loops
Gcorr = graph(s,'lower','omitselfloops');
[ MC ] = maximalCliques( s ); % extract fully-connected subgrapohs (brain modules)
modules=MC(:,sum(MC)>1);
for k =1:size(modules,2)
    sub=subgraph(Gcorr,logical(modules(:,k)));
    h=plot(sub,'EdgeAlpha',.6,'markersize',.8);
    XData=xy(logical(modules(:,k)),1);  YData=xy(logical(modules(:,k)),2);
    h.XData=XData;  h.YData=YData;
    h.NodeLabel = {};
    h.LineWidth = 1.5;
    
end

end