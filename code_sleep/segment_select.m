function segment_select(EEG, EMG,time, sr, clear_part);
samps=clear_part(1)*sr+1:clear_part(2)*sr;
figure;
set(gcf,'position',[40 320 1300 350]);
Ylim1=4*median(  abs(EEG(samps))/.67  );
Ylim2=4*median( abs(EMG(samps))/.67 );
plot(time,EEG/Ylim1); xlim(clear_part); set(gca,'XGrid','on'); hold on
plot(time,EMG/Ylim2-3); xlim(clear_part);
ylabel('EMG        EEG'); xlabel('Time (sec)'); ylim([-5 5])
set(gca,'XGrid' , 'on');
end
