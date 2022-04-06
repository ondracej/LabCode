%%  Fig. 3 plot of the inter/intra-hemispheric correlations during different stages in adult group
% for the adult
rng(355);
col_=.9*rand(10,3);
col_mask=[.5*ones(3,3); 1.1*ones(7,3)];
col=col_.*col_mask;
col(3,:)=1.4*col(3,:);
col(2,:)=.4*col(2,:);

f_adult=figure; 
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);
    age=780*(i==1)+686*(i==2)+780*(i==3)+50*(i==4)+51*(i==5)+51*(i==6)+54*(i==7)+52*(i==8)+83*(i==9)+69*(i==10); % depending on the bird ID, only one of the parenthesis will ...
    % be logically correct. That 1, multiplied by the age of the
    % corresponding bird, gives the age of the bird.
    if i<=3 % for adults
        
        % LL corr
        subplot(1,3,1) %  SWS
        x=res(bird_n).dph;
        plot( (x),res(bird_n).LLRRLR_corr_SWS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  IS
        plot( (x)+30,res(bird_n).LLRRLR_corr_IS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  REM
        plot( (x)+60,res(bird_n).LLRRLR_corr_REM(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim([45 180]);  ylabel('corr coef')
        xticks([0 1 2]*30);  xticklabels({'SWS','IS','REM'});
        title('Adult L-L EEG connectivity');
        
        % RR corr
        subplot(1,3,2) %  SWS
        plot( 0+(x),res(bird_n).LLRRLR_corr_SWS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  IS
        plot( 45+(x),res(bird_n).LLRRLR_corr_IS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  REM
        plot( 90+(x),res(bird_n).LLRRLR_corr_REM(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim([45 180]);
        xticks([0 1 2]*30);  xticklabels({'SWS','IS','REM'});
        title('Adult R-R EEG connectivity');
        
        % RL corr
        subplot(1,3,3) %  SWS
        plot( 0+(x),res(bird_n).LLRRLR_corr_SWS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  IS
        plot( 45+(x),res(bird_n).LLRRLR_corr_IS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  REM
        plot( 90+(x),res(bird_n).LLRRLR_corr_REM(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim([45 180]);
        xticks([0 1 2]*30);  xticklabels({'SWS','IS','REM'});
        title('Adult R-L EEG connectivity');
        
    end
end
%%
% for the juveniles
f_juvenile=figure; 
for bird_n=1:length(res)
    % plotting
    i=bird_id(bird_n);

    if i>3 % for adults
    x=res(bird_n).dph;
    age=780*(i==1)+686*(i==2)+780*(i==3)+50*(i==4)+51*(i==5)+51*(i==6)+54*(i==7)+52*(i==8)+83*(i==9)+69*(i==10); % depending on the bird ID, only one of the parenthesis will ...
    % be logically correct. That 1, multiplied by the age of the
    % corresponding bird, gives the age of the bird.    
        % LL corr
        subplot(1,3,1) %  SWS
        plot( 0+(x),res(bird_n).LLRRLR_corr_SWS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  IS
        plot( 45+(x),res(bird_n).LLRRLR_corr_IS(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,1) %  REM
        plot( 90+(x),res(bird_n).LLRRLR_corr_REM(1),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim([45 180]); ylabel('corr coef')
        xticks(30*[0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Juvenile L-L EEG connectivity');
        
        % RR corr
        subplot(1,3,2) %  SWS
        plot( 0+(x),res(bird_n).LLRRLR_corr_SWS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  IS
        plot( 45+(x),res(bird_n).LLRRLR_corr_IS(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,2) %  REM
        plot( 90+(x),res(bird_n).LLRRLR_corr_REM(2),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim([45 180]);
        xticks(30*[0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Juvenile R-R EEG connectivity');
        
        % RL corr
        subplot(1,3,3) %  SWS
        plot( 0+(x),res(bird_n).LLRRLR_corr_SWS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  IS
        plot( 45+(x),res(bird_n).LLRRLR_corr_IS(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        subplot(1,3,3) %  REM
        plot( 90+(x),res(bird_n).LLRRLR_corr_REM(3),'marker',bird_symbols{i},'color',col(i,:),...
            'LineWidth',1); hold on
        ylim([0 .95]); xlim([45 180]);
        xticks(30*[0 1 2]);  xticklabels({'SWS','IS','REM'});
        title('Juvenile R-L EEG connectivity');
        
    end
end

