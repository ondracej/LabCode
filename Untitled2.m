im=imread('G:\Hamed\zf\73 03\electrode_placement.jpg');
im=.5*double(rgb2gray(im));
figure,
imshow(int8(im)); hold on
% position of chnls (nodes)
xy_chnl=[285 498; 195 541; 223 444; 144 449; 152 372; 201 279; 275 237 ; ...
    276 304; 403 306; 409 236; 503 285; 545 386; 494 447; 410 492; 518 534; 568 458];
xy=xy_chnl(chnl_order,:);
% plot the whole graph
% totNet = graph(c,'lower','omitselfloops');
% h=plot(totNet,'EdgeAlpha',.3,'LineWidth',2); 
% XData=xy(:,1);  YData=xy(:,2);
% h.XData=xy(:,1);  h.YData=xy(:,2);
% h.NodeLabel = {};  

% for plotting the whole corr matrix as a graph:
vals_in_s=c(logical(tril(c,-1))); % extract all the nonrepetative values in c
sorted_col=sort(vals_in_s); % sorting colors in the co9lor map to find the location of each edge in the corr matrix
for i=2:length(c)
    for j=1:i-1
        edgeij=subgraph(C,[i j]);
        % color for ij edge
        g=plot(edgeij,'EdgeAlpha',.5, 'EdgeColor',cmap(cmap(c(i,j)==sorted_col,:)));
    g.XData=xy([i j],1);  g.YData=xy([i j],2);
    g.NodeLabel = {};     g.LineWidth = 7;
    
    end 
end