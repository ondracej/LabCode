function [conf_mat] = confusion_mat(target,output)
%  confusion matrix for classification results:
%  conf_mat=[tp, fn;fp, tn];
%  
tp= sum(target==1 & output==1)/sum(target==1);
fp= sum(target==0 & output==1)/sum(target==0);
fn= sum(target==1 & output==0)/sum(target==1);
tn= sum(target==0 & output==0)/sum(target==0);
conf_mat=[tp, fn;fp, tn];
end

