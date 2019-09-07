function ops = convertOpenEphysToRawBinary_JO(dataDir, chanMap)

%fname       = fullfile(ops.root, sprintf('%s.dat', ops.fbinary));
%fname       = fullfile(ops.root, sprintf('%s', ops.fbinary));
%fname       = fullfile(sprintf('%s', ops.fbinary]));
fname       = fullfile(sprintf('%s', [dataDir '.dat']));
fidout      = fopen(fname, 'w');
%
clear fs
%d = load(ops.chanMap);
chansToLoad = chanMap;
Nchan = numel(chansToLoad);

for j = 1:Nchan
    o = chansToLoad(j);
    %fs{j} = dir(fullfile(ops.root, sprintf('*CH%d_*.continuous', j) ));
    fs{j} = dir(fullfile(dataDir, sprintf('*CH%d.continuous', o) )); % JO
end
nblocks = cellfun(@(x) numel(x), fs);
if numel(unique(nblocks))>1
    error('different number of blocks for different channels!')
end
%
nBlocks     = unique(nblocks);
nSamples    = 1024;  % fixed to 1024 for now!

fid = cell(Nchan, 1);

tic
for k = 1:nBlocks
    for j = 1:Nchan
        fid{j}             = fopen(fullfile(dataDir, fs{j}(k).name));
        % discard header information
        fseek(fid{j}, 1024, 0);
    end
    %
    nsamps = 0;
    flag = 1;
    while 1
        samples = zeros(nSamples * 1000, Nchan, 'int16');
        for j = 1:Nchan
            collectSamps    = zeros(nSamples * 1000, 1, 'int16');
            
            rawData         = fread(fid{j}, 1000 * (nSamples + 6), '1030*int16', 10, 'b');
            
            nbatches        = ceil(numel(rawData)/(nSamples+6));
            for s = 1:nbatches
                rawSamps = rawData((s-1) * (nSamples + 6) +6+ [1:nSamples]);
                collectSamps((s-1)*nSamples + [1:nSamples]) = rawSamps;
            end
            samples(:,j)         = collectSamps; % samples for all channels
        end
        
        if nbatches<1000
            flag = 0;
        end
        if flag==0
            samples = samples(1:s*nSamples, :);
        end
        
        samples         = samples';
        fwrite(fidout, samples, 'int16');
        
        nsamps = nsamps + size(samples,2);
        
        if flag==0
            break;
        end
    end
    ops.nSamplesBlocks(k) = nsamps;
    
    for j = 1:Nchan
        fclose(fid{j});
    end
    
end

fclose(fidout);

toc