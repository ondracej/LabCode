clear; clc;
loaded_res=load('G:\Hamed\zf\P1\labled sleep\state_transition_result.mat');
res=loaded_res.res;

bird_names={'72-00','73-03','72-94','w0009','w0016','w0018','w0020','w0021','w0041','w0043'};
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


%% adding the light off/on times
n=1;

light_off_t(n)=28772/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=892778/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=2;

light_off_t(n)=31000/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=889160/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=3;

light_off_t(n)=5980/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=837500/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=4;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=746290/20;  %%%%%%%%%%% frame number devided by rate of acquisition

n=5;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=872000/20;  %%%%%%%%%%% frame number devided by rate of acquisition

n=6;

light_off_t(n)=690/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=871900/20;  %%%%%%%%%%% frame number devided by rate of acquisition

n=7;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=842000/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=8;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=884675/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=9;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=851777/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=10;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=843130/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=11;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=854300/20;  %%%%%%%%%%% frame number devided by rate of acquisition

n=12;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=842350/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=13;

light_off_t(n)=7000/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=857860/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=14;

light_off_t(n)=1780/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=851500/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=15;

light_off_t(n)=19040/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=881362/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=16;

light_off_t(n)=35580/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=900200/20;  %%%%%%%%%%% frame number devided by rate of acquisition

n=17;

light_off_t(n)=22100/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=885580/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=18;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=840700/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=19;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=847160/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=20;

light_off_t(n)=7370/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=919130/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=21;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=832800/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=22;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=810000/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=23

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=804670/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=24;

light_off_t(n)=52530/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=916540/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=25;

light_off_t(n)=135300/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=1000300/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=26;

light_off_t(n)=106800/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=989716/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=27;

light_off_t(n)=2970/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=867190/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=28;

light_off_t(n)=6715/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=871390/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=29;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=855300/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=30;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=879920/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=31;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=837890/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=32;

light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=820590/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=33;

light_off_t(n)=32120/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=897280/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=34;

light_off_t(n)=1580/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=866430/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=35;

light_off_t(n)=16560/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=881111/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=36;

light_off_t(n)=8630/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=873750/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=37;

light_off_t(n)=53200/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=917500/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=38;

light_off_t(n)=33050/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=897180/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=39;

light_off_t(n)=22100/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=885570/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=40;

light_off_t(n)=23390/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=887300/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=41;

light_off_t(n)=84520/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=947970/20;  %%%%%%%%%%% frame number devided by rate of acquisition



n=42;

light_off_t(n)=19130/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=883360/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=43;

light_off_t(n)=750/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=869900/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=44;

light_off_t(n)=27920/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=895800/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=45;

light_off_t(n)=20490/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=890370/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=46;

light_off_t(n)=7490/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=882890/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=47;

light_off_t(n)=18840/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=888050/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=48;

light_off_t(n)=17750/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=886245/20;  %%%%%%%%%%% frame number devided by rate of acquisition


n=49;

light_off_t(n)=24790/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t(n)=893940/20;  %%%%%%%%%%% frame number devided by rate of acquisition



%% statistical test and plot for the diffeence between juv/adult

% for juveniles

smooth_level=1; % 1:3 sec  2:15 sec  3:1 min
bird_n=0;
REM_transitions_juv=zeros(12,1);
for bird=1:length(res)
    if bird_id(bird)>3
        bird_n=bird_n+1;
        new_REM_onsets=(res(bird).REM_onsets{smooth_level}-light_off_t(bird))/3600;
        for h=0:11
            REM_transitions_juv(h+1,bird_n)=sum(h<new_REM_onsets & new_REM_onsets<h+1);
        end
    end
end

% for adults
bird_n=0;
REM_transitions_adult=zeros(12,1);
for bird=1:length(res)
    if bird_id(bird)<=3
        bird_n=bird_n+1;
        new_REM_onsets=(res(bird).REM_onsets{smooth_level}-light_off_t(bird))/3600;
        for h=0:11
            REM_transitions_adult(h+1,bird_n)=sum(h<new_REM_onsets & new_REM_onsets<h+1);
        end
    end
end

REMs_adult_mean=mean(REM_transitions_adult,2);  REMs_adult_mean(1)=REMs_adult_mean(1)*60/40 ; % because we counted the transitions 
% after 20 minutes through lights off
REMs_juv_mean=mean(REM_transitions_juv,2);  REMs_juv_mean(1)=REMs_juv_mean(1)*60/40 ; % because we counted the transitions 
% after 20 minutes through lights off
REMs_adult_err=std(REM_transitions_adult,0,2)/sqrt(size(REM_transitions_adult,2));
REMs_juv_err=std(REM_transitions_juv,0,2)/sqrt(size(REM_transitions_juv,2));

% plot
figure
set(gcf, 'Position',  [600, 500, 646, 170])
x=.5:11.5;

hold on
er = errorbar(x-.14,REMs_juv_mean,REMs_juv_err,REMs_juv_err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
er = errorbar(x+.14,REMs_adult_mean,REMs_adult_err,REMs_adult_err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

b=bar(x,[REMs_juv_mean'; REMs_adult_mean'], 'FaceColor',[1 .5 .5],'EdgeColor',[1 .9 .9]); 
b(2).FaceColor = [.5 .5 1];
b(2).EdgeColor = [.9 .9 1];
xlabel('Time (h)')
ylim([0 ...
    ceil(max([REMs_adult_mean; REMs_juv_mean],[],'all'))+1]);
% floor(min([REMs_juv_mean; REMs_adult_mean],[],'all')-.1*max([REMs_adult_mean; REMs_juv_mean],[],'all'))
xlim([0 12.01])

clear hh p
for h=1:12
    [hh(h),p(h)] = ttest2(REM_transitions_juv(h,:)', REMs_adult_mean(h,:)','Alpha',0.05);
end

smooth_len=[3 15 60]; % length of smoothing window in seconds
title(['state transitions/hour in juv (red) and adult (blue)   smoothing windows=' num2str(smooth_len(smooth_level)) ' sec']);

%% plots for inter-REM and inter-SWS histograms
% for juveniles

smooth_level=1; % 1:3 sec  2:15 sec  3:1 min
inter_REM_juv=[];
inter_SWS_juv=[];

for bird=1:length(res)
    if bird_id(bird)>3
        new_REM_onsets=diff(res(bird).REM_onsets{smooth_level});
            inter_REM_juv=[inter_REM_juv new_REM_onsets];
        new_SWS_onsets=diff(res(bird).SWS_onsets{smooth_level});
            inter_SWS_juv=[inter_SWS_juv new_SWS_onsets];            
    end
end

% for adults
smooth_level=1; % 1:3 sec  2:15 sec  3:1 min
inter_REM_adult=[];
inter_SWS_adult=[];

for bird=1:length(res)
    if bird_id(bird)<=3
        new_REM_onsets=diff(res(bird).REM_onsets{smooth_level});
            inter_REM_adult=[inter_REM_adult new_REM_onsets];
        new_SWS_onsets=diff(res(bird).SWS_onsets{smooth_level});
            inter_SWS_adult=[inter_SWS_adult new_SWS_onsets];            
    end
end

figure
set(gcf, 'Position',  [600, 500, 700, 200])
subplot(1,2,1) % inter SWS for juv and adult
nbin=18;
max_edge=max([inter_SWS_juv inter_SWS_adult inter_REM_adult inter_REM_adult],[],'all');
edges=logspace(log10(3),log10(max_edge),nbin);
bin_centers=(edges(1:end-1)+edges(2:end))/2;
[N1,~] = histcounts(inter_SWS_juv,edges);
h=loglog(bin_centers,N1/length(inter_SWS_juv),'.-','linewidth',1.5); grid on
h.Color = [1 .4 .4];
hold on
[N2,~] = histcounts(inter_SWS_adult,edges);
g=loglog(bin_centers,N2/length(inter_SWS_adult),'.-','linewidth',1.5); grid on
g.Color = [.4 .4 1];
xlim([5 2000]);
ylim([10^-4.1 .2]);
title('inter-SWS probability distribution');
legend('juveniles','adults','Location','southwest');  legend('boxoff')
ylabel('Probability');
xticks([ 10 50 100 1000])
xlabel('Inter-SWS time (sec)')
subplot(1,2,2) % inter REM for juv and adult
[N3,~] = histcounts(inter_REM_juv,edges);
k=loglog(bin_centers,N3/length(inter_REM_juv),'.-','linewidth',1.5); grid on
k.Color = [1 .4 .4];
hold on
[N4,~] = histcounts(inter_REM_adult,edges);
l=loglog(bin_centers,N4/length(inter_REM_adult),'.-','linewidth',1.5); grid on
l.Color = [.4 .4 1];
xlim([5 2000]); ylim([10^-4.1 .2]);
title('inter-REM probability distribution');
legend('juveniles','adults','Location','southwest');  legend('boxoff')
yticklabels([])
xticks([ 10 50 100 1000]);
xlabel('Inter-REM time (sec)')

inter_SWS_juv_mean=(N1*bin_centers')/sum(N1)
inter_SWS_adult_mean=(N2*bin_centers')/sum(N2)
[hh_SWS,pp]=ttest2(inter_SWS_juv,inter_SWS_adult)

inter_REM_juv_mean=(N3*bin_centers')/sum(N3)
inter_REM_adult_mean=(N4*bin_centers')/sum(N4)
[hh_REM,pp]=ttest2(inter_REM_juv,inter_REM_adult)

        
