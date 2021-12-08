figure
x = randn(1,15);
y = sin(x/2);
err = 0.3*ones(size(y));
errorbar(x,y,err,'s','MarkerSize',.1,...
    'MarkerEdgeColor','red','MarkerFaceColor','red')