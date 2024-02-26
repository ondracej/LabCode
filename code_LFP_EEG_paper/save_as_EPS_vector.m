clc
folder_path='Z:\HamedData\LocalSWPaper\RevisionUpdates\DeltaOverGamma'; %%%%%%%%%%
file_name='dg_diff_w027_zoomed'; %%%%%%%%%%%
openfig([folder_path '\' file_name '.fig'])
set(gcf,'renderer','Painters')
print([folder_path '\' file_name '.eps'],'-depsc')

