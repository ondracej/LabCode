
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reading the info about recording from meta data file, e. g. :

% chnl_order=[1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15];  %%%%%%%%%%%% Based on the 'default order' [1 2 3 4 5 6 8 7 10 9 11 12 13 16 14 15]
% dir_add='G:\Hamed\zf\P1\72-00\18-03-2020'; %%%%%%%%%%%% directory containing .continuous files
% vid_fname='18_03_2020_00097_converted'; %%%%%%%%%%%% video file name
% roi.y=1:1024;  roi.x=1:1280; % ROI (starting from top left)
% t_off=[0 0 1]; % hour min sec
% t_on=[8 4 28];
% fs=2000;
% % position of chnls (nodes)
% xy=round([285 498; 195 541; 223 444; 144 449; 152 372; 201 279; 275 237 ; ...
%           276 304; 403 306; 409 236; 503 285; 545 386; 494 447; 568 458; 410 492; 518 534]*1.24*.3); % the coeff is for...
% image_layout='G:\Hamed\zf\P1\72-00\electrode_placement.jpg';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
clear, clc
metadata=load('Z:\zoologie\HamedData\P1\72-00\metadata'); %%%%%%%%%
data_info=metadata.data_info; clear metadata
for k= 1:length(data_info)
     try % in case there was an eror in reading a specific file, the code goes on to the nxt recording night
        
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
        [EEG, time, r_dif_med_removed, t_frame] = load_for_connectivity(chnl_order,dir_add,vid_fname, roi, fs);
        
        % doing the connectivity computation and making the movie
        connectivity_movie_maker(dir_add, t_off, t_on, fs, image_layout, xy, EEG, time, r_dif_med_removed, t_frame);
       
    catch
        disp(['There was an error reading data in data: ' data_info.date] );
    end
    disp('processing a night data set completed. Time elapsed: ')
    toc
end