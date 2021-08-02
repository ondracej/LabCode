function [h]=multicolorloine(x,y,varargin)

% c is a vector, containing values corresponding to color:
c=varargin{1};

% cr is a 2 entry-vector, first value is the value of y corresponding to lowest color, and
% the 2nd value associated to the value of y associated with highest color:
cr=varargin{2};

cmap=varargin{3}; % color map: jet, parula, ... or any other
numpoints=numel(x);
% making an index out of c for the cmap
cn=(c-cr(1))/(cr(2)-cr(1));
cn=ceil(cn*size(cmap,1));
cn=max(cn,1);
cn=min(cn,256);

n=nargin;
switch n-2
    case 4
        linewidth=varargin{4};
        for i=1:numpoints-1
            h=line(x(i:i+1), y(i:i+1), 'color', cmap(cn(i),:),'LineWidth',linewidth);
        end
    case 5
        linewidth=varargin{4};
        marker_type=varargin{5};
        for i=1:numpoints-1
            h=line(x(i:i+1), y(i:i+1), 'color', cmap(cn(i),:),'LineWidth',linewidth,...
                'marker',marker_type);
        end
    case 6
        linewidth=varargin{4};
        marker_type=varargin{5};
        line_style=varargin{6};
        for i=1:numpoints-1
            h=line(x(i:i+1), y(i:i+1), 'color', cmap(cn(i),:),'LineWidth',linewidth,...
                'marker',marker_type,'linestyle',line_style);
        end
    case 7
        linewidth=varargin{4};
        marker_type=varargin{5};
        line_style=varargin{6};
        marker_size=varargin{7};
        for i=1:numpoints-1
            h=line(x(i:i+1), y(i:i+1), 'color', cmap(cn(i),:),'LineWidth',linewidth,...
                'marker',marker_type,'linestyle',line_style,'markersize',marker_size);
        end
    otherwise
        error('wrong number of inputs');
end


