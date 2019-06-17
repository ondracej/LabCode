function [data, timestamps, info, final_sample] = load_open_ephys_data_chunked(filename,start,finish)
% this function reads data from continious format Open Ephys files in part,
% staqrting from start up to finish. please note that you shall know the
% number of data points in the file in advance for this inputs.

fid = fopen(filename);
% constants
NUM_HEADER_BYTES = 1024;
SAMPLES_PER_RECORD = 1024;
RECORD_MARKER = [0 1 2 3 4 5 6 7 8 255]';
% constants for pre-allocating matrices:
MAX_NUMBER_OF_RECORDS = 1e6; % records: 1024 sample
MAX_NUMBER_OF_CONTINUOUS_SAMPLES = 1e8; % data points
    % header
    disp(['Loading ' filename '...']);
    index = 0;
    hdr = fread(fid, NUM_HEADER_BYTES, 'char*1');
    eval(char(hdr'));
    info.header = header;
    version = info.header.version;
    % pre-allocate space for continuous data
    data = zeros(MAX_NUMBER_OF_CONTINUOUS_SAMPLES, 1);
    info.ts = zeros(1, MAX_NUMBER_OF_RECORDS);
    info.nsamples = zeros(1, MAX_NUMBER_OF_RECORDS);
    info.recNum = zeros(1, MAX_NUMBER_OF_RECORDS);
    current_sample = start; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    RECORD_SIZE = 10 + SAMPLES_PER_RECORD*2 + 10 +2; % size of each continuous record in bytes including recNum
    
    % main data reading loop over recoeds
    while current_sample*RECORD_SIZE + RECORD_SIZE <= finish % at least one record remains
        
        go_back_to_start_of_loop = 0;
        index = index + 1;
        
            timestamp = fread(fid, 1, 'int64', 0, 'l'); % read an 8.byte block. 1 8-byte, 0 skip, little endian format
            nsamples = fread(fid, 1, 'uint16',0,'l'); % next 2 bytes --> nsamples
            recNum = fread(fid, 1, 'uint16'); % next 2 bytes --> recNum

        if nsamples ~= SAMPLES_PER_RECORD && version >= 0.1
            disp(['  Found corrupted record...searching for record marker.']);
            % switch to searching for record markers
            
            last_ten_bytes = zeros(size(RECORD_MARKER));
            
            for bytenum = 1:RECORD_SIZE*5
                
                byte = fread(fid, 1, 'uint8');
                
                last_ten_bytes = circshift(last_ten_bytes,-1);
                
                last_ten_bytes(10) = double(byte);
                
                if last_ten_bytes(10) == RECORD_MARKER(end)
                    
                    sq_err = sum((last_ten_bytes - RECORD_MARKER).^2);
                    
                    if (sq_err == 0)
                        disp(['   Found a record marker after ' int2str(bytenum) ' bytes!']);
                        go_back_to_start_of_loop = 1;
                        break; % from 'for' loop
                    end
                end
            end
            
            % if we made it through the approximate length of 5 records without
            % finding a marker, abandon ship.
            if bytenum == RECORD_SIZE*5
                
                disp(['Loading failed at block number ' int2str(index) '. Found ' ...
                    int2str(nsamples) ' samples.'])
                
                break; % from 'while' loop
                
            end
        end
        
        if ~go_back_to_start_of_loop
            
            block = fread(fid, nsamples, 'int16', 0, 'b'); % read in data. Big-endian ordering: b
            fread(fid, 10, 'char*1'); % read in record marker and discard
            data(current_sample+1:current_sample+nsamples) = block;
            current_sample = current_sample + nsamples;
            info.ts(index) = timestamp;
            info.nsamples(index) = nsamples;
            if version >= 0.2
                info.recNum(index) = recNum;
            end
            
        end
        
    end
    
    % crop data to the correct size
    data = data(1:current_sample);
    info.ts = info.ts(1:index);
    info.nsamples = info.nsamples(1:index);
    
    if version >= 0.2
        info.recNum = info.recNum(1:index);
    end
    final_sample=current_sample;
    % convert to microvolts
    data = data.*info.header.bitVolts;
    timestamps = nan(size(data));
    current_sample = 0;
    % curation after reading whole blocks
    if version >= 0.1
        
        for record = 1:length(info.ts)

            ts_interp = info.ts(record):info.ts(record)+info.nsamples(record);

            timestamps(current_sample+1:current_sample+info.nsamples(record)) = ts_interp(1:end-1);

            current_sample = current_sample + info.nsamples(record);
        end
    else % v0.0; NOTE: the timestamps for the last record will not be interpolated
        
         for record = 1:length(info.ts)-1

            ts_interp = linspace(info.ts(record), info.ts(record+1), info.nsamples(record)+1);

            timestamps(current_sample+1:current_sample+info.nsamples(record)) = ts_interp(1:end-1);

            current_sample = current_sample + info.nsamples(record);
         end
        
    end

fclose(fid); % close the file
% convert timestams from sample number to seconds
if (isfield(info.header,'sampleRate'))
    if ~ischar(info.header.sampleRate)
      timestamps = timestamps./info.header.sampleRate; % convert to seconds
    end
end

end
