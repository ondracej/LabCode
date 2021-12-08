loaded_res=load('G:\Hamed\zf\P1\labled sleep\batch_results3.mat');
res=loaded_res.res;
LH_local_wave_corr=corrcoef(LH(valid_inds),local_wave(valid_inds));
res(n).bird=fname;
res(n).corr_local_wave_and_depth=LH_local_wave_corr(1,2); % the cross-correlation
res(n).local_wave_perSec_perChnl=sum(local_wave_per_chnl(:))/((length(valid_inds)*3)*length(valid_chnls)); 
res(n).local_wave_perSec_perChnl_se=std(sum(local_wave_per_chnl,1)/(3*length(valid_chnls))) / sqrt(length(valid_inds));

% sum of number of local waves corrected for the number of sleep-time bins
% and non-noisy channels
res(n).median_LH=median_LH;
res(n).iqr_LH=iqr_LH;
res(n).se_LH=se_LH;
res(n).LLRRLR_corr_REM=LLRRLR_corr_REM;
res(n).LLRRLR_corr_IS=LLRRLR_corr_IS;
res(n).LLRRLR_corr_SWS=LLRRLR_corr_SWS;
res(n).LLRRLR_corr_REM_ste=LLRRLR_corr_REM_ste;
res(n).LLRRLR_corr_IS_ste=LLRRLR_corr_IS_ste;
res(n).LLRRLR_corr_SWS_ste=LLRRLR_corr_SWS_ste;