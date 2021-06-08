function display_eeg_video(current_win, time, EEG, UIEEG, dist)
            
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
            
                        

end