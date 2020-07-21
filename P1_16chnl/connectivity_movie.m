% video of continuous correlation matrix for long period
% we make a directory, and make movies for every 5 min of data (variable patch_time in seconds), then we
% stich them together

% initiation
% name of video file:
tic

add=strsplit(folder_path,filesep);
savename=[add{end-1},' ' ,add{end} ];
stat=mkdir([savename ' connectivity movie']);
t_dark=floor((3/60+20/3600)*1.5*3600 : (7+45/60+16/3600)*1.5*3600); %%%%%%%%%% time of light off/on
save_dir=['D:\github\Lab Code\'  savename ' connectivity movie']; %%%%%%%%%%
% loop for making a video every 30 minutes
vid_num=0; % counter for the video files
patch_time=300;
for t_vid_start=time(1):patch_time:time(end)-patch_time %time(end)-patch_time
    close all; % close previous figures
    figure('Renderer', 'painters', 'Position', [100 100 1300 850])
    vid_num=vid_num+1;
    v = VideoWriter([save_dir '\' savename '-' num2str(vid_num) '.avi'],'Motion JPEG AVI');
    v.FrameRate=4;
    open(v);
    % main loop, for each minute of data
    % now in the loop we load 1 minute of data and add the output of that as a
    % frame to the video
    
    % plotting body movement for the last plot
    subplot(7,2,13:14)
    plot(t_frame/3600,r_dif_med_removed/(10*iqr(r_dif_med_removed)),'color',[.4 .4 1]); xlim([time(1) time(end)]); 
    title('Body Movement'); 
    
    for t_int=t_vid_start:60:t_vid_start+patch_time-60 %  t_interval, taking one minute of data in a loop
        
        % filtering EEG
        [b,a]= butter(2,100/fs);
        EEG_filt=filtfilt(b,a,EEG((t_int-time(1))*fs+1:(t_int+60-time(1))*fs , :));
        eeg_corr_int=zscore(EEG_filt);
        c_int=corr(eeg_corr_int,'type','spearman');
        
        % 1st plot, corr matrix
        subplot(7,2,[1 3])
        imagesc(c_int,[0 1]); colorbar; axis square,  title('Correlation'); cmap=colormap(parula);
        xticks([4.5 12.5]); xticklabels({'L' , 'R'});  yticks([4.5 12.5]); yticklabels({'L' , 'R'})
        % getting the indexes of colors in the imagesc plot for the graph that will follow
        Cindex = ceil(c_int*length(cmap)); % index for each entry 
        
        % 2nd plot, highly correlated chnls
        subplot(7,2,[2 4])
        s1=c_int>.75; % depict higher correlations
        imagesc(s1.*c_int,[0 1]); colorbar; axis square, colormap(parula(ncolor)); title('Corr Coef > 0.75')
        xticks([4.5 12.5]); xticklabels({'L' , 'R'});  yticks([4.5 12.5]); yticklabels({'L' , 'R'})
        
        % 3rd plot,
        subplot(7,2,[5 7 9 11])
        % reading and displaying the layout of electrode placements
        im=imread('G:\Hamed\zf\P1\73 03\electrode_placement.jpg'); %%%%%%%%%
        im=.6*double(rgb2gray(imresize(im,.3)));
        imshow(int8(im)); hold on
        % position of chnls (nodes)
        xy=round([285 498; 195 541; 223 444; 144 449; 152 372; 201 279; 275 237 ; ...
            276 304; 403 306; 409 236; 503 285; 545 386; 494 447; 568 458; 410 492; 518 534]*1*.3); % the coeff is for...
        
        % differenct images (diff birds). Basically electrode sites shall difer
        % just in a scale coefficient:
        % 1.24 for 72-00
        
        % for plotting the whole corr matrix as a graph:
        C = graph(c_int,'lower','omitselfloops'); % graph object of c for plotting
        for i=2:length(c_int)
            for j=1:i-1
                edgeij=subgraph(C,[i j]);
                % color for ij edge
                g=plot(edgeij,'EdgeAlpha',.99, 'EdgeColor',cmap(Cindex(i,j),:),'linewidth',.3,'markersize',.5);
                g.XData=xy([i j],1);  g.YData=xy([i j],2);
                g.NodeLabel = {};     g.LineWidth = 1;
            end
        end
        
        % 4th plot, clusters
        subplot(7,2,[6 8 10 12])
        imshow(int8(im)); hold on
        s=s1-diag(diag(s1)); % removing self loops
        Gcorr = graph(s,'lower','omitselfloops');
        [ MC ] = maximalCliques( s ); % extract fully-connected subgrapohs (brain modules)
        modules=MC(:,sum(MC)>2);
        for k =1:size(modules,2)
            sub=subgraph(Gcorr,logical(modules(:,k)));
            h=plot(sub,'EdgeAlpha',.6,'markersize',.8);
            XData=xy(logical(modules(:,k)),1);  YData=xy(logical(modules(:,k)),2);
            h.XData=XData;  h.YData=YData;
            h.NodeLabel = {};
            h.LineWidth = 1.5;
            
        end
        
        subplot(7,2,13:14)
        % the lines indicating the lights-off, time of the calculation of corr
        % matix, and lights-on time
        line([ t_dark(1)+t_frames(1) t_dark(1)+t_frames(1)]/3600,[0 1],'color','k','linewidth' , 2);
        line([t_int t_int]/3600,[0 .1],'linewidth' , 1,'color','r');
        line([t_dark(end)+t_frames(1) t_dark(end)+t_frames(1)]/3600,[0 1],'color','y','linewidth' , 2);
        xlim([0 time(end)]/3600);      ylim([0 1]);    xlabel('Time (h)')
        yticks([]);
        [xtick_sorted,xtick_ind]=sort([ (t_dark(1)+t_frames(1))/3600 2:2:12 (t_dark(end)+t_frames(1))/3600]);
        xticklabel={'light OFF', '2','4','6','8','10', '','light ON' };
        xticks(xtick_sorted);
        xticklabels(xticklabel(xtick_ind));
        %     drawnow;
        h=getframe(gcf);
        writeVideo(v,h);
        
    end
    close(v)
end

%% loading the small files and patch them together
% initiation for thew final big file
big_vid_obj = VideoWriter([save_dir '\' savename  '.avi'],'Motion JPEG AVI');
big_vid_obj.FrameRate=6;
open(big_vid_obj);

n_files=size(dir([save_dir '/*.AVI']),1); % number of small files
for vid_num=1:n_files-1 % for number of small files
    small_vid_obj = VideoReader([save_dir '\' savename '-' num2str(vid_num) '.avi']);
    
    % Read all the frames from the video, one frame at a time.
    while hasFrame(small_vid_obj)
        frame = readFrame(small_vid_obj);
        writeVideo(big_vid_obj,frame);
    end
end
close(big_vid_obj);

toc

