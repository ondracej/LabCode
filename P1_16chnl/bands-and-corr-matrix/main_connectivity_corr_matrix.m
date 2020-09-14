
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reading the info about recording from meta data file containing a structure called data_info ...
% containing theses fields:

% chnl_order=[1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15];  %%%%%%%%%%%% Based on the 'default order'...
% [1 2 3 4 5 6 8 7 10 9 11 12 13 16 14 15]
% dir_add='G:\Hamed\zf\P1\72-00\18-03-2020'; %%%%%%%%%%%% directory containing .continuous files
% vid_fname='18_03_2020_00097_converted'; %%%%%%%%%%%% video file name
% roi.y=1:1024;  roi.x=1:1280; % ROI (starting from top left)
% t_off=[0 0 1]; % hour min sec
% t_on=[8 4 28];
% fs=2000;
% % position of chnls (nodes)
% xy=round([285 498; 195 541; 223 444; 144 449; 152 372; 201 279; 275 237 ; ...
%           276 304; 403 306; 409 236; 503 285; 545 386; 494 447; 568 458; 410 492; 518 534]*1.24*.3);...
% the coeff is for...
% image_layout='G:\Hamed\zf\P1\72-00\electrode_placement.jpg';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
clear, clc
% adding some dependencies
addpath('D:\github\Lab Code\Respiration VideoAnalysis');
addpath('D:\github\Lab Code\P1_16chnl');
addpath('D:\github\Lab Code\LoadEphys_SWRanalysis');

metadata=load('G:\Hamed\zf\P1\73 03\metadata'); %%%%%%%%%% metadata file

data_info=metadata.data_info; clear metadata
for k= 1:length(data_info)

        % reading variables from metadata file
        chnl_order= data_info(k).chnl_order; %%%%%%%%%%%%
        dir_add= data_info(k).dir_add;
        vid_fname= data_info(k).vid_fname;
        roi= data_info(k).roi;
        t_off= data_info(k).t_off;
        t_on= data_info(k).t_on;
        fs= data_info(k).fs;
        xy= data_info(k).xy;
        image_layout= data_info(k).image_layout; %%%%
        
        % loading EEG and video
        [EEG, time, r_dif, t_frame] = load_for_connectivity(chnl_order,dir_add,...
            vid_fname, roi, fs);
        
        % computing band powers and corr matrix at different bands
        [res.t_bin, res.light_on, res.band_power, res.corr_mat ]=frq_band_and_corr_mat_builder(dir_add, t_off, t_on, fs, EEG, time);
        
        % save results
        [dir_night, ~, ~] = fileparts(dir_add); % directory for saving results
        res.EEG=EEG; clear EEG; res.r_dif=r_dif; clear r_dif
        save([dir_night '\analysis_res'],'res');
        % t_bin is the time point at the center of the bin, light-on is a 0/1 label, indicating ...
        % the state of lights being on/off, band_power is a structure
        % containing power of EEG at different bands, corr_mat is a
        % structure containing the corr_mat off EEG channels filtered at
        % different frequncy bands
        % also output is saved in a file

    disp('processing a night of data completed. Time elapsed: ')
    toc
end