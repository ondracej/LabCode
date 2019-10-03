% bach processing for all files of an experiment
clear;
cd('D:\Janie\ZF-59-15');
Files=dir('*exp*');
for ii=1:size(Files,1)
    close all
    selpath=[Files(ii).folder '\' Files(ii).name];
    swr_analysis_fun(selpath);
end