% this is the code for a short movie (3 sec), demonstrating the spread of
% EEG oscillations over the avian pallium in sleeping zebra finch
% It consists of two subplots, the left one shows the EEG waves and the
% right plot depicts the EEG amplitudes color-coded on the scalp and the
% spatial-mean voltage trace
% so first we plot the color-coded EEG traces, then we keep the current samples
% as they are, and cover the rest in gray, to just consentrate on the
% current EEG samples being presented in the right-hand plot.

%% mean traveling wave trajectory
% first computing the smopothed mean trajectory points for plotting the
% 50 recent mean trajectory points with fading shades

% computing of the mean trajectory point at each time point
tic
t_win=86.02*60; % time of the 3-sec EEG window
bin_indx=find(abs(t_bins3sec-t_win)==min(abs(t_bins3sec-t_win)));

clear x_meanl y_meanl x_meanr y_meanr movie_vector
n_sample=size(EEG3sec,1);
for k=1:n_sample
    volt=EEG3sec(k,:,bin_indx);
    x_meanl(k)=volt(1:8)*x(1:8)/sum(volt(1:8));
    y_meanl(k)=volt(1:8)*y(1:8)/sum(volt(1:8));
    x_meanr(k)=volt(9:16)*x(9:16)/sum(volt(9:16));
    y_meanr(k)=volt(9:16)*y(9:16)/sum(volt(9:16));
end

% adding the smoothed trajectory line
% picking the points that are not outlier
n_valid_r=find( (x_meanr<median(x_meanr)+2*iqr(x_meanr) & ...
    x_meanr>median(x_meanr)-2*iqr(x_meanr)) & ...
    (y_meanr<median(y_meanr)+2*iqr(y_meanr) & ...
    y_meanr>median(y_meanr)-2*iqr(y_meanr)) );
n_valid_l=find( (x_meanl<median(x_meanl)+2*iqr(x_meanl) & ...
    x_meanl>median(x_meanl)-2*iqr(x_meanl)) & ...
    (y_meanl<median(y_meanl)+2*iqr(y_meanl) & ...
    y_meanl>median(y_meanl)-2*iqr(y_meanl)) );

% interpolating to find the smoothed fitting
[x_meanr_interp, ~, ~] = fit(n_valid_r',x_meanr(n_valid_r)',...
    'smoothingspline');
[y_meanr_interp, ~, ~] = fit(n_valid_r',y_meanr(n_valid_r)',...
    'smoothingspline');
plot(x_meanr_interp(1:1:n_sample),y_meanr_interp(1:1:n_sample),'linewidth',2);

[x_meanl_interp, ~, ~] = fit(n_valid_l',x_meanl(n_valid_l)',...
    'smoothingspline');
[y_meanl_interp, ~, ~] = fit(n_valid_l',y_meanl(n_valid_l)',...
    'smoothingspline');

% resampling from the interpolated smoothed trajectory
x_traj_l=x_meanl_interp(1:1:n_sample);
y_traj_l=y_meanl_interp(1:1:n_sample);
x_traj_r=x_meanr_interp(1:1:n_sample);
y_traj_r=y_meanr_interp(1:1:n_sample);

%% EEG plot of snapshots of wave spread
fig=figure;
set(gcf, 'Position',1.5*[50 50 500 500]);
% repetative codes, outside of loop:
cmap=hot(256)*.9;
im=imread(image_layout);
im=.6*double(rgb2gray(imresize(im,.3)));
    m=min(EEG3sec(:,:,bin_indx),[],'all');
    r=range(EEG3sec(:,:,bin_indx),'all');
   
for t_samp_ind=1:size(EEG3sec,1)
    clf; % refresh the figure
    s1=subplot(1,4,1);
    hold on
    % plotting the whole EEG in gray, for providing cover for the out-of-focus times
    for k=1:16
        t_=(1:size(EEG3sec,1))/fs;
        y_=EEG3sec(:,k,bin_indx)-.4*(k+floor(k/9));
        plot(t_,y_,'color',.7*[1 1 1],'linewidth',1.5);
        ylab{k}=[num2str(17-k)];
    end
        yticklabels(s1,ylab);

    % color-coded EEG of the current time
    for k=1:16
        EEG_val=EEG3sec(t_samp_ind,k,bin_indx)-.4*k;

        % finding the corresponding color
        all_eeg=EEG3sec(:,:,bin_indx);
        col_ind=min(256,ceil(0.001+256*(EEG_val+.4*k-m)/r));
        plot(t_samp_ind/fs,EEG_val-.4*(floor(k/9)),'.','markersize',20,'markerfacecolor',...
            cmap(col_ind,:), 'markeredgecolor',cmap(col_ind,:));
    end
  xlim(t_samp_ind/fs+[-.250 .250])
      yticks(s1,[-17:1:-10 -8:1:-1]*.4);
    xlabel(s1,'Time (sec)')
    ylim(s1,[ -17*.4-.4 0]); 
    ylabel(s1,' Right  Hemisphere                     Left  Hemisphere ');   
    % snapshot plot
    subplot(1,4,2:4)
    imshow(int8(im)); hold on
    % [x11,y11]=ginput(2);
    
   
    imshow(int8(im));
    hold on
    for ch=1:size(EEG3sec,2)
        volt=EEG3sec(t_samp_ind,ch,bin_indx);
        col_ind=min(256,ceil(.001+256*(volt-m)/r));
        scatter1 = scatter(x(ch),y(ch),800,'o','MarkerFaceColor',...
            cmap(col_ind,:),'MarkerEdgeColor',...
            cmap(col_ind,:),'MarkerFaceAlpha',.7,'MarkerEdgeAlpha',.6);
        text(x(ch),y(ch),num2str(ch));
    end
    text(20,275,['time= ' num2str(round(t_samp_ind*10000/fs)/10) ' ms']);
    
    % plotting the mean trajectory for 50 recent samples
    
    for rec_samp=t_samp_ind:-1:max(t_samp_ind-19,1)
        % 50 current and previous points
        oran=[255 140 0]/255;
        scatter(x_traj_l(rec_samp),y_traj_l(rec_samp),30,'o','MarkerFaceColor',...
            oran,'MarkerEdgeColor',oran,'MarkerFaceAlpha',1-(t_samp_ind-rec_samp)/20,...
        'MarkerEdgeAlpha',1-(t_samp_ind-rec_samp)/20); hold on
            scatter(x_traj_r(rec_samp),y_traj_r(rec_samp),30,'o','MarkerFaceColor',...
            oran,'MarkerEdgeColor',oran,'MarkerFaceAlpha',1-(t_samp_ind-rec_samp)/20,...
        'MarkerEdgeAlpha',1-(t_samp_ind-rec_samp)/20);
    end
    movie_vector(t_samp_ind)=getframe(fig);
end

% save video
my_writer=VideoWriter(['73-03-09-03_time_' num2str(t_win) 'med disincynisation 50x'],...
    'Motion JPEG 2000');
    my_writer.LosslessCompression=true;
    my_video.height=560;
my_writer.FrameRate=round(fs/50); % 50x slower than real time
open(my_writer);
writeVideo(my_writer,movie_vector);
close(my_writer);

toc