
indx_=find(strcmp(auto_label,'Wake')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); 
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,valid_inds);
for k=1:size(EEG_stage,3)
    [C(:,:,k),mx,~,rho] = infer_network_correlation_analytic(EEG_stage(:,:,k));
end
conn_mat=mean(C,3)+diag(ones(1,size(C,1)));

figure
imagesc(conn_mat>.90,[0 1]); colorbar; axis square,  title('Wake binary Correlation'); 
xticks([4.5 12.5]); xticklabels({'L' , 'R'}); 

indx_=find(strcmp(auto_label,'SWS')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); 
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,valid_inds);
for k=1:size(EEG_stage,3)
    [C(:,:,k),mx,~,rho] = infer_network_correlation_analytic(EEG_stage(:,:,k));
end
conn_mat=mean(C,3)+diag(ones(1,size(C,1)));

figure
imagesc(conn_mat>.90,[0 1]); colorbar; axis square,  title('SWS binary Correlation'); 
xticks([4.5 12.5]); xticklabels({'L' , 'R'});  

indx_=find(strcmp(auto_label,'IS')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); 
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,valid_inds);
for k=1:size(EEG_stage,3)
    [C(:,:,k),mx,~,rho] = infer_network_correlation_analytic(EEG_stage(:,:,k));
end
conn_mat=mean(C,3)+diag(ones(1,size(C,1)));

figure
imagesc(conn_mat>.90,[0 1]); colorbar; axis square,  title('IS binary Correlation'); 
xticks([4.5 12.5]); xticklabels({'L' , 'R'});  

indx_=find(strcmp(auto_label,'REM')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); 
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,valid_inds);
for k=1:size(EEG_stage,3)
    [C(:,:,k),mx,~,rho] = infer_network_correlation_analytic(EEG_stage(:,:,k));
end
conn_mat=mean(C,3)+diag(ones(1,size(C,1)));

figure
imagesc(conn_mat>.90,[0 1]); colorbar; axis square,  title('REM binary Correlation'); 
xticks([4.5 12.5]); xticklabels({'L' , 'R'}); 