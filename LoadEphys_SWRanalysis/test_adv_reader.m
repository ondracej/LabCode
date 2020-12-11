clear
tic 
dir_prefix='133_CH'; %%%%%%%%%%%%%%
 chnl=1;
dir_path_server='Z:\zoologie\HamedData\P1\72-94\07-06-2020\chronic_2020-06-07_20-06-04'; %%%%%%%%
filename =[dir_path_server '\' dir_prefix num2str(chnl) '.continuous'];
downsamp=8;
file_dev=10;
[data, timestamps, ~] = load_open_ephys_data_adv(filename,downsamp,file_dev);
toc