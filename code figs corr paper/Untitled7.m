
% for adults 
network_sizes_all_birds=[];
for bird=1:3 % for the adults
    codes=[]; % decimal equivalent of binary representation of the graphs for each bird
    % SWS:
    SWS_nets=nets(bird).SWS_dominant_networks';
    if ~isempty(SWS_nets)
            codes=[codes  (SWS_nets*2.^[0:15]')'];
    end

    % IS:
    IS_nets=nets(bird).IS_dominant_networks';
    if ~isempty(IS_nets)
            codes=[codes  (IS_nets*2.^[0:15]')'];
    end

    % REM:
    REM_nets=nets(bird).REM_dominant_networks';
    if ~isempty(REM_nets)
            codes=[codes  (REM_nets*2.^[0:15]')'];
    end

    codes_unique=unique(codes); % accounts for redundancies between the networks that appear in several stages
    network_sizes_new_bird = sum(de2bi(codes_unique),2); % size of the networks
    network_sizes_all_birds=[network_sizes_all_birds network_sizes_new_bird'];
end