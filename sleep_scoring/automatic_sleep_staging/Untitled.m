figure
plot(ones(1,length(var_Wake)),var_Wake,'color',[1 .9 0],'marker','o','markersize',2); hold on
plot(2*ones(1,length(var_Drowsy)),var_Drowsy,'co','markersize',2);
plot(3*ones(1,length(var_nREM)),var_nREM,'bo','markersize',2);
plot(4*ones(1,length(var_REM)),var_REM,'ro','markersize',2);

plot(6+ones(1,length(skew_Wake)),skew_Wake,'color',[1 .9 0],'marker','o','markersize',2); hold on
plot(6+2*ones(1,length(skew_Drowsy)),skew_Drowsy,'co','markersize',2);
plot(6+3*ones(1,length(skew_nREM)),skew_nREM,'bo','markersize',2);
plot(6+4*ones(1,length(skew_REM)),skew_REM,'ro','markersize',2);

plot(12+ones(1,length(kurto_Wake)),kurto_Wake,'color',[1 .9 0],'marker','o','markersize',2); hold on
plot(12+2*ones(1,length(kurto_Drowsy)),kurto_Drowsy,'co','markersize',2);
plot(12+3*ones(1,length(kurto_nREM)),kurto_nREM,'bo','markersize',2);
plot(12+4*ones(1,length(kurto_REM)),kurto_REM,'ro','markersize',2);