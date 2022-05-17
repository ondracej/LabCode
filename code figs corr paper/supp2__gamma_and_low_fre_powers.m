fig=openfig("Z:\zoologie\HamedData\CorrelationPaper\Figures\new story\Fig_1_Low_and_High.fig");
h = findobj(gca,'Type','line');
x=[h(:).XData];
y=[h(:).YData];
juv_ind=x<180; % indices till 174 belong to the juvenile group 
adult_ind=x>180; % indices till 174 belong to the juvenile group 
y_juv=y(juv_ind);
y_adult=y(adult_ind);
[p,h] = ranksum(y_juv, y_adult)
mean_juv=mean(y_juv)
mean_adult=mean(y_adult)

std_juv=std(y_juv)
std_adult=std(y_adult)

