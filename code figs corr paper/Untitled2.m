%% statistics of occurrence of networks for each group and in each stage

% for adults 
SWS_adult_sizes=[];
IS_adult_sizes=[];
REM_adult_sizes=[];

for bird=1:3 % for the adults
    % SWS:
    SWS_nets_sizes=sum(nets(bird).SWS_dominant_networks);
    if SWS_nets_sizes>0
            SWS_adult_sizes=[SWS_adult_sizes  SWS_nets_sizes];
    end

    % IS:
    IS_nets_sizes=sum(nets(bird).IS_dominant_networks);
    if IS_nets_sizes>0
            IS_adult_sizes=[IS_adult_sizes  IS_nets_sizes];
    end

    % REM:
    REM_nets_sizes=sum(nets(bird).REM_dominant_networks);
    if REM_nets_sizes>0
            REM_adult_sizes=[REM_adult_sizes  REM_nets_sizes];
    end

end


% for juveniles 
SWS_juvenile_sizes=[];
IS_juvenile_sizes=[];
REM_juvenile_sizes=[];

for bird=4:10 % for the juveniles
    % SWS:
    SWS_nets_sizes=sum(nets(bird).SWS_dominant_networks);
    if SWS_nets_sizes>0
            SWS_juvenile_sizes=[SWS_juvenile_sizes  SWS_nets_sizes];
    end

    % IS:
    IS_nets_sizes=sum(nets(bird).IS_dominant_networks);
    if IS_nets_sizes>0
            IS_juvenile_sizes=[IS_juvenile_sizes  IS_nets_sizes];
    end

    % REM:
    REM_nets_sizes=sum(nets(bird).REM_dominant_networks);
    if REM_nets_sizes>0
            REM_juvenile_sizes=[REM_juvenile_sizes  REM_nets_sizes];
    end

end


% number of networks per bird
length()
mean_REM_juvenile_sizes=mean(REM_juvenile_sizes)
std_REM_juvenile_sizes=std(REM_juvenile_sizes)

mean_REM_adult_sizes=mean(REM_adult_sizes)
std_REM_adult_sizes=std(REM_adult_sizes)

mean_SWS_juvenile_sizes=mean(SWS_juvenile_sizes)
std_SWS_juvenile_sizes=std(SWS_juvenile_sizes)

mean_SWS_adult_sizes=mean(SWS_adult_sizes)
std_SWS_adult_sizes=std(SWS_adult_sizes)

mean_IS_juvenile_sizes=mean(IS_juvenile_sizes)
std_IS_juvenile_sizes=std(IS_juvenile_sizes)

mean_IS_adult_sizes=mean(IS_adult_sizes)
std_IS_adult_sizes=std(IS_adult_sizes)