figure;
Gcorr = graph(true(16),'lower','omitselfloops'); % the main graph containing all the possible edges between each pair of nodes
for k =1:size(SWS_main_cliques,2)
    sub=subgraph(Gcorr,logical(SWS_main_cliques(:,k)));
    h=plot(sub,'EdgeAlpha',.6,'markersize',.8);
    XData=xy(logical(SWS_main_cliques(:,k)),1);  YData=xy(logical(SWS_main_cliques(:,k)),2);
    h.XData=XData;  h.YData=YData;
    h.NodeLabel = {};
    h.LineWidth = 1.5;
end