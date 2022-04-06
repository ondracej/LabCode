clc
folder_path='Z:\zoologie\HamedData\CorrelationPaper\Figures\new parts 2022\Fig 5 network analysis\Fig. 5 A (Process illustration)'; %%%%%%%%%%
file_name='process'; %%%%%%%%%%%
openfig([folder_path '\' file_name '.fig'])
set(gcf,'renderer','Painters')
print([folder_path '\' file_name '.eps'],'-depsc')

