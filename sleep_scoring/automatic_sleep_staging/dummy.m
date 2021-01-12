figure    
Y = tsne(eeg_sel(:,1:1000)','Perplexity',700);
g=gscatter(Y(:,1),Y(:,2),label(1:1000),colors,'.',10*ones(1,4)); % (x,y,g,clr,sym,siz) color clr, symbol sym, and size siz for each group.
