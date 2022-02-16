 path_directory='Z:\zoologie\HamedData\CorrelationPaper\Figures\new story\fig format'; 
 eps_path_directory='Z:\zoologie\HamedData\CorrelationPaper\Figures\new story\fig format\EpscFiles';
 original_files=dir([path_directory '\*.fig']); 
 for k=1:length(original_files)
    filename=[path_directory '\' original_files(k).name];
	openfig(filename);
    [ filepath , fname , ext ] = fileparts( filename ) ;
    print([eps_path_directory '\' fname],'-painters','-depsc');
 end


