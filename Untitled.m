file_dev=1000;
figure
for k=1:8
[ ADC(k,:), ~, ~]=OpenEphys2MAT_load_save_Data(k, [dir_prefix '_ADC'], 1, file_dev,...
    dir_path_ephys);
plot(ADC(k,1:1000000)+k*.5); hold on
end