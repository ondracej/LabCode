
plotDir = 'C:\Users\Janie\Dropbox\tmp\';
figure(1)
saveName = [plotDir 'test'];
plotpos = [0 0 15 10];
%print_in_A4(page_format, absolute_filename, export_to, restype, pos)
print_in_A4(0, saveName, '-djpeg', 0, plotpos);
print_in_A4(0, saveName, '-depsc', 0, plotpos);