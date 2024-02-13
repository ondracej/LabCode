function [] = load_an_plot_pxx(file_address,fs,line_style,line_color)

load(file_address);
% compute PSD
all_bins=wave_binned(2:end-1,:);
valid_bins=all_bins(valid_bin_inds,:);
stage_bins=valid_bins(strcmp(bin_label,'SWS'),:);

% compute and plot PSD
[pxx_,f] = pwelch(zscore(stage_bins'),round(2*fs),round(1.5*fs),2^nextpow2(fs),fs);
pxx=10*log10(pxx_)';
shadedErrorBar(f,pxx,{@mean,@(pxx) 1.96*std(pxx)/sqrt(size(pxx,2))},...
    'lineprops',{line_style,'color',line_color}, 'transparent',true,'patchSaturation',0.15); hold on
end

