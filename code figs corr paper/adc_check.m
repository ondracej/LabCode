downsamp_ratio=1; % must be a power of 2, as the file reader reads blocks of 1024 samples each time
file_div_adc=1000;
ADC=zeros(8,1400000);
for ch=1:8
    ch
    try
    [ ADC(ch,:), ~, ~]=OpenEphys2MAT_load_save_Data(ch, [dir_prefix '_AUX'], downsamp_ratio, file_div_adc,...
    dir_path_ephys);
    catch
        continue;
    end
end