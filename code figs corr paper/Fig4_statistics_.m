clear; clc;
loaded_res=load('G:\Hamed\zf\P1\labled sleep\batch_results_Fig4_pipeline.mat');
res=loaded_res.res;

bird_names={'72-00','73-03','72-94','w0009','w0016','w0018','w0020','w0021','w041-','w043-'};
bird_symbols={'o','<','>','+','*','x','s','d','v','^'};
rng(356868545);
col=.9*rand(8,3);

%  extracting the ID for each bird (1 to 8)
for bird_n=1:length(res)
    % finding the name of the bird
    bird_name_long=res(bird_n).experiment; % like 72-94_08_09_2021
    bird_name=bird_name_long(1:5); % like 72-94
    
    % finding the bird index (1 to 10)
    for i=1:length(bird_names)
        if strcmp(bird_names{i},bird_name)
            bird_id(bird_n)=i;
            break
        end
    end
end
clear bird_name i loaded_res bird_name_long
%% the structure to contain the results
for k=1:length(bird_names)
    network_res(k).bird_name=bird_names{k};
    network_res(k).bird_symbol=bird_symbols{k};
end

nights=zeros(1,length(bird_names)); % how many nights of recording from each bird we have
for id=[1 2 3 4 5 8 9 10] % only birds with minimum 3 nights of recording
    REM_main_cliques_bird=[];
    IS_main_cliques_bird=[];
    SWS_main_cliques_bird=[];
    REM_main_cliques_rate=[];
    IS_main_cliques_rate=[];
    SWS_main_cliques_rate=[];
    
    network_res(id).REM_dominant_networks=[];
    network_res(id).IS_dominant_networks=[];
    network_res(id).SWS_dominant_networks=[];

    for experiment=[1 26 27 2 3 4 19 20 21 36 37 38 13 14 29 33 34 6 47 48 49 43 44 45] % collection of 3-first-nights of all birds
        if bird_id(experiment)==id
            nights(id)=nights(id)+1;
            % dominant cliques of that night:
            % REM
            experiment_nets=res(experiment).REM_main_cliques;
            REM_main_cliques_bird=[REM_main_cliques_bird experiment_nets];
            % rate of occurrence of the dominant cliques
            if ~isempty(experiment_nets)
            REM_main_cliques_rate=[REM_main_cliques_rate ...
                res(experiment).REM_clique_occurance(1:size(experiment_nets,2))/res(experiment).REM_bins];
            end
            
            % IS
            experiment_nets=res(experiment).IS_main_cliques;
            IS_main_cliques_bird=[IS_main_cliques_bird experiment_nets];
            % rate of occurrence of the dominant cliques
            if ~isempty(experiment_nets)
            IS_main_cliques_rate=[IS_main_cliques_rate ...
                res(experiment).IS_clique_occurance(1:size(experiment_nets,2))/res(experiment).IS_bins];
            end
            
            % SWS
            experiment_nets=res(experiment).SWS_main_cliques;
            SWS_main_cliques_bird=[SWS_main_cliques_bird experiment_nets];
            % rate of occurrence of the dominant cliques
            if ~isempty(experiment_nets)
            SWS_main_cliques_rate=[SWS_main_cliques_rate ...
                res(experiment).SWS_clique_occurance(1:size(experiment_nets,2))/res(experiment).SWS_bins];
            end    
            
        end
    end
    
    % we need to check if a network has appeared all the nights. To do so,
    % we give a code to each network, which is basically the decimal
    % equivalent of its binary 1x16 representation. Then we see if that
    % decinmal number has appeared all as many times as the number of all
    % recording nights of thst bird

    REM_ids=bi2de(REM_main_cliques_bird','right-msb');
    IS_ids=bi2de(IS_main_cliques_bird','right-msb');
    SWS_ids=bi2de(SWS_main_cliques_bird','right-msb');

    % for REM networks
    % now we check the REM_ids one by one to see if we had nights(id) number of them
    [GC,GR] = groupcounts(REM_ids); % GC(i) is how many nights the network with ID GR(i) has apeared 
    for REM_net=1:length(GR) % for all the detected networks in bird id, in all his/her nights
        if GC(REM_net)==nights(id) % if the network with the ID GR(REM_net) has appeare all the nights of bird with ID equal to id
            % reconstructing the binary representation of the network with
            % the decimal ID equal to GR(REM_net)
            equivalent_net=[zeros(1,16-length(de2bi(GR(REM_net)))) fliplr(de2bi(GR(REM_net)))];
            network_res(id).REM_dominant_networks=[network_res(id).REM_dominant_networks flipud(equivalent_net') ];
        end
    end
    % for the rates of the REM_dominant_networks:
    % we compare the network_res(id).REM_dominant_networks with
    % REM_main_cliques_bird. For the ones in REM_main_cliques_bird that are
    % appearing in the network_res(id).REM_dominant_networks, we add its
    % corresponding rate of occurrence
    final_nets=network_res(id).REM_dominant_networks;
    all_nets=REM_main_cliques_bird;
    network_res(id).REM_dominant_networks_incidence=[];
     if ~isempty(final_nets)
         for k1=1:size(final_nets,2)
             cc=1; % counter of nights, goes from 1 to 3 
             for k2=1:size(all_nets,2)
                 if final_nets(:,k1)==all_nets(:,k2)
                     network_res(id).REM_dominant_networks_incidence(k1,cc)=REM_main_cliques_rate(k2); cc=cc+1;
                 end
             end
         end
     end
    
    % for IS networks
    % now we check the IS_ids one by one to see if we had nights(id) number of them
    [GC,GR] = groupcounts(IS_ids); % GC(i) is how many nights the network with ID GR(i) has apeared 
    for IS_net=1:length(GR) % for all the detected networks in bird id, in all his/her nights
        if GC(IS_net)==nights(id) % if the network with the ID GR(IS_net) has appeare all the nights of bird with ID equal to id
            % reconstructing the binary representation of the network with
            % the decimal ID equal to GR(REM_net)
            equivalent_net=[zeros(1,16-length(de2bi(GR(IS_net)))) fliplr(de2bi(GR(IS_net)))];
            network_res(id).IS_dominant_networks=[network_res(id).IS_dominant_networks flipud(equivalent_net') ];
        end
    end
    
    % for the rates of the IS_dominant_networks:
    % we compare the network_res(id).IS_dominant_networks with
    % IS_main_cliques_bird. For the ones in IS_main_cliques_bird that are
    % appearing in the network_res(id).IS_dominant_networks, we add its
    % corresponding rate of occurrence
    final_nets=network_res(id).IS_dominant_networks;
    all_nets=IS_main_cliques_bird;
    network_res(id).IS_dominant_networks_incidence=[];
     if ~isempty(final_nets)
         for k1=1:size(final_nets,2)
             cc=1; % counter of nights, goes from 1 to 3 
             for k2=1:size(all_nets,2)
                 if final_nets(:,k1)==all_nets(:,k2)
                     network_res(id).IS_dominant_networks_incidence(k1,cc)=IS_main_cliques_rate(k2); cc=cc+1;
                 end
             end
         end
     end
    
    % for SWS networks
    % now we check the SWS_ids one by one to see if we had nights(id) number of them
    [GC,GR] = groupcounts(SWS_ids); % GC(i) is how many nights the network with ID GR(i) has apeared 
    for SWS_net=1:length(GR) % for all the detected networks in bird id, in all his/her nights
        if GC(SWS_net)==nights(id) % if the network with the ID GR(SWS_net) has appeare all the nights of bird with ID equal to id
            % reconstructing the binary representation of the network with
            % the decimal ID equal to GR(REM_net)
            equivalent_net=[zeros(1,16-length(de2bi(GR(SWS_net)))) fliplr(de2bi(GR(SWS_net)))];
            network_res(id).SWS_dominant_networks=[network_res(id).SWS_dominant_networks flipud(equivalent_net') ];
        end
    end
    
        % for the rates of the SWS_dominant_networks:
    % we compare the network_res(id).SWS_dominant_networks with
    % SWS_main_cliques_bird. For the ones in SWS_main_cliques_bird that are
    % appearing in the network_res(id).SWS_dominant_networks, we add its
    % corresponding rate of occurrence
    final_nets=network_res(id).SWS_dominant_networks;
    all_nets=SWS_main_cliques_bird;
    network_res(id).SWS_dominant_networks_incidence=[];
     if ~isempty(final_nets)
         for k1=1:size(final_nets,2)
             cc=1; % counter of nights, goes from 1 to 3 
             for k2=1:size(all_nets,2)
                 if final_nets(:,k1)==all_nets(:,k2)
                     network_res(id).SWS_dominant_networks_incidence(k1,cc)=SWS_main_cliques_rate(k2); cc=cc+1;
                 end
             end
         end
     end
     
end

save('G:\Hamed\zf\P1\labled sleep\batch_result_dominant_networks','network_res');
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    