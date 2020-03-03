selpath='G:\Hamed\zf\70-86\2019-05-25'; 

for chn=[2 4]
    eegN=1;
    if chn == [2]
        filename =[selpath '\' '100_CH' num2str(chn) '.continuous'];
        [eeg(:,eegN),~, ~] = load_open_ephys_data(filename);  eegN=eegN+1;
    end
    
    emgN=1;
    if chn == [4]
        filename =[selpath '\' '100_CH' num2str(chn) '.continuous'];
        [emg(:,emgN),time, ~] = load_open_ephys_data(filename); emgN=emgN+1;
    
    end
end