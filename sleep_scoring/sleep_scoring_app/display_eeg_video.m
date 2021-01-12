function [r_dif]=display_eeg_video(current_win, time, EEG, UIEEG, dist, t_frames, frames, vid,...
    roi_y, roi_x, UIVideo)
            
            t_plot_lim=[current_win-4.5 current_win+4.5];  % app.time for plotting
            t_plot_ind=(time>t_plot_lim(1) & time<t_plot_lim(2));
            t_plot=time(t_plot_ind);
            EEG_plot=EEG(t_plot_ind,:);        
            for chnl=1:size(EEG_plot,2)
                plot(UIEEG,t_plot,EEG_plot(:,chnl)+chnl*dist);
                hold(UIEEG,"on");
            end
            xlim(UIEEG,t_plot_lim);
            gray= [127 127 127]./255;
            area(UIEEG,[t_plot_lim(1) t_plot_lim(1)+3] ,(chnl+1)*dist*[1 1],'basevalue',0,'FaceColor',gray,...
                'LineStyle','none','FaceAlpha',.5);
            area(UIEEG,[t_plot_lim(end)-3 t_plot_lim(end)] ,(chnl+1)*dist*[1 1],'basevalue',0,'FaceColor',gray,...
                'LineStyle','none','FaceAlpha',.5);
            hold(UIEEG,"off");
            ylim(UIEEG, [0 (chnl+1)*dist]);
            xticks(UIEEG,t_plot_lim(1):3:t_plot_lim(2));
            xticklabels(UIEEG,round((t_plot_lim(1):3:t_plot_lim(2))*10)/10);
            
                        
            % display video
            win_frames=frames(t_frames>(t_plot_lim(1)+3) & t_frames<(t_plot_lim(2)-3));
            [r_dif,acc_dif, last_im, ~] = birdvid_move_extract_app_obj(vid,win_frames,roi_y,roi_x);
            faint_im1=.8*last_im+20; % mapping to confinding the pixel intensities to 200-250 instead of full range (0-255)
            acc_difim = cat(3, faint_im1-.2*acc_dif, faint_im1-.2*acc_dif, faint_im1+.3*acc_dif); % the difference just depics in Red
            % imshow(uint8(acc_difim), 'parent', app.UIVideo);
            imshow(uint8(acc_difim), 'Parent', UIVideo);
end