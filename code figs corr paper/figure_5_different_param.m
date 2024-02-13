%% visualization
% number of networks
figure('position',[300 400 500 350])
x = [1-.15 2-.15 3-.15 4-.15     1+.15  2+.15  3+.15 4+.15];
juv_net_numbers=[13.8 10.6 1.8 1.8];
adult_net_numbers=[10.3 7.3 3.3 3.3]; % number of prominent networks for different values of appearence ration (5, 10, or 15)
vals = [juv_net_numbers adult_net_numbers];
b = bar(x,vals,'EdgeColor',[1 1 1]); hold on
title('Number of dominant networks at different levels of appearence ')
xticks([1 2 3]);
xticklabels({'5%', '10%', '15%'})
% adding error bars
vals = [juv_net_numbers adult_net_numbers];
vars = [[8.4 8.6 1.9 1.9]/sqrt(5)   [7.3 4.6 1.1 1.1]/sqrt(3)];
er=errorbar(x,vals,vars);
er.Color = [1 1 1]*.4;                            
er.LineStyle = 'none';  
xlim([.5 3.5])
hold off

%% size of networks
figure('position',[700 400 500 350])
x = [1-.15 2-.15 3-.15 4-.15     1+.15  2+.15  3+.15 4+.15];
juv_net_size=[4.3 4.1 5 5];
adult_net_size=[8.5 8.2 8.6 8.6]; % number of prominent networks for different values of appearence ration (5, 10, or 15)
vals = [juv_net_size adult_net_size];
b = bar(x,vals,'EdgeColor',[1 1 1]); hold on
title('Size of dominant networks at different levels of appearence ')
xticks([1 2 3 4]);
xticklabels({'5%', '10%', '15%', '20%'})
% adding error bars
vals = [juv_net_size adult_net_size];
vars = [[ 1.8 1.9 3.8 3.8 ]/sqrt(5)   [3.1 2.9 3.0 3.0]/sqrt(3)];
er=errorbar(x,vals,vars);
er.Color = [1 1 1]*.4;                            
er.LineStyle = 'none';  
hold off
xlim([.5 3.5])
