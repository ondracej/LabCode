% clustering sleep features
% we try different methods in each cell

% pca 
[coeff,score,latent] = pca(featsn);
x=score(:,1:6);
% scatter plot of PCs
figure
scatter3(x(:,1),x(:,2),x(:,3),'r.');

% specific ratios
delta=featsn(:,1); 
theta=featsn(:,5);
alpha=featsn(:,9);
beta=featsn(:,13);
gamma=featsn(:,17);
f1=filloutliers(delta./theta,'nearest',1,'ThresholdFactor',100); % Delta over Theta, outliers are removed
f2=filloutliers(alpha./gamma,'nearest',1,'ThresholdFactor',100); % Alpha over Gamma, outliers are removed
f3=filloutliers(featsn(:,end),'nearest',1,'ThresholdFactor',100); % EMG power
xx=zscore([ f1 f2 f3 ]);
figure
scatter3(xx(:,1),xx(:,2),xx(:,3),'r.');

[coeff,score,latent] = pca(xx);
x=score(:,1:3);
figure
scatter3(x(:,1),x(:,2),x(:,3),'r.');
%%
n_clusters=3;
[center,U] = fcm(x, n_clusters);

% plot PCAs data points after clustering
plot(fcmdata(index1,1),fcmdata(index1,2),'ob')
hold on
plot(fcmdata(index2,1),fcmdata(index2,2),'or')
plot(centers(1,1),centers(1,2),'xb','MarkerSize',15,'LineWidth',3)
plot(centers(2,1),centers(2,2),'xr','MarkerSize',15,'LineWidth',3)
hold off

