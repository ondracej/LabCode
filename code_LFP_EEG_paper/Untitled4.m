folder_name=['Z:\HamedData\LocalSWPaper\PaperData\' ]; 
mat = dir(fullfile(folder_name,'*.mat'))
for q = 1:length(mat) 
    cont = (mat(q).name)
end