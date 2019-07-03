%% EEG from different times

figure;
tlim=[3600 3660];
t_lim=tlim(1)*fs:tlim(2)*fs;
n=2; % EEG channel  CH5
X=EEG(t_lim,n);
t=time(t_lim);

subplot(4,1,1)
plot(t,X-a(n)*EMG(t_lim));  %% -a(n)*EMG
ylabel(['EEG chnl ' num2str(n)]);  ylim([-200 200]); xlim(tlim)

subplot(4,1,2)
[sst,f] = wsst(X,fs);
contour(t,f,abs(sst));
grid on; ylim([0 2])
xlabel('Time (s)'); ylabel('Hz');

tlim=[5600 5660];
t_lim=tlim(1)*fs:tlim(2)*fs;
X=EEG(t_lim,n);
t=time(t_lim);

subplot(4,1,3)
plot(t,Y);
ylabel(['EEG chnl ' num2str(n)]);  ylim([-200 200]); xlim(tlim)

subplot(4,1,4)
[sst,f] = wsst(X,fs);
contour(t,f,abs(sst));
grid on;ylim([0 2])
xlabel('Time (s)'); ylabel('Hz');