% SOM structure formation
x=featsn';
net = selforgmap([12 12]);
view(net)
% training 
[net,tr] = train(net,x);
nntraintool
% test (on the same data)
y = net(x);
cluster_index = vec2ind(y);
% topology map
plotsomtop(net)
% plotsomhits calculates the classes for each flower and shows the number of flowers in each class. Areas of neurons with large numbers of hits indicate ...
% classes representing similar highly populated regions of the feature space.
plotsomhits(net,x)
% plotsomnc shows the neuron neighbor connections. Neighbors typically classify similar samples.
plotsomnc(net)
% plotsomplanes shows a weight plane for each of the four input features. They are visualizations of the weights that connect each input to each of the ...
% 64 neurons in the 8x8 hexagonal grid. Darker colors represent larger weights. If two inputs have similar weight planes (their color gradients may be ...
% the same or in reverse) it indicates they are highly correlated.
plotsomplanes(net)
