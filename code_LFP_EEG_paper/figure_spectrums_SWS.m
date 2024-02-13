% spectrogram of SWS across all channels
data_folder='Z:\HamedData\LocalSWPaper\PaperData';
fs=30000/64;
figure('position',[300 400 1400 350]);
bird_name={'w044','w042','w027','w025'};
bird_symbol={'\diamondsuit','+','\circ','\times'};
for k=1:4 % for the 4 birds
    
subplot(1,4,k); %%%%%%%%
bird=bird_name{k}; %%%%%
fname=[bird '_stage_len_LFP_']; %%%%%
file_address=[data_folder '\' fname '.mat'];
line_style='.k'; %%%%
line_color=[.4 .4 1]; %%%%%
load_an_plot_pxx(file_address,fs,line_style,line_color);

fname=[bird '_stage_len_l_a_']; %%%%%
file_address=[data_folder '\' fname '.mat'];
line_style='-k'; %%%%
line_color=0*[.4 .4 1]; %%%%%
load_an_plot_pxx(file_address,fs,line_style,line_color);

fname=[bird '_stage_len_r_a_']; %%%%%
file_address=[data_folder '\' fname '.mat'];
line_style='--k'; %%%%
line_color=0*[.4 .4 1]; %%%%%
load_an_plot_pxx(file_address,fs,line_style,line_color);

fname=[bird '_stage_len_r_p_']; %%%%%
file_address=[data_folder '\' fname '.mat'];
line_style=':k'; %%%%
line_color=0*[.4 .4 1]; %%%%%
load_an_plot_pxx(file_address,fs,line_style,line_color);

if ~strcmp(bird,'w042')
fname=[bird '_stage_len_l_p_']; %%%%%
file_address=[data_folder '\' fname '.mat'];
line_style='-.k'; %%%%
line_color=1*[.4 .4 1]; %%%%%
load_an_plot_pxx(file_address,fs,line_style,line_color);
end

%%%%%%%
title(bird_symbol{k});
 xlim([0 10])
ylim([-28 -5])
xlabel('Frequency (Hz)')
if k==1
ylabel({'SWS Relative PSD'; '(dB/Hz)'})
end
end
legend('DVR','L ant','R ant','R post','L post');

