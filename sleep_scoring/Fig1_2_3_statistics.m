data=load('G:\Hamed\zf\P1\labled sleep\batch_results1'); % the file containing the batch result of all birds
sleep_vars=data.res; % the variable containing the results

bird_names={'72-00','73-03','72-94','w0009','w0016','w0018','w0020','w0021'};
bird_symbols={'o','<','>','+','*','x','s','d'};
col=.9*rand(8,3);

%  extracting the ID for each bird (1 to 8)
for bird_n=1:length(sleep_vars)
    % finding the name of the bird
    bird_name_long=sleep_vars(bird_n).bird; % like 72-94_08_09_2021
    bird_name=bird_name_long(1:5); % like 72-94
    
    % finding the bird index (1 to 8)
    for i=1:length(bird_names)
        if strcmp(bird_names{i},bird_name)
            bird_id(bird_n)=i;
            break
        end
    end
end

% figure for the mean of depth variable
figure;
for bird_n=1:length(sleep_vars)
    % plotting
    i=bird_id(bird_n);
    if i<=3 % for adults
        plot( 1+.1*randn(1),sleep_vars(bird_n).median_LH,'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',2); hold on
    else  % for juveniles
        plot(0+.1*randn(1),sleep_vars(bird_n).median_LH,'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',2); hold on
    end
end
ylim([0 55]);  xlim([-.5 1.5]);
xticks([0 1]);  xticklabels({'Juveniles','Adults'});
title('Sleep depth index across nights');

%%
% figure for the mean local wave incidence
figure;
for bird_n=1:length(sleep_vars)
    % plotting
    i=bird_id(bird_n);
    if i<=3 % for adults
        plot( 1+.07*randn(1),sleep_vars(bird_n).local_wave_perSec_perChnl,'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',2); hold on
    else  % for juveniles
        plot(0+.07*randn(1),sleep_vars(bird_n).local_wave_perSec_perChnl,'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',2); hold on
    end
end
ylim([0.1 0.9]);  xlim([-.5 1.5]);
xticks([0 1]);  xticklabels({'Juveniles','Adults'});
title('local wave incidence across nights');
%%
% statistics for figure 1,2, and 3
% statistical test for the median of sleep-depth variable
juv_inds=bird_id==4 | bird_id==5 | bird_id==6 | bird_id==8 ; % index to bird_id for juveniles
adu_inds=bird_id==1 | bird_id==2 | bird_id==3  ; % index to bird_id for juveniles
mean_median_depth_juv=median([sleep_vars(juv_inds).median_LH])
mean_median_depth_adult=median([sleep_vars(adu_inds).median_LH])

iqr_median_depth_juv=iqr([sleep_vars(juv_inds).median_LH])
iqr_median_depth_adult=iqr([sleep_vars(adu_inds).median_LH])

mean_local_wave_juv=median([sleep_vars(juv_inds).local_wave_perSec_perChnl])
mean_local_wave_adu=median([sleep_vars(adu_inds).local_wave_perSec_perChnl])
% statistical test between adult and juvenile group
[p,h]=ranksum( [sleep_vars(juv_inds).local_wave_perSec_perChnl], [sleep_vars(adu_inds).local_wave_perSec_perChnl] )
[p,h]=ranksum( [sleep_vars(juv_inds).median_LH], [sleep_vars(adu_inds).median_LH] )

mean_corr_local_wave_and_depth_juv=median([sleep_vars(juv_inds).corr_local_wave_and_depth])
mean_corr_local_wave_and_depth_adu=median([sleep_vars(adu_inds).corr_local_wave_and_depth])

iqr_corr_local_wave_and_depth_juv=iqr([sleep_vars(juv_inds).corr_local_wave_and_depth])
iqr_corr_local_wave_and_depth_adu=iqr([sleep_vars(adu_inds).corr_local_wave_and_depth])

%%  plot of the inter/intra-hemispheric correlations during different stages in adult group
% for the adult
figure; 
for bird_n=1:length(sleep_vars)
    % plotting
    i=bird_id(bird_n);
    if i<=3 % for adults
        
        % LL corr
        subplot(1,3,1) %  SWS
        plot( 0+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_SWS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  IS
        plot( 1+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_IS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  REM
        plot( 2+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_REM(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([-.15 .951]); xlim([-.5 2.5]);
        xticks([0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Adult L-L EEG corr');
        
        % RR corr
        subplot(1,3,2) %  SWS
        plot( 0+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_SWS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  IS
        plot( 1+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_IS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  REM
        plot( 2+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_REM(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([-.15 .95]); xlim([-.5 2.5]);
        xticks([0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Adult R-R EEG corr');
        
        % RL corr
        subplot(1,3,3) %  SWS
        plot( 0+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_SWS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  IS
        plot( 1+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_IS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  REM
        plot( 2+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_REM(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([-.15 .95]); xlim([-.5 2.5]);
        xticks([0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Adult R-L EEG corr');
        
    end
end

% for the juveniles
figure; 
for bird_n=1:length(sleep_vars)
    % plotting
    i=bird_id(bird_n);
    if i>3 % for adults
        
        % LL corr
        subplot(1,3,1) %  SWS
        plot( 0+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_SWS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  IS
        plot( 1+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_IS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  REM
        plot( 2+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_REM(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([-.15 .95]); xlim([-.5 2.5]);
        xticks([0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Juvenile L-L EEG corr');
        
        % RR corr
        subplot(1,3,2) %  SWS
        plot( 0+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_SWS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  IS
        plot( 1+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_IS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  REM
        plot( 2+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_REM(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([-.15 .95]); xlim([-.5 2.5]);
        xticks([0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Juvenile R-R EEG corr');
        
        % RL corr
        subplot(1,3,3) %  SWS
        plot( 0+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_SWS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  IS
        plot( 1+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_IS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  REM
        plot( 2+.1*randn(1),sleep_vars(bird_n).LLRRLR_corr_REM(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([-.15 .9501]); xlim([-.5 2.5]);
        xticks([0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Juvenile R-L EEG corr');
        
    end
end

%% statistical tests for figure 3: connectivities across the hemispheres 

% 2-way ANOVA for the difference in connectivity across the hemispheres
% row factor is sleep stage (SWS, IS, REM), the column factor is
% hemispheric side for connectivity (LL, RR, LR)
% for adult
% formatting data for anova2
corr_SWS=[sleep_vars(adu_inds).LLRRLR_corr_SWS];
corr_IS=[sleep_vars(adu_inds).LLRRLR_corr_IS];
corr_REM=[sleep_vars(adu_inds).LLRRLR_corr_REM];

anova_input=[corr_SWS(1:3:end)',...
    corr_SWS(2:3:end)',...
    corr_SWS(3:3:end)';...
    corr_IS(1:3:end)',...
    corr_IS(2:3:end)',...
    corr_IS(3:3:end)';...
    corr_REM(1:3:end)',...
    corr_REM(2:3:end)',...
    corr_REM(3:3:end)'];

[~,~,stats] = anova2(anova_input,sum(adu_inds));
c = multcompare(stats)

% for juveniles
% formatting data for anova2
corr_SWS=[sleep_vars(juv_inds).LLRRLR_corr_SWS];
corr_IS=[sleep_vars(juv_inds).LLRRLR_corr_IS];
corr_REM=[sleep_vars(juv_inds).LLRRLR_corr_REM];

anova_input=[corr_SWS(1:3:end)',...
    corr_SWS(2:3:end)',...
    corr_SWS(3:3:end)';...
    corr_IS(1:3:end)',...
    corr_IS(2:3:end)',...
    corr_IS(3:3:end)';...
    corr_REM(1:3:end)',...
    corr_REM(2:3:end)',...
    corr_REM(3:3:end)'];

[~,~,stats] = anova2(anova_input,sum(juv_inds));
c = multcompare(stats)

%% ANOVA2 for checking a possible significant difference in connectivity across the stages
% for adult
% reformatting data for anova2
corr_SWS=[sleep_vars(adu_inds).LLRRLR_corr_SWS];
corr_IS=[sleep_vars(adu_inds).LLRRLR_corr_IS];
corr_REM=[sleep_vars(adu_inds).LLRRLR_corr_REM];

anova_input=[
    corr_SWS(1:3:end),...
    corr_SWS(2:3:end),...
    corr_SWS(3:3:end);...
    corr_IS(1:3:end),...
    corr_IS(2:3:end),...
    corr_IS(3:3:end);...
    corr_REM(1:3:end),...
    corr_REM(2:3:end),...
    corr_REM(3:3:end)]';

[~,~,stats] = anova2(anova_input,sum(adu_inds));
c = multcompare(stats)

% for juveniles
% reformatting data for anova2
corr_SWS=[sleep_vars(juv_inds).LLRRLR_corr_SWS];
corr_IS=[sleep_vars(juv_inds).LLRRLR_corr_IS];
corr_REM=[sleep_vars(juv_inds).LLRRLR_corr_REM];

anova_input=[
    corr_SWS(1:3:end),...
    corr_SWS(2:3:end),...
    corr_SWS(3:3:end);...
    corr_IS(1:3:end),...
    corr_IS(2:3:end),...
    corr_IS(3:3:end);...
    corr_REM(1:3:end),...
    corr_REM(2:3:end),...
    corr_REM(3:3:end)]';

[~,~,stats] = anova2(anova_input,sum(juv_inds));
c = multcompare(stats)












