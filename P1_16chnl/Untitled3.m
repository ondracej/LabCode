vid_dir_path='G:\Hamed\zf\P1\73 03\2020-03-09'; %%%%%%%%%% video folder
vid_fname='09_03_2020_00090_converted'; %%%%%%%%%%%% video file name
roi.y=1:500;  roi.x=1:1280; %%%%%%%%%%%%% ROI (starting from top left)
t_on=[8 13 59];
t_off=[0 17 14];
fs=2000;
% Based on the 'default order', enter the chnls
chnl_order=[1 2 3 4 5 6 8 7 10 9 11 12 13 16 14 15];  %%%%%%%%%%%%% recording channels with their ...
image_layout='G:\Hamed\zf\P1\73 03\electrode_placement.jpg';
connectivity_movie_maker(folder_path, t_off, t_on, time, t_frame, ...
    r_dif_med_removed, fs, EEG, image_layout);

[EEG, time, r_dif_med_removed, t_frame] = load_for_connectivity(chnl_order,dir_add, vid_dir_path,vid_fname, roi);
connectivity_movie_maker(folder_path, t_off, t_on, time, t_frame, ...
    r_dif_med_removed, fs, EEG, image_layout)