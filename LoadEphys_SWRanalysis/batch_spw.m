% bach processing for all files of an experiment
clear;
cd('D:\Janie\ZF-60-88');
Files=dir('*exp*');
for ii=1:size(Files,1)
    close all
    selpath=[Files(ii).folder '\' Files(ii).name];
    swr_analysis(selpath);
end