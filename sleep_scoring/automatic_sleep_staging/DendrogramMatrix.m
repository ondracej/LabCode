% [DC,order,clusters,h]=DendrogramMatrix(C,varargin);
%
% Function purpose : Order matrix according to the hierarchical dendrogram algorithm (Euclidean distance)
%
% Function recives :    C - Correlation matrix
%                       varargin - 
%                           toPlotBinaryTree - if true plots the binary tree (default==0)
%                       
% Function give back : DC - Ordered Correlation matrix
%                      order - the new ordering of rows in the ordered matrix, DC=C(order,order);
%                      clusters - the clusters associated with dendrogram devision (cluster numbers go from top to bottom on the tree)
%
% Recommended usage: [DC,order]=DendrogramMatrix(C);
% To show matrix use : imagesc(DC); or pcolor(DC); - to show grid
function [DC,order,clusters,h]=DendrogramMatrix(C,varargin)
%default options
toPlotBinaryTree=0;
figureHandle=[];
linkMethod='ward';
maxClusters=6;
plotOrderLabels=true;

%% Output list of default variables
%print out default arguments and values if no inputs are given
if nargin==0
    defaultArguments=who;
    for i=1:numel(defaultArguments)
        eval(['defaultArgumentValue=' defaultArguments{i} ';']);
        if numel(defaultArgumentValue)==1
            disp([defaultArguments{i} ' = ' num2str(defaultArgumentValue)]);
        else
            fprintf([defaultArguments{i} ' = ']);
            disp(defaultArgumentValue);
        end
    end
    return;
end

%% Collects all input variables
for i=1:2:length(varargin)
    eval([varargin{i} '=' 'varargin{i+1};'])
end

%% Main code
if isempty(figureHandle)
    figureHandle=figure;
end
if size(C,1)~=size(C,2)
    disp('Analyzing non-square matrix!!!!!!!!!!!!');
    nonSquareMatrix=1;
else
    nonSquareMatrix=0;
    disp('Analyzing square matrix');
end

if any(isnan(C))
    warning('NaN values appear in the activity matrix. This may effect the clustering results!!!');
end
%calculate euclidean distance
Y=pdist(C);
Z=linkage(Y,linkMethod);
%C = cophenet(Z,Y);
%I=inconsistent(Z);
clusters = cluster(Z, 'maxclust',maxClusters);

figure(figureHandle);
h1=subplot(1,3,1);
[h0,T,order] = dendrogram(Z,0,'Orientation','left','colorthreshold',mean(Z(end-maxClusters+1:end-maxClusters+2,3)));
%[h0,T,order] = dendrogram(Z,0,'Orientation','left','ColorThreshold','default');

if ~plotOrderLabels
    h1.YTickLabel=[];
end

[~,IA]=unique(clusters(order));
[~,p]=sort(IA);
clusters=p(clusters);

if nonSquareMatrix
    DC=C(order,:);
else
    DC=C(order,order);
end
if ~toPlotBinaryTree
    close(figureHandle);
    h2=[];cb=[];
else
    set(h1,'YDir','reverse');
    h2=subplot(1,3,2:3);
    imagesc(DC);
    cb=colorbar;
    linkaxes([h1 h2],'y');
end
h=[h1 h2 cb];