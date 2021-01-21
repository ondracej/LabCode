function createfigure(data1, data2, XData1, YData1)
%CREATEFIGURE(data1, data2, XData1, YData1)
%  DATA1:  histogram data
%  DATA2:  histogram data
%  XDATA1:  line xdata
%  YDATA1:  line ydata

%  Auto-generated by MATLAB on 20-Jan-2021 13:12:01

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create histogram
histogram(data1,'DisplayName','Wake','Parent',axes1,'FaceAlpha',0.8,...
    'EdgeColor',[0 0 1],...
    'NumBins',160, 'Normalization', 'Probability');

% Create histogram
histogram(data2,'DisplayName','REM','Parent',axes1,'FaceAlpha',0.7,...
    'EdgeColor',[1 0 0],...
    'BinWidth',36, 'Normalization', 'Probability');

% Create line
line(XData1,YData1,'DisplayName','threshold','Parent',axes1,...
    'LineStyle','--');

% Create xlabel
xlabel({'Movement (pixel intensity change)'});

% Create title
title({'deferentiation between Wake and REM via body movement'});

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[1109.00817610063 5334.95283018868]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 185]);
box(axes1,'on');
% Create legend
legend(axes1,'show');

% Create textbox
annotation(figure1,'textbox',...
    [0.221451527224435 0.804761904761905 0.115865869853918 0.116666666666669],...
    'String',{'83% of Wake'},...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.128818061088977 0.800000000000001 0.131474103585657 0.121428571428573],...
    'String',{'95%','of REM'},...
    'FitBoxToText','off',...
    'EdgeColor','none');

