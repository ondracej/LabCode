% putting the EEG samples in a matrix of rows corresponding to epoches
fs=30000/downsamp_ratio;
eeg=zeros(floor(3*fs),16,ceil(length(EEG)/floor(3*fs)));
app.current_win=app.t_frames(1)+5; % first window-center app.time
k=1;  
while app.current_win<app.t_frames(end)
indx=find(app.time>(app.current_win-1.5) & app.time<=app.current_win+1.5);
eeg(:,:,k) = EEG(indx(1:floor(3*fs)),:); 
app.current_win=app.current_win+3; % first window-center app.time
if rem(k,100)==0 
    k
end
k=k+1;
end
EEG=eeg(:,:,1:k); clear eeg
