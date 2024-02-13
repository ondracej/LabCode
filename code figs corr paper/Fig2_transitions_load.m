clear;
addpath(genpath('G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper'));

n=1;
fname='sleep_stages_72-00_02-04';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=2;
fname='sleep_stages_72-00_03-04';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));

n=3;
fname='sleep_stages_72-00_05-04';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));

n=4;
fname='sleep_stages_72-00_06-04';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=5;
fname='sleep_stages_72-00_07-04';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=6;
fname='sleep_stages_72-00_26-03';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=7;
fname='sleep_stages_72-00_29-03';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=8;
fname='sleep_stages_72-00_31-03';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=9;
fname='sleep_stages_72-94_07-06';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=52530/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=10;
fname='sleep_stages_72-94_08-06';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=19130/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=11;
fname='sleep_stages_72-94_28-05';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=106800/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=12;
fname='sleep_stages_72-94_29-05';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=28772/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=13;
fname='sleep_stages_72-94_31-05';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=6715/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=14;
fname='sleep_stages_73-03_09_03';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=31000/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=15;
fname='sleep_stages_73-03_11_03';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=5980/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=16;
fname='sleep_stages_73-03_14_03';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=1; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=17;
fname='sleep_stages_w0009_01-05';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=18;
fname='sleep_stages_w0009_04-05';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=19;
fname='sleep_stages_w0009_05-05';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=20;
fname='sleep_stages_w0009_06-05';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=21;
fname='sleep_stages_w0009_28-04';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=1780/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=22;
fname='sleep_stages_w0009_30-04';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=1/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=23;
fname='sleep_stages_w0016_05-08';
data=load(fname);
output.sex(n)=1; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=32120/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=24;
fname='sleep_stages_w0016_06-08';
data=load(fname);
output.sex(n)=1; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=1580/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=25;
fname='sleep_stages_w0016_08-08';
data=load(fname);
output.sex(n)=1; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=690/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=26;
fname='sleep_stages_w0021_20_08';
data=load(fname);
output.sex(n)=1; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=22100/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=27;
fname='sleep_stages_w0021_21-08';
data=load(fname);
output.sex(n)=1; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=22100/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=28;
fname='sleep_stages_w0021_23-08';
data=load(fname);
output.sex(n)=1; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=84520/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=29;
fname='sleep_stages_w0041-05-01-2022';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=750/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=30;
fname='sleep_stages_w0041-06-01-2022';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=27920/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=31;
fname='sleep_stages_w0041-07-01-2022';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=20490/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=32;
fname='sleep_stages_w0041-08-01-2022';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=7490/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));


n=33;
fname='sleep_stages_w0043-23-12-2021';
data=load(fname);
output.sex(n)=0; % 0:male, 1:fem
output.age(n)=0; % 0: juv, 1:adult
light_off_t(n)=24790/20; %%%%%%%%%%% frame number devided by rate of acquisition
output.transitions(n)=Fig2_transitions_code(data, light_off_t(n));

%% statistical test and plot for the diffeence between juv/adult

% REM to IS
juv_n=0;
adult_n=0;
REM_to_IS_juv=zeros(1,12);
REM_to_IS_adult=zeros(1,12);
for bird=1:length(output.transitions)
    if output.age(bird)==0
        juv_n=juv_n+1;
        REM_to_IS_juv(juv_n,:)=output.transitions(bird).REM_to_IS;
    else
        adult_n=adult_n+1;
        REM_to_IS_adult(adult_n,:)=output.transitions(bird).REM_to_IS;
    end
end

REM_to_IS_juv_mean=mean(REM_to_IS_juv,1);  
REM_to_IS_juv_err=std(REM_to_IS_juv,0,1)/sqrt(juv_n);
REM_to_IS_adult_mean=mean(REM_to_IS_adult,1);  
REM_to_IS_adult_err=std(REM_to_IS_adult,0,1)/sqrt(adult_n);

% plot
figure
set(gcf, 'Position',  [100, 100, 560, 200])
x=1:12;

hold on
er = errorbar(x-.14,REM_to_IS_juv_mean,REM_to_IS_juv_err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
er = errorbar(x+.14,REM_to_IS_adult_mean,REM_to_IS_adult_err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

b=bar(x,[REM_to_IS_juv_mean; REM_to_IS_adult_mean], 'FaceColor',[1 .5 .5],'EdgeColor',[1 .9 .9]); 
b(2).FaceColor = [.5 .5 1];
b(2).EdgeColor = [.9 .9 1];
xlabel('Time (h)')
xlim([.5 12.51]);
ylabel('REM to IS transitions')


% REM to SWS
juv_n=0;
adult_n=0;
REM_to_SWS_juv=zeros(1,12);
REM_to_SWS_adult=zeros(1,12);
for bird=1:length(output.transitions)
    if output.age(bird)==0
        juv_n=juv_n+1;
        REM_to_SWS_juv(juv_n,:)=output.transitions(bird).REM_to_SWS;
    else
        adult_n=adult_n+1;
        REM_to_SWS_adult(adult_n,:)=output.transitions(bird).REM_to_SWS;
    end
end

REM_to_SWS_juv_mean=mean(REM_to_SWS_juv,1);  
REM_to_SWS_juv_err=std(REM_to_SWS_juv,0,1)/sqrt(juv_n);
REM_to_SWS_adult_mean=mean(REM_to_SWS_adult,1);  
REM_to_SWS_adult_err=std(REM_to_SWS_adult,0,1)/sqrt(adult_n);

% plot
figure
set(gcf, 'Position',  [100, 500, 560, 200])
x=1:12;

hold on
er = errorbar(x-.14,REM_to_SWS_juv_mean,REM_to_SWS_juv_err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
er = errorbar(x+.14,REM_to_SWS_adult_mean,REM_to_SWS_adult_err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

b=bar(x,[REM_to_SWS_juv_mean; REM_to_SWS_adult_mean], 'FaceColor',[1 .5 .5],'EdgeColor',[1 .9 .9]); 
b(2).FaceColor = [.5 .5 1];
b(2).EdgeColor = [.9 .9 1];
xlabel('Time (h)')
xlim([.5 12.51]);
ylabel('REM to SWS transitions')

% SWS to IS
juv_n=0;
adult_n=0;
SWS_to_IS_juv=zeros(1,12);
SWS_to_IS_adult=zeros(1,12);
for bird=1:length(output.transitions)
    if output.age(bird)==0
        juv_n=juv_n+1;
        SWS_to_IS_juv(juv_n,:)=output.transitions(bird).SWS_to_IS;
    else
        adult_n=adult_n+1;
        SWS_to_IS_adult(adult_n,:)=output.transitions(bird).SWS_to_IS;
    end
end

SWS_to_IS_juv_mean=mean(SWS_to_IS_juv,1);  
SWS_to_IS_juv_err=std(SWS_to_IS_juv,0,1)/sqrt(juv_n);
SWS_to_IS_adult_mean=mean(SWS_to_IS_adult,1);  
SWS_to_IS_adult_err=std(SWS_to_IS_adult,0,1)/sqrt(adult_n);

% plot
figure
set(gcf, 'Position',  [700, 100, 560, 200])
x=1:12;

hold on
er = errorbar(x-.14,SWS_to_IS_juv_mean,SWS_to_IS_juv_err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
er = errorbar(x+.14,SWS_to_IS_adult_mean,SWS_to_IS_adult_err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

b=bar(x,[SWS_to_IS_juv_mean; SWS_to_IS_adult_mean], 'FaceColor',[1 .5 .5],'EdgeColor',[1 .9 .9]); 
b(2).FaceColor = [.5 .5 1];
b(2).EdgeColor = [.9 .9 1];
xlabel('Time (h)')
xlim([.5 12.51]);
ylabel('SWS to IS transitions')


% REM to IS
juv_n=0;
adult_n=0;
SWS_to_REM_juv=zeros(1,12);
SWS_to_REM_adult=zeros(1,12);
for bird=1:length(output.transitions)
    if output.age(bird)==0
        juv_n=juv_n+1;
        SWS_to_REM_juv(juv_n,:)=output.transitions(bird).SWS_to_REM;
    else
        adult_n=adult_n+1;
        SWS_to_REM_adult(adult_n,:)=output.transitions(bird).SWS_to_REM;
    end
end

SWS_to_REM_juv_mean=mean(SWS_to_REM_juv,1);  
SWS_to_REM_juv_err=std(SWS_to_REM_juv,0,1)/sqrt(juv_n);
SWS_to_REM_adult_mean=mean(SWS_to_REM_adult,1);  
SWS_to_REM_adult_err=std(SWS_to_REM_adult,0,1)/sqrt(adult_n);

% plot
figure
set(gcf, 'Position',  [700, 500, 560, 200])
x=1:12;

hold on
er = errorbar(x-.14,SWS_to_REM_juv_mean,SWS_to_REM_juv_err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
er = errorbar(x+.14,SWS_to_REM_adult_mean,SWS_to_REM_adult_err);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

b=bar(x,[SWS_to_REM_juv_mean; SWS_to_REM_adult_mean], 'FaceColor',[1 .5 .5],'EdgeColor',[1 .9 .9]); 
b(2).FaceColor = [.5 .5 1];
b(2).EdgeColor = [.9 .9 1];
xlabel('Time (h)')
xlim([.5 12.51]);
ylabel('SWS to REM transitions')


%% statistical tests
for bird=1:length(output.transitions)
    REM_to_IS(bird)=sum(output.transitions(bird).REM_to_IS);
    REM_to_SWS(bird)=sum(output.transitions(bird).REM_to_SWS);
    SWS_to_IS(bird)=sum(output.transitions(bird).SWS_to_IS);
    SWS_to_REM(bird)=sum(output.transitions(bird).SWS_to_REM);
end

[p,~,stats] = anovan(REM_to_IS,{output.age,output.sex})
[p,~,stats] = anovan(REM_to_SWS,{output.age,output.sex})
[p,~,stats] = anovan(SWS_to_IS,{output.age,output.sex})
[p,~,stats] = anovan(SWS_to_REM,{output.age,output.sex})

 mean_REM_to_IS_juv=mean(REM_to_IS(logical(output.age==0)))
 sd_REM_to_IS_juv=std(REM_to_IS(logical(output.age==0)))
 
  mean_REM_to_IS_adult=mean(REM_to_IS(logical(output.age==1)))
 sd_REM_to_IS_adult=std(REM_to_IS(logical(output.age==1)))
 
 
  mean_REM_to_SWS_juv=mean(REM_to_SWS(logical(output.age==0)))
 sd_REM_to_SWS_juv=std(REM_to_SWS(logical(output.age==0)))
 
  mean_REM_to_SWS_adult=mean(REM_to_SWS(logical(output.age==1)))
 sd_REM_to_SWS_adult=std(REM_to_SWS(logical(output.age==1)))
 
 
  mean_SWS_to_IS_juv=mean(SWS_to_IS(logical(output.age==0)))
 sd_SWS_to_IS_juv=std(SWS_to_IS(logical(output.age==0)))
 
  mean_SWS_to_IS_adult=mean(SWS_to_IS(logical(output.age==1)))
 sd_SWS_to_IS_adult=std(SWS_to_IS(logical(output.age==1)))
 
 
  mean_SWS_to_REM_juv=mean(SWS_to_REM(logical(output.age==0)))
 sd_REM_to_IS_juv=std(SWS_to_REM(logical(output.age==0)))
 
  mean_SWS_to_REM_adult=mean(SWS_to_REM(logical(output.age==1)))
 sd_SWS_to_REM_adult=std(SWS_to_REM(logical(output.age==1)))
 
 