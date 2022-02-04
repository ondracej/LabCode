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
    
    
    network_res(id).REM_dominant_networks=[];
    for experiment=[36 37 38 13 14 29 33 34 6 47 48 49 43 44 45] % collection of 3-first-nights of all birds
        if bird_id(experiment)==id
            nights(id)=nights(id)+1;
            REM_main_cliques_bird=[REM_main_cliques_bird res(experiment).REM_main_cliques];
            IS_main_cliques_bird=[IS_main_cliques_bird res(experiment).IS_main_cliques];
            SWS_main_cliques_bird=[SWS_main_cliques_bird res(experiment).SWS_main_cliques];
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
    
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    