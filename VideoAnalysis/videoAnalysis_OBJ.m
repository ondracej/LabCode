classdef videoAnalysis_OBJ < handle
    
    
    properties (Access = public)
        
        VID
        HOST
        PATH
    end
    
    methods
        
        
        function obj = getVideoInfo(obj,vidPath)
            
            disp('Getting video info...')
            
            obj.HOST.hostname = gethostname;
            
            if ispc
                dirD = '\';
            else
                dirD = '/';
            end
            
            obj.HOST.dirD = dirD;
            obj.PATH.VidPath = vidPath;
            [pathstr,name,ext] = fileparts(vidPath{:});
            
            editedVidPath = [pathstr dirD 'editedVids' dirD];
            
            if exist(editedVidPath, 'dir') ==0
                mkdir(editedVidPath);
                disp(['Created directory: ' editedVidPath])
            end
            
            obj.PATH.editedVidPath = editedVidPath;
            
        end
        
        function [] = convertWMVToAVI(obj, startFrame, endFrame, videoName, FrameRateOverride)
            if nargin < 5
                FrameRateOverride = [];
            end
            
            
            VidObj = VideoReader(obj.PATH.VidPath{:});
            
            vidHeight = VidObj.Height;
            vidWidth = VidObj.Width;
            totalFrames = VidObj.NumberOfFrames;
            
            if isempty(FrameRateOverride)
                VidFrameRate = VidObj.FrameRate;
            else
                VidFrameRate = FrameRateOverride;
            end
            
            if isnan(endFrame)
                endFrame = totalFrames;
            end
            
            
            FrameCut = 1* VidFrameRate*60*60; % 1 hour
            
            if totalFrames > FrameCut;
                tOn = 1:FrameCut:totalFrames;
                nParts = numel(tOn);
            else
                tOn = 1;
                nParts = 1;
            end
            
            for q = 1:nParts
                
                FrameOn = tOn(q);
                FrameOff = tOn(q)+FrameCut;
                
                if q== nParts
                    FrameOff =totalFrames;
                end
                
                
                nFrames = numel(FrameOn:FrameOff);
                framesToGrab = FrameOn:FrameOff;
                disp('All Frames Video')
                mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
                cnt = 1;
                for k =framesToGrab
                    mov(cnt).cdata = read(VidObj, k);
                    fprintf('%d/%d\n', cnt, nFrames);
                    cnt = cnt+1;
                end
                
                saveName = [obj.PATH.editedVidPath videoName '_' sprintf('%03d',q) '.avi' ];
                V = VideoWriter(saveName, 'Motion JPEG AVI');
                V.FrameRate = VidFrameRate;
                
                mov = mov(1:end);
                tic
                open(V)
                writeVideo(V, mov)
                close(V)
                toc
                
                disp(['Saved: ' saveName])
                clear('mov');
            end
            
        end
        
        
        function [] = renameFilesinDir(obj)
            
            
            renameVideos = 0;
            %addNumber = 0;
            %prependDateName = 0;
            prependZeros = 1;
            
            dbstop if error
            
            dirToRename = 'F:\Grass\DataShare\5Tadpoles_20190725_21-13\' ;
            renamedDir = 'F:\Grass\DataShare\5Tadpoles_20190725_21-13\' ;
            
            if exist(renamedDir, 'dir') == 0
                mkdir(renamedDir);
            end
            
            %%
            %searchString = '*.jpg';
            searchString = '*.tiff';
            
            files = dir(fullfile(dirToRename, searchString));
            
            nFiles = numel(files);
            tic
            for j = 1:nFiles
                fileNames{j} = files(j).name;
            end
            toc
            %%
            underscore = '_';
            period = '.';
            
            if prependZeros == 1
                folder = dirToRename;  % e.g
                tic
                for k=1:nFiles
                    
                    underscoreInds = find(fileNames{k} == underscore);
                    periodInds = find(fileNames{k} == period);
                    
                    firstPart = fileNames{k}(1:underscoreInds(end));
                    numberStr = fileNames{k}(underscoreInds(end)+1:periodInds(1)-1);
                    numberStrPrepend =   ['0000' numberStr];
                    extText = fileNames{k}(periodInds(1):end);
                    
                    combinedFilename = [firstPart numberStrPrepend extText];
                    
                    
                    file1=[folder fileNames{k}];
                    file2=[renamedDir combinedFilename];
                    
                    movefile(file1 ,file2)
                    disp([num2str(k) '/' num2str(nFiles)])
                    
                end
                toc
            end
            
            
            %
            %     %sprintf('%02d',p)
            %
            %
            % if prependDateName
            %
            %     preNameTxt = 'P48_12042015_17-57-11_';
            %     folder = dirToRename;  % e.g
            %     for k=1:nFiles
            %         file1=[folder fileNames{k}];
            %         file2=[renamedDir preNameTxt fileNames{k}];
            %
            %         movefile(file1 ,file2)
            %     end
            %
            % end
            %
            %
            % %% For renaming the files
            %

             if renameVideos
                 
               preNameTxt = '5Tadpoles20190717_10-54';
               nChars = numel(preNameTxt);
               folder = dirToRename;  % e.g
               for k=1:nFiles
                   
                   thisFile = fileNames{k};
                   newFilename = thisFile;
                   newFilename(1) = [];
                   newFilename(1:nChars) = preNameTxt;
                   file1 = [folder fileNames{k}];
                   file2=[folder newFilename];
                   
                   movefile(file1 ,file2)
                    disp([num2str(k) '/' num2str(nFiles)])
               end
             end
            %             if renameVideos
%             
%                 preNameTxt = '5Tadpoles20190717';
%                 folder = dirToRename;  % e.g
%                 for k=1:nFiles
%                     file1=[folder preNameTxt sprintf('%d.AVI.avi', k)];
%             
%                     if numel(k) == 1
%                         file2=[renamedDir preNameTxt sprintf('00%d.avi',k)];
%                     elseif numel(k) == 2
%                         file2=[renamedDir preNameTxt sprintf('0%d.avi',k)];
%                     elseif numel(k) == 3
%                         file2=[renamedDir preNameTxt sprintf('%d.avi',k)];
%                     end
%             
%                     movefile(file1 ,file2)
%                 end
%             
%                 keyboard
%             end
            %
            % %% Other solutions
            %
            % if addNumber
            %     dot = '.';
            %     dash = '_';
            %
            %     finalStr = []; allNums = [];
            %     for j = 1:nFiles
            %         str = fileNames{j};
            %
            %         dots = find(str == dot);
            %         dashs = find(str == dash);
            %
            %         chars = str(dashs(end)+3:dots(1)-1);
            %         allNums(j) = str2double(chars);
            %         if numel(chars) ==3
            %
            %         elseif numel(chars) ==4
            %
            %             chars(1) = [];
            %
            %         elseif numel(chars) ==5
            %             chars(1) = [];
            %             chars(1) = [];
            %         end
            %
            %         finalStr{j} = [str(1:dashs(end)) chars '.avi'];
            %
            %         thisName = finalStr{j};
            %
            %
            %         movefile([dirToRename str] , [renamedDir thisName])
            %
            %
            %     end
            %
            %     [bla inds] = sort(allNums, 'ascend');
            %
            %     %% Resort the fileNames
            %
            %
            %
            %
            %
            %     partToReplace = 'DLTdv5_data_20160525001_1_';
            %     partToReplaceWith = 'DLTdv5_data_20160525001_1_Pt';
            %
            %     % Loop through each
            %     for id = 1:length(files)
            %
            %         [~, f, ext] = fileparts(files(id).name);
            %
            %         searchstr = '_';
            %         sep = strfind(f, searchstr);
            %
            %         fileEnding = f(sep(end)+1:end);
            %
            %         bla = strfind(f, partToReplace);
            %         f(bla:length(partToReplaceWith)+length(fileEnding)) = [partToReplaceWith fileEnding];
            %
            %         %searchstr = '__';
            %         %sep = strfind(f, searchstr);
            %         %f(sep) = [];
            %
            %
            %
            %
            %         movefile([dirToRename files(id).name], [renamedDir f ext]);
            %     end
            %
            % end
            
        end
        
        function [] = loadTwoVidsMakePlaybackVideo(obj)
            
            V = obj.VID;
            nVids = V.nVids;
            
            for j = 1: nVids
                
                
                V = obj.VID;
                vidHeight = V.vidHeight;
                vidWidth = V.vidWidth;
                nFrames = V.nFrames;
                VidFrameRate = V.VideoFrameRate;
                
                nFrames = vidObj.NumberOfFrames;
                vidObj = VideoReader(obj.PATH.VidPath{j});
                
                mmfileinfo = obj.PATH.VidPath{j};
                
                
                %mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
                
                mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
                for k =1:nFrames
                    mov(k).cdata = read(vidObj, k);
                    vidFrame = read(vidObj, k);
                    image(vidFrame, 'Parent', currAxes);
                    fprintf('%d/%d\n', k, nFrames);
                end
                
                s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
                
                k = 1;
                for k = 1:nFrames
                    s(k).cdata = read(vidObj, k);
                    vidFrame = read(vidObj, k);
                    image(vidFrame, 'Parent', currAxes);
                    currAxes.Visible = 'off';
                    
                    k = k+1;
                end
                
                s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
                k = 1;
                while vidObj.CurrentTime <= 30
                    s(k).cdata = readFrame(vidObj);
                    k = k+1;
                end
                
            end
            
            
            
            
        end
        
        function [] = convert_and_compress_video_files(obj, FrameRateOverride, doDS, dsFrameRate)
            if nargin < 3
                
                
            end
            
            
            savePath = obj.PATH.editedVidPath;
            
            %% Define downsampling
            
            %             doDS = 1;
            %             if doDS
            %                 dsFrameRate = 1;
            %             else
            %                 dsFrameRate = 1;
            %             end
            %
            
            %% Compression type
            
            compressionType = 7;
            
            switch compressionType
                
                case 1
                    compression = 'Indeo3'; % does not work with 64 bit systems
                case 2
                    compression = 'Indeo5'; %default, works, % does not work with Win7 64 bit systems
                case 3
                    compression = 'Cinepak'; % works with 32 bit windows, not Win7 64 bit
                case 4
                    compression = 'MSVC'; % Do not use with color
                case 5
                    compression = 'RLE'; % Do not use with color
                case 6
                    compression = 'None'; % do not use (huge file)
                case 7
                    compression = 'Motion JPEG AVI'; % VideoWriter
                case 8
                    compression = 'MPEG-4'; % VideoWriter
            end
            
            %%
            disp('Loading Video, this make take a while...')
            tic
            vidReaderObj = VideoReader(obj.PATH.VidPath{:}, 'Tag', 'VidReadObj');
            toc
            
            nFrames = vidReaderObj.NumberOfFrames;
            vidHeight = vidReaderObj.Height;
            vidWidth = vidReaderObj.Width;
            OldframeRate = FrameRateOverride;
            
            %%
            
            if doDS % how many frames to skip when downsampling
                frameSkip = OldframeRate/dsFrameRate;
                
                %if isProblemFrameRate
                %    frameSkip = ceil(27.77777/dsFrameRate);
                %end
            end
            
            %% also going to make smaller movie chunks
            %             if nFrames > 50000 % for incorrect 10fps frame count = 10 frames/360 ms
            %                 frameCutoff = 50000;
            %                 subDivMovs = 1;
            %             else
            %                 newNFrames = floor(nFrames/frameSkip);
            %                 subDivMovs = 0;
            %             end
            %
            %
            
            %             if subDivMovs
            %                 nMovs = ceil(nFrames/frameCutoff);
            %                 mStart = []; mstop = [];
            %
            %                 for p = 1: nMovs
            %
            %                     if p == 1
            %                         mStart(p) = 1;
            %                         mstop(p) = mStart(p) + frameCutoff;
            %                     elseif p == nMovs
            %                         mStart(p) = mstop(p-1)+1;
            %                         mstop(p) = nFrames;
            %                     else
            %                         mStart(p) = mstop(p-1)+1;
            %                         mstop(p) =  mStart(p) + frameCutoff;
            %                     end
            %
            %                 end
            %
            %                 movieLengthFull = mstop-mStart;
            %                 newNFrames = floor(movieLengthFull/frameSkip);
            %
            %             else
            %                 nMovs = 1;
            %                 mStart = 1;
            %                 mstop =  nFrames;
            %             end
            %
            
            %   for o = 1: nMovs
            
            
            %          mStart = 1;
            %          mstop =  nFrames;
            
            
            %% Read one frame at a time.
            
            
            thisStart = 1;
            thisStop = nFrames;
            
            movieLengthFull = thisStop-thisStart;
            newNFrames = floor(movieLengthFull/frameSkip);
            
            mov(1:newNFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
            
            cnt = thisStart;
            for k = 1 : newNFrames +1
                mov(k).cdata = read(vidReaderObj, cnt);
                fprintf('%d/%d // %d\n', cnt, thisStop, k);
                cnt = cnt+frameSkip;
            end
            
            %% Saving
            
            disp('Saving...')
            
            saveName = [name '__DS-' num2str(dsFrameRate) 'fps__Pt' num2str(o) ext];
            
            newSave = [savePath saveName];
            
            tic
            
            %movie2avi(mov, newSave, 'compression', compression, 'fps', dsFrameRate, 'quality', 90)
            %movie2avi(mov, newSave, 'compression', 'FFDS', 'fps', dsFrameRate)% http://de.mathworks.com/matlabcentral/newsreader/view_thread/288274
            
            v = VideoWriter(newSave, compression);
            v.FrameRate = dsFrameRate;
            
            open(v)
            writeVideo(v,mov)
            close(v)
            
            toc
            
            disp(['Saved: ' newSave])
            
            clear('mov')
            
            
        end
        
        
        function [] = makeMovieFromImages_2Videos(obj, ImgDirs, fileFormat)
            dbstop if error
            
            [pathstr,name1,ext] = fileparts(ImgDirs{1});
            [pathstr,name2,ext] = fileparts(ImgDirs{1});
            
            saveDir = [pathstr obj.HOST.dirD];
            vidSaveName = [saveDir name1 '-' name2 '_combo.avi'];
            %fileFormat = 1; % (1)- tif, (2) -.jpg
            playInReverse = 0; %(1) play the images from last to first
            
            %%
            switch fileFormat
                case 1
                    imgFormat = '*.tif';
                case 2
                    imgFormat = '*.jpg';
            end
            
            %% Reverse or Forward
            
            imageNames_Vid1 = dir(fullfile(ImgDirs{1},imgFormat));
            imageNames_Vid1 = {imageNames_Vid1.name}';
            
            imageNames_Vid2 = dir(fullfile(ImgDirs{2},imgFormat));
            imageNames_Vid2 = {imageNames_Vid2.name}';
            
            startFrame = imageNames_Vid1{1}(1:end-4);
            endFrame = imageNames_Vid1{end}(1:end-4);
            
            matchIndsStart = cellfun(@(x) strfind(x, startFrame), imageNames_Vid1, 'UniformOutput', 0);
            matchIndsStartInd = find(cellfun(@(x) ~isempty(x), matchIndsStart)==1);
            
            matchIndsEnd = cellfun(@(x) strfind(x, endFrame), imageNames_Vid1, 'UniformOutput', 0);
            matchIndsEndInd = find(cellfun(@(x) ~isempty(x), matchIndsEnd)==1);
            
            if playInReverse == 0
                framesToGrab = matchIndsStartInd:1:matchIndsEndInd; % forward playback
            elseif playInReverse == 1
                framesToGrab = matchIndsEndInd:-1:matchIndsStartInd; % reversed playback
            end
            
            
            %%
            fig1 = figure(100);clf
            for f = framesToGrab
                img_tmp1 = imread([ImgDirs{1} obj.HOST.dirD imageNames_Vid1{f}]);
                img_tmp2 = imread([ImgDirs{2} obj.HOST.dirD imageNames_Vid2{f}]);
                if fileFormat == 1
                    img1 = im2uint8(img_tmp1); % need to convert for .tif files
                    img2 = im2uint8(img_tmp2); % need to convert for .tif files
                elseif fileFormat ==2
                    img1 = img_tmp1;
                    img2 = img_tmp2;
                end
                
                imgF = vertcat(img2,img1);
                
                %scale=size(img1,1)/size(imgF,1);
                
                %img3 = imresize(img1,scale);
                %img4 = imresize(img2,scale);
                
                %imgF =  vertcat(img3,img4);
                
                image(imgF)
                axis('off')
                %annotation(fig1,'textbox', [0.80 0.08 0.1 0.1], 'String',currTime_txt, 'FontWeight','bold','FontSize',18, 'FitBoxToText','on','LineStyle','none','EdgeColor',[1 1 1],'LineWidth',8,'Color',[1 1 1]);
                
                F(f) = getframe(fig1);
                fprintf('%d/%d\n', f, numel(imageNames_Vid1));
            end
            
            VidObj = VideoWriter(vidSaveName, 'Motion JPEG AVI');
            %DS_vidObj.FrameRate = 3;
            %DS_vidObj.Quality=  75;
            
            tic
            disp('Saving movie...');
            open(VidObj)
            writeVideo(VidObj, F);
            close(VidObj)
            disp(['Saved file: ' vidSaveName]);
            toc
            
            
            
        end
        
        function [] = createMontageFromVideo(obj)
            
            videoToLoad = '/storage/laur/Data_2/chronicLizardExp/lizard4/09.15.2015/21-43-27_videos/Lizard-001-MatroxCam-2015-Sep-16-sub-1-fullFile-Converted--1-428061.avi'
            
            vidObj = VideoReader(videoToLoad);
            
            %videoReader = vision.VideoFileReader(videoToLoad,'ImageColorSpace','Intensity','VideoOutputDataType','uint8'); % create required video objects
            %converter = vision.ImageDataTypeConverter;
            
            vidHeight = vidObj .Height;
            vidWidth = vidObj .Width;
            
            frameRate = vidObj .FrameRate;
            nFrames = size(read(vidObj , inf), 1);
            
            %%
            FR_overWrite = 10;
            
            montageStartFrame = 1;
            montageEndFrame = 500;
            montageResolution = 10; % in s
            
            FramesPerResol = montageResolution*frameRate;
            
            FramesToGrab = montageStartFrame:FramesPerResol:montageEndFrame;
            nFramesToGrab = numel(FramesToGrab);
            
            %%
            
            mov(1:nFramesToGrab) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap',[]);
            Head = [];
            for j = 1:nFramesToGrab
                
                thisFrame = FramesToGrab(j);
                
                if thisFrame <= nFrames
                    
                    %bla = step(vidObj, thisFrame)
                    
                    %frame = step(videoReader);
                    %im = step(converter, frame);
                    
                    IMG = read(vidObj, thisFrame);
                    
                    mov(j).cdata = rgb2gray(read(vidObj,thisFrame));
                    
                    head = rgb2gray(IMG);
                    Head(:,:,j) = head;
                end
            end
            
            
            
            F(1:(nFrames-2)*nFramesToTake) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
            
            
            
            %%
            
            
            Head = reshape(Head,[size(Head,1),size(Head,2),1,size(Head,3)]);
            figure
            montage(Head)
            
            
            figure
            imagesc(IMG)
            figure
            imagesc(rgb2gray(IMG))
            
            
            data = read(VideoObj, k);
            
            F(k) = getframe(fig1);
            
            
            
            
            hf = figure(100);
            set(hf, 'position', [150 150 vidWidth vidHeight])
            
            movie(hf, mov, 1, 1);
            
            %%
            Head = [];
            fig1 = figure(2)
            for j = 1:nFramesToGrab
                im = mov(j).cdata;
                
                imshow(mov(j).cdata)
                F(j) = getframe(fig1);
                
                
                montagePlot(:,:,j,:) = mov.cdata;
                
                Head(:,:,j)=im;
                
            end
            Head = reshape(F,[size(F,1),size(F,2),1,size(F,3)]);
            bla = Head.cdata;
            
            %% montage plot
            
            montagePlot = mov.cdata;
            fig1 = figure(5);
            montage(Head);
            
            
            
            
            
        end
        
        
        
        function [] = cropImageCreateMontage(obj, ImgDir, fileFormat)
            
            
            [pathstr,name1,ext] = fileparts(ImgDir{:});
            
            
            saveDir = [obj.PATH.editedVidPath];
            saveName = [saveDir 'montage'];
            %fileFormat = 1; % (1)- tif, (2) -.jpg
            
            %%
            switch fileFormat
                case 1
                    imgFormat = '*.tif';
                case 2
                    imgFormat = '*.jpg';
            end
            
            %% Reverse or Forward
            
            imageNames = dir(fullfile(ImgDir{:},imgFormat));
            imageNames = {imageNames.name}';
            
            startFrame = imageNames{1}(1:end-4);
            endFrame = imageNames{end}(1:end-4);
            
            matchIndsStart = cellfun(@(x) strfind(x, startFrame), imageNames, 'UniformOutput', 0);
            matchIndsStartInd = find(cellfun(@(x) ~isempty(x), matchIndsStart)==1);
            
            matchIndsEnd = cellfun(@(x) strfind(x, endFrame), imageNames, 'UniformOutput', 0);
            matchIndsEndInd = find(cellfun(@(x) ~isempty(x), matchIndsEnd)==1);
            
            
            framesToGrab = matchIndsStartInd:1:matchIndsEndInd; % forward playback
            
            fig1 = figure(100);clf
            img_tmp1 = imread([ImgDir{:} obj.HOST.dirD imageNames{1}]);
            [J, rect] = imcrop(img_tmp1);
            
            
            %%
            cnt = 1;
            
            for f = framesToGrab
                img_tmp1 = imread([ImgDir{:} obj.HOST.dirD imageNames{f}]);
                
                if fileFormat == 1
                    img1 = im2uint8(img_tmp1); % need to convert for .tif files
                elseif fileFormat ==2
                    img1 = img_tmp1;
                end
                
                img_crop =  imcrop(img_tmp1,rect);
                
                eval(['img' num2str(cnt) '=img_crop;'])
                cnt =cnt+1;
            end
            
            
            
            %  multi = cat(3, img2, img3, img4, img5,img6,img7,img8,img9,img10);
            multi = horzcat(img2, img3, img4, img5,img6,img7,img8,img9,img10);
            
            figure(100); clf
            
            image(multi)
            %montage(multi)
            axis('off')
            pause
            %%
            saveName = [obj.PATH.editedVidPath 'montage'];
            plotpos = [0 0 30 5];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            
            
        end
        
        
        
        function [obj] = testVideos(obj)
            dbstop if error
            vidToLoad = obj.PATH.VidPath;
            nVids = numel(vidToLoad);
            
            obj.VID.nVids = nVids;
            
            for j = 1:nVids
                
                VideoObj = VideoReader(vidToLoad{j});
                [pathstr,name,ext] = fileparts(vidToLoad{j}) ;
                
                obj.VID(j).name = name;
                obj.VID(j).ext = ext;
                
                obj.VID.textName = name(end-7:end);
                
                disp(['Loaded Video: ' vidToLoad{j}])
                
                obj.VID(j).nFrames = VideoObj.NumberOfFrames;
                disp(['Numer of Frames: ' num2str(VideoObj.NumberOfFrames)])
                
                obj.VID(j).Duration = VideoObj.Duration;
                disp(['Duration: ' num2str(VideoObj.Duration)])
                
                obj.VID(j).VideoFrameRate = VideoObj.FrameRate;
                disp(['Frame Rate: ' num2str(VideoObj.FrameRate)])
                
                obj.VID(j).vidHeight = VideoObj.Height;
                disp(['Height: ' num2str(VideoObj.Height)])
                
                obj.VID(j).vidWidth = VideoObj.Width;
                disp(['Width: ' num2str(VideoObj.Width)])
                
                obj.VID(j).vidFormat = VideoObj.VideoFormat;
                disp(['Video Format: ' VideoObj.VideoFormat])
                
            end
            
        end
        
        function [] = makeFastMoviesWithClock(obj, startFrame, endFrame, clockRate_s)
            
            
            [pathstr,name,ext] = fileparts(obj.PATH.VidPath{:});
            movieDir = [pathstr obj.HOST.dirD];
            
            editName = [name '__DS-clock' ext];
            editMoviePath = [movieDir editName];
            
            thisMovie = obj.PATH.VidPath{:};
            
            %% Create Video Reader Object
            
            disp('Creating Video Object...')
            
            tic
            
            VideoObj = VideoReader(thisMovie, 'Tag', 'CurrentVideo');
            
            toc
            
            
            %V = obj.VID;
            vidHeight = VideoObj.Height;
            vidWidth = VideoObj.Width;
            %nFrames = VideoObj.nFrames;
            VidFrameRate = VideoObj.FrameRate;
            %vidFormat =  V.vidFormat;
            %VidDuration = V.Duration;
            
            time_per_frame = 1/VidFrameRate; % in seconds
            framesToSkip = round(clockRate_s/time_per_frame);
            
            framesToGrab = startFrame:framesToSkip:endFrame;
            nFrames = numel(framesToGrab);
            
            %nDSFrames = floor(nFrames/framesPerMin);
            
            %% Start for loop
            
            fig1 = figure(100);clf
            
            F(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
            
            disp('Outputting frames to figures...')
            
            tic
            
            for k = 1:nFrames
                
                frame = framesToGrab(k);
                
                
                %currTime_txt = [num2str(roundn(time_per_frame*thisFrame, -2)) ' s'] ;
                currTime_txt_s = [num2str(round(time_per_frame*frame - time_per_frame*framesToGrab(1))) ' s'] ;
                currTime_txt_min = [num2str(round((time_per_frame*frame - time_per_frame*framesToGrab(1))/60)) ' min'] ;
                
                data = read(VideoObj, frame);
                image(data)
                axis('off')
                annotation(fig1,'textbox', [0.80 0.08 0.2 0.1], 'String',currTime_txt_min, 'FontWeight','bold','FontSize',18, 'FitBoxToText','on','LineStyle','none','EdgeColor',[1 1 1],'LineWidth',8,'Color',[1 1 1]);
                
                F(k) = getframe(fig1);
                k
                clf
            end
            toc
            
            %% Save the movie output
            
            saveName = [obj.PATH.editedVidPath  'clock.avi'];
            
            DS_vidObj = VideoWriter(saveName, 'Motion JPEG AVI');
            DS_vidObj.FrameRate = 1;
            DS_vidObj.Quality=  100;
            
            tic
            disp('Saving movie...');
            open(DS_vidObj)
            writeVideo(DS_vidObj, F);
            close(DS_vidObj)
            disp(['Saved file: ' saveName]);
            toc
            
            clear('F');
            
        end
        
        function [] = calcOFOnDefinedRegion(obj)
            
            videoToAnalyze = obj.PATH.VidPath{:};
            OFDir = [obj.PATH.editedVidPath];
            
            %% Load Video
            
            vidToLoad = videoToAnalyze;
            [pathstr,name,ext] = fileparts(vidToLoad);
            OFSaveName = ['OF-FullFile-' name];
            
            %%
            VideoObj = VideoReader(vidToLoad, 'Tag', 'CurrentVideo');
            
            nFrames = VideoObj.NumberOfFrames;
            VideoFrameRate = VideoObj.FrameRate;
            vidHeight = VideoObj.Height;
            vidWidth = VideoObj.Width;
            vidFormat = VideoObj.VideoFormat;
            
            %% if more than 10000 frames...
            FrameCut = 10000;
            
            if nFrames > FrameCut;
                tOn = 1:FrameCut:nFrames;
                nParts = numel(tOn);
            end
            %%
            videoReader = vision.VideoFileReader(vidToLoad,'ImageColorSpace','Intensity','VideoOutputDataType','uint8'); % create required video objects
            converter = vision.ImageDataTypeConverter;
            opticalFlow1 = vision.OpticalFlow('Method','Lucas-Kanade','ReferenceFrameDelay', 1);% use of the Lucas-Kanade method for optic flow determination
            opticalFlow2 = vision.OpticalFlow('Method','Lucas-Kanade','ReferenceFrameDelay', 1);% use of the Lucas-Kanade method for optic flow determination
            opticalFlow1.OutputValue = 'Horizontal and vertical components in complex form';
            opticalFlow2.OutputValue = 'Horizontal and vertical components in complex form';
            mCnt = 1;
            
            disp('Extracting frames and calculating the optic flow...')
            
            for p = 1:nParts
                
                FrameOn = tOn(p);
                FrameOff = tOn(p)+FrameCut-1;
                
                if p== nParts
                    FrameOff =nFrames;
                end
                
                mov = struct('cdata',[],'colormap',[]);
                for frame_ind = FrameOn+1 : FrameOff+1
                    
                    mov(mCnt).cdata = read(VideoObj,frame_ind);
                    frame = mov(mCnt).cdata;
                    im = step(converter, frame);
                    if mCnt == 1
                        figure
                        imshow(im) %open the first frame
                        %disp('Select 1st ROI')
                        
                        %% Define ROI
                        rectim1 = getrect; %choose right eye ROI
                        rectim1=ceil(rectim1);
                        
                        %Hardcoded
                        %disp('Using hardcoded ROI')
                        %rectim1 =  [5 243 958 576];
                        
                    end
                    im1 = im(rectim1(2):rectim1(2)+rectim1(4),rectim1(1):rectim1(1)+rectim1(3)); %choose this ROI part of the frame to calculate the optic flow
                    of1 = step(opticalFlow1, im1);
                    V1=abs(of1); % lenght of the velocity vector
                    meanV1=mean(mean(V1)); %mean velocity for every pixel
                    fV1(mCnt)=meanV1;
                    mCnt =mCnt +1;
                    disp(strcat('Frame: ',num2str(frame_ind ),' is done'))
                end
                
                fV1(1)=0; % suppress the artifact at the first frame
                save([OFDir OFSaveName '_pt-' sprintf('%02d',p) '.mat'], 'fV1', 'rectim1', 'im');
                clear('fV1');
            end
            
        end
        
        
        function [] = calcOFOnDefinedRegion_DS(obj, dsFrameRate, FrameRateOverride)
            
            if nargin < 3
                FrameRateOverride = [];
            end
            
                
            videoToAnalyze = obj.PATH.VidPath{:};
            
            vidToLoad = videoToAnalyze;
            [pathstr,name,ext] = fileparts(vidToLoad);
            OFSaveName = ['OF-FullFile-' name];
            
            OFDir = [obj.PATH.editedVidPath 'OF_DS-' name obj.HOST.dirD];
            
            if exist(OFDir, 'dir') ==0
                mkdir(OFDir);
                disp(['Created directory: ' OFDir])
            end
            
            %% Load Video
            
            
            
            %%
            VideoObj = VideoReader(vidToLoad, 'Tag', 'CurrentVideo');
            
            nFrames = VideoObj.NumberOfFrames;
            if isempty(FrameRateOverride)
                VideoFrameRate = VideoObj.FrameRate;
            else
                VideoFrameRate = FrameRateOverride;
            end
            
            vidHeight = VideoObj.Height;
            vidWidth = VideoObj.Width;
            vidFormat = VideoObj.VideoFormat;
            
            
            frameSkip = VideoFrameRate/dsFrameRate;
            
            thisStart = 1;
            thisStop = nFrames;
            
            movieLengthFull = thisStop-thisStart;
            newNFrames = floor(movieLengthFull/frameSkip);
            
            %             mov(1:newNFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
            %
            %             cnt = thisStart;
            %             for k = 1 : newNFrames +1
            %                 mov(k).cdata = read(vidReaderObj, cnt);
            %                 fprintf('%d/%d // %d\n', cnt, thisStop, k);
            %                 cnt = cnt+frameSkip;
            %             end
            %
            %
            
            %% if more than 10000 frames...
            FrameCut = VideoFrameRate*60*60; % 1 hour
            
            if nFrames > FrameCut;
                tOn = 1:FrameCut:nFrames;
                nParts = numel(tOn);
            else
                tOn = 1;
                nParts =1;
            end
            %%
            videoReader = vision.VideoFileReader(vidToLoad,'ImageColorSpace','Intensity','VideoOutputDataType','uint8'); % create required video objects
            converter = vision.ImageDataTypeConverter;
            opticalFlow1 = vision.OpticalFlow('Method','Lucas-Kanade','ReferenceFrameDelay', 1);% use of the Lucas-Kanade method for optic flow determination
            opticalFlow1.OutputValue = 'Horizontal and vertical components in complex form';
         
            
            disp('Extracting frames and calculating the optic flow...')
            cnt = 1;
            for p = 1:nParts
                
                FrameOn = tOn(p);
                FrameOff = tOn(p)+FrameCut;
                
                if p== nParts
                    FrameOff =nFrames;
                end
                
                mCnt = 1;
                
                mov = struct('cdata',[],'colormap',[]);
                for frame_ind = FrameOn : frameSkip: FrameOff
                    
                    mov(mCnt).cdata = read(VideoObj,frame_ind);
                    frame = mov(mCnt).cdata;
                    im = step(converter, frame);
                    if cnt == 1
                        
                        test_frame = read(VideoObj,50);
                        
                        test_Im = step(converter, test_frame);
                        
                        figure
                        
                        imshow(test_Im) %open the first frame
                        %disp('Select 1st ROI')
                        
                        %% Define ROI
                        rectim1 = getrect; %choose right eye ROI
                        rectim1=ceil(rectim1);
                        
                        %Hardcoded
                        %disp('Using hardcoded ROI')
                        %rectim1 =  [5 243 958 576];
                        
                    end
                    im1 = im(rectim1(2):rectim1(2)+rectim1(4),rectim1(1):rectim1(1)+rectim1(3)); %choose this ROI part of the frame to calculate the optic flow
                    of1 = step(opticalFlow1, im1);
                    V1=abs(of1); % lenght of the velocity vector
                    meanV1=mean(mean(V1)); %mean velocity for every pixel
                    fV1(mCnt)=meanV1;
                    mCnt = mCnt +1;
                    cnt = cnt + 1;
                    disp(strcat('Frame: ',num2str(frame_ind ),' is done'))
                end
                
                fV1(1)=0; % suppress the artifact at the first frame
                save([OFDir OFSaveName '_pt-' sprintf('%02d',p) '.mat'], 'fV1', 'rectim1', 'im');
                clear('fV1');
            end
            
        end
        
        function [] = calcOFOnDefinedRegion_DS_multipleFilesInDir(obj, dsFrameRate, vidDir, vidFrameRate, saveTag)
            
            
            
            vidNames = dir(fullfile(vidDir,'*.avi'));
            vidNames = {vidNames.name}';
            
            nVids = numel(vidNames);
            OFDir = [vidDir 'OF_DS' ];
            
            if exist(OFDir, 'dir') ==0
                mkdir(OFDir);
                disp(['Created directory: ' OFDir])
            end
            
            cnt = 1;
            for o = 1:nVids
                
                %% Load Video
                
                vidToLoad = [vidDir vidNames{o}];
                [pathstr,name,ext] = fileparts(vidToLoad);
                OFSaveName = ['OF-' name saveTag];
                
                %%
                VideoObj = VideoReader(vidToLoad, 'Tag', 'CurrentVideo');
                
                nFrames = VideoObj.NumberOfFrames;
                VideoFrameRate = VideoObj.FrameRate;
                vidHeight = VideoObj.Height;
                vidWidth = VideoObj.Width;
                vidFormat = VideoObj.VideoFormat;
                
                
                frameSkip = VideoFrameRate/dsFrameRate;
                
                %thisStart = 1;
                %thisStop = nFrames;
                
                %movieLengthFull = thisStop-thisStart;
                %newNFrames = floor(movieLengthFull/frameSkip);
                
                
                %% if more than 10000 frames...
                %             FrameCut = VideoFrameRate*60*60; % 1 hour
                
                %             if nFrames > FrameCut
                %                 tOn = 1:FrameCut:nFrames;
                %                 nParts = numel(tOn);
                %             else
                %tOn = 1;
                %nParts = numel(tOn);
                %             end
                %%
                videoReader = vision.VideoFileReader(vidToLoad,'ImageColorSpace','Intensity','VideoOutputDataType','uint8'); % create required video objects
                converter = vision.ImageDataTypeConverter;
                opticalFlow1 = vision.OpticalFlow('Method','Lucas-Kanade','ReferenceFrameDelay', 1);% use of the Lucas-Kanade method for optic flow determination
                opticalFlow1.OutputValue = 'Horizontal and vertical components in complex form';
                
                disp('Extracting frames and calculating the optic flow...')
                
                FrameOn = 1;
                FrameOff =nFrames;
                
                %                 if p== nParts
                %                     FrameOff =nFrames;
                %                 end
                
                mCnt = 1;
                
                mov = struct('cdata',[],'colormap',[]);
                for frame_ind = FrameOn : frameSkip: FrameOff
                    
                    mov(mCnt).cdata = read(VideoObj,frame_ind);
                    frame = mov(mCnt).cdata;
                    im = step(converter, frame);
                    if cnt == 1
                        figure
                        imshow(im) %open the first frame
                        %disp('Select 1st ROI')
                        
                        %% Define ROI
                        rectim1 = getrect; %choose right eye ROI
                        rectim1=ceil(rectim1);
                        
                        %Hardcoded
                        %disp('Using hardcoded ROI')
                        %rectim1 =  [5 243 958 576];
                        
                    end
                    im1 = im(rectim1(2):rectim1(2)+rectim1(4),rectim1(1):rectim1(1)+rectim1(3)); %choose this ROI part of the frame to calculate the optic flow
                    of1 = step(opticalFlow1, im1);
                    V1=abs(of1); % lenght of the velocity vector
                    meanV1=mean(mean(V1)); %mean velocity for every pixel
                    fV1(mCnt)=meanV1;
                    mCnt = mCnt +1;
                    cnt = cnt + 1;
                    disp(strcat('Frame: ',num2str(frame_ind ),' is done'))
                end
                
                fV1(1)=0; % suppress the artifact at the first frame
                %save([OFDir OFSaveName '_pt-' sprintf('%02d',o) '.mat'], 'fV1', 'rectim1', 'im');
                save([OFDir OFSaveName '.mat'], 'fV1', 'rectim1', 'im');
                clear('fV1');
            end
            
        end
        
        
        function [] = loadMultipleOFDetectionsAndMakePlot(obj, detectionsDir, dsFrameRate, StartingClockTime, StartingAlignmentTime )
            
            
            FV1 = load(detectionsDir{1});
            FV2 = load(detectionsDir{2});
            
            FV_roi1 = FV1.fV1_norm;
            FV_roi2 = FV2.fV1_norm;
            
            
            %% Assumes a fps of 1 fps
            
            smoothmin =2;
            
            smoothWin = smoothmin *60 * dsFrameRate;
            smoothedOF_roi1 = smooth(FV_roi1, smoothWin);
            smoothedOF_roi2 = smooth(FV_roi2, smoothWin);
            
            npnts_roi1 = numel(smoothedOF_roi1);
            npnts_roi2 = numel(smoothedOF_roi2);
            
            %%
            
            if npnts_roi1 < npnts_roi2
                timepoints_s = 1:1:numel(smoothedOF_roi1);
                timepoints_hrs = timepoints_s/3600;
                roi = 1:npnts_roi1;
            elseif npnts_roi2 < npnts_roi1
                timepoints_s = 1:1:numel(npnts_roi2);
                timepoints_hrs = timepoints_s/3600;
                roi = 1:npnts_roi2;
            end
            
            %%
            
            
            colon = ':';
            sInMin = 60;
            minInHr = 60;
            sInHr = sInMin*minInHr;
            Day_24Hr = 24;
            zero = 0;
            
            thisStr = StartingAlignmentTime;
            match = find(thisStr == colon);
            
            Alignment_s_vid = str2double(thisStr(match(2)+1:end));
            Alignment_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
            Alignment_hrs_vid = str2double(thisStr(1:match(1)-1));
            
            thisStr = StartingClockTime;
            match = find(thisStr == colon);
            
            FirstStart_s_vid = str2double(thisStr(match(2)+1:end));
            FirstStart_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
            FirstStart_hrs_vid = str2double(thisStr(1:match(1)-1));
            
            Alignment_diff_s = FirstStart_s_vid - Alignment_s_vid;
            
            Alignment_diff_s_cnt = 0;
            if Alignment_diff_s > 0
                FirstStart_mins_vid = FirstStart_mins_vid+1;
                Alignment_diff_s_cnt = sInMin - Alignment_diff_s;
            else
                Alignment_diff_s_cnt = Alignment_diff_s;
            end
            
            diff_min = minInHr - FirstStart_mins_vid;
            
            if diff_min > 0
                FirstStart_hrs_vid = FirstStart_hrs_vid +1;
                Alignment_diff_s_for_min = (minInHr - diff_min)*sInMin;
                Alignment_diff_s_cnt = Alignment_diff_s_for_min + Alignment_diff_s_cnt;
            end
            
            diff_hr = FirstStart_hrs_vid - Alignment_hrs_vid;
            
            if diff_hr < 0
                
                %Alignment_diff_min_for_hrs = (minInHr - diff_min)*sInMin;
                Alignment_diff_s_for_hrs = abs(diff_hr)*minInHr*sInMin;
                Alignment_diff_s_cnt = Alignment_diff_s_cnt +Alignment_diff_s_for_hrs;
            elseif diff_hr > 0
                disp('please choose a later start time')
                keyboard
            end
            
            nSecondsToFirstAlignment = Alignment_diff_s_cnt;
            
            xtickts = nSecondsToFirstAlignment:sInHr:numel(roi);
            
            xLab_pt1 = Alignment_hrs_vid:1:24;
            xLab_pt2  = 1:1:24;
            xlabs_n = [xLab_pt1 xLab_pt2];
            
            theseLabs = xlabs_n(1:numel(xtickts));
            
            xlabs = [];
            for k = 1:numel(xtickts)
                xlabs{k} = [num2str(theseLabs(k)) ':00'];
            end
            
            
            %%
            
            col1 = [0.3 0.5 0.8];
            col2 = [0.8 0.5 0.3];
            
            figH = figure(400); clf
            
            plot(timepoints_hrs, smoothedOF_roi1(roi), 'color', col1, 'linewidth', 1.5);
            
            hold on
            plot(timepoints_hrs, smoothedOF_roi2(roi), 'color', col2, 'linewidth', 1.5);
            
            ylim([0 1])
            axis tight
            set(gca, 'xtick', xtickts/sInHr);
            set(gca, 'xtickLabel',  xlabs)
            xlabel('Time [Hr]')
            ylabel('Normalized OF')
            title(['Normalized OF, 1s | smooth = ' num2str(smoothmin) ' min'])
            legend({'ROI 1', 'ROI 2'})
            legend('boxoff')
            %%
            %OFImg = getframe(figH);
            %im = OF.im;
            %image(im)
            %FImg = getframe(figH);
            %hcat = horzcat([OFImg.cdata FImg.cdata]);
            %image(hcat)
            %ylim([0 0.5])
            
            saveName = [obj.PATH.editedVidPath  'ROIComebo_OF_DSs1'];
            plotpos = [0 0 25 12];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            
            %%
            
        end
        
        
        
        function [] = loadDetectionsAcrossDaysAndMakePlots(obj, OFdir, dsFrameRate)
            
            searchDir = '*.mat*';
            
            filesInDir = dir(fullfile(OFdir, searchDir));
            nFilesinDir = numel(filesInDir);
            
            for j=1:nFilesinDir
                fileNames{j} = filesInDir(j).name;
            end
            
            smoothWin_s = 60;
            
            for j = 1:nFilesinDir
                f = load([OFdir fileNames{j}]);
                
                allFV{j} = f.fV1;
                allSmoothFV{j} = smooth(allFV{j},smoothWin_s);
                
                allFVClock{j} = f.Clock.StartingClockTime;
                allFVMax(j) = max(allSmoothFV{j});
            end
            
            allDurations = cellfun(@(x) numel(x),allFV);
            maxDur = max(allDurations);
            minDur = min(allDurations);
            maxFVVal = max(allFVMax);
            
            
            %StartingAlignmentTime = '12:00:00';
            StartingAlignmentTime = '24:00:00';
            
            
            colon = ':';
            sInMin = 60;
            minInHr = 60;
            sInHr = sInMin*minInHr;
            Day_24Hr = 24;
            zero = 0;
            
            thisStr = StartingAlignmentTime;
            match = find(thisStr == colon);
            
            Alignment_s_vid = str2double(thisStr(match(2)+1:end));
            Alignment_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
            Alignment_hrs_vid = str2double(thisStr(1:match(1)-1));
            
            
            for j = 1:nFilesinDir
                
                StartingClockTime = allFVClock{j};
                
                thisStr = StartingClockTime;
                match = find(thisStr == colon);
                
                FirstStart_s_vid = str2double(thisStr(match(2)+1:end));
                FirstStart_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
                FirstStart_hrs_vid = str2double(thisStr(1:match(1)-1));
                
                %Alignment_diff_s = FirstStart_s_vid - Alignment_s_vid;
                
                Alignment_diff_s_cnt = 0;
                %                 if Alignment_diff_s > 0
                %                     FirstStart_mins_vid = FirstStart_mins_vid+1;
                %                     Alignment_diff_s_cnt = sInMin - Alignment_diff_s;
                %                 else
                %                     Alignment_diff_s_cnt = Alignment_diff_s;
                %                 end
                
                diff_min = minInHr - FirstStart_mins_vid;
                
                if diff_min > 0
                    Alignment_diff_s_for_min = diff_min*sInMin;
                    Alignment_diff_s_cnt = Alignment_diff_s_for_min+Alignment_diff_s_cnt;
                    FirstStart_hrs_vid = FirstStart_hrs_vid+1;
                end
                
                diff_hr = Alignment_hrs_vid - FirstStart_hrs_vid;
                
                if diff_hr > 0
                    
                    Alignment_diff_s_for_hrs = abs(diff_hr)*minInHr*sInMin;
                    Alignment_diff_s_cnt = Alignment_diff_s_cnt +Alignment_diff_s_for_hrs;
                    
                end
                
                nSecondsToFirstAlignment = Alignment_diff_s_cnt;
                
                alignment_S(j) = nSecondsToFirstAlignment;
                
                
            end
            
            maxAlignmentTime = max(alignment_S);
            zeroPadded = [];
            for j = 1:nFilesinDir
                
                diffTolongest = maxAlignmentTime - alignment_S(j);
                
                %zeroPadded{j} = [nan(1, diffTolongest) allFV{j}];
                zeroPadded{j} = [nan(1, diffTolongest) allSmoothFV{j}'];
            end
            
            allPaddedDurations = cellfun(@(x) numel(x),zeroPadded);
            
            maxPaddedDur = max(allPaddedDurations);
            
            
            for j = 1:nFilesinDir
                
                diffTolongest = maxPaddedDur - allPaddedDurations(j);
                zeroPaddedFinal{j} = [ zeroPadded{j} nan(1, diffTolongest)];
            end
            
            totalDuration = numel(zeroPaddedFinal{1});
            %%
            figH = figure(100); clf
            offset = 0;
            subplot(3, 1, [1 2])
            for j = 1:nFilesinDir
                
                thisFV = zeroPaddedFinal{j};
                thisFV_norm = thisFV./maxFVVal;
                hold on
                plot(thisFV_norm-nanmean(thisFV_norm) + offset, 'k')
                
                allVals(j,:) = abs(thisFV_norm-nanmean(thisFV_norm));
                
                offset = offset+0.03;
                
            end
            
            %%
            %StartingClockTime = allFVClock{1};
            StartingClockTime = allFVClock{8};
            StartingAlignmentTime = '17:00:00';
            %StartingAlignmentTime = '09:00:00';
            
            
            thisStr = StartingAlignmentTime;
            match = find(thisStr == colon);
            
            Alignment_s_vid = str2double(thisStr(match(2)+1:end));
            Alignment_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
            Alignment_hrs_vid = str2double(thisStr(1:match(1)-1));
            
            
            thisStr = StartingClockTime;
            match = find(thisStr == colon);
            
            FirstStart_s_vid = str2double(thisStr(match(2)+1:end));
            FirstStart_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
            FirstStart_hrs_vid = str2double(thisStr(1:match(1)-1));
            
            Alignment_diff_s_cnt = 0;
            %                 if Alignment_diff_s > 0
            %                     FirstStart_mins_vid = FirstStart_mins_vid+1;
            %                     Alignment_diff_s_cnt = sInMin - Alignment_diff_s;
            %                 else
            %                     Alignment_diff_s_cnt = Alignment_diff_s;
            %                 end
            
            diff_min = minInHr - FirstStart_mins_vid;
            
            if diff_min > 0
                Alignment_diff_s_for_min = diff_min*sInMin;
                Alignment_diff_s_cnt = Alignment_diff_s_for_min+Alignment_diff_s_cnt;
                FirstStart_hrs_vid = FirstStart_hrs_vid+1;
            end
            
            diff_hr = Alignment_hrs_vid - FirstStart_hrs_vid;
            
            if diff_hr > 0
                
                Alignment_diff_s_for_hrs = abs(diff_hr)*minInHr*sInMin;
                Alignment_diff_s_cnt = Alignment_diff_s_cnt +Alignment_diff_s_for_hrs;
                
            end
            
            nSecondsToFirstAlignment = Alignment_diff_s_cnt;
            
            
            
            xtickts = nSecondsToFirstAlignment:sInHr:totalDuration;
            
            xLab_pt1 = Alignment_hrs_vid:1:24;
            xLab_pt2  = 1:1:24;
            xlabs_n = [xLab_pt1 xLab_pt2 xLab_pt2 xLab_pt2];
            
            theseLabs = xlabs_n(1:numel(xtickts));
            
            xlabs = [];
            for k = 1:numel(xtickts)
                xlabs{k} = [num2str(theseLabs(k)) ':00'];
            end
            
            axis tight
            set(gca, 'xtick', xtickts);
            set(gca, 'xtickLabel',  xlabs)
            
            xlim([nSecondsToFirstAlignment+3600*4 nSecondsToFirstAlignment+3600*16])
            %xlim([nSecondsToFirstAlignment nSecondsToFirstAlignment+3600*12])
            grid('on')
            xlabel('Clock  Time')
            
            ylabel('Nights')
            %ylabel('Days')
            ylim([-0.01 0.35])
            %ylim([-0.01 0.2])
            set(gca, 'ytick', []);
            %title('Activity during day')
            title('Activity during night')
            
            subplot(4, 1, 4)
            allmeans = nanmean(allVals, 1);
            
            %allmeans2 = nanmean(allVals(1:3,:), 1);
            plot(allmeans, 'k', 'linewidth', 1.5)
            axis tight
            set(gca, 'xtick', xtickts);
            set(gca, 'xtickLabel',  xlabs)
            xlabel('Clock  Time')
            hold on
            %plot(allmeans2, 'b', 'linewidth', 1.5)
            ylim([0 0.013])
            set(gca, 'ytick', []);
            xlim([nSecondsToFirstAlignment+3600*4 nSecondsToFirstAlignment+3600*16])
            %xlim([nSecondsToFirstAlignment nSecondsToFirstAlignment+3600*12])
            
            grid('on')
            
            saveName = [obj.PATH.editedVidPath  'MultipleNights'];
            %saveName = [obj.PATH.editedVidPath  'MultipleDays-2'];
            plotpos = [0 0 45 15];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            
            %%
            
        end
        
        
        
        
        function [] = loadDetectionsCalcMvmtAcrossDaysAndMakePlots(obj, OFdir, dsFrameRate)
            
            searchDir = '*.mat*';
            
            filesInDir = dir(fullfile(OFdir, searchDir));
            nFilesinDir = numel(filesInDir);
            
            for j=1:nFilesinDir
                fileNames{j} = filesInDir(j).name;
            end
            
            smoothWin_s = 3*60;
            
            for j = 1:nFilesinDir
                f = load([OFdir fileNames{j}]);
                
                FV = f.fV1;
                SmoothFV = smooth(FV,smoothWin_s);
                SmoothFV(1:3) = nan;
                
                allSmoothFV{j} = SmoothFV;
                allFV{j} = FV;
                allFVClock{j} = f.Clock.StartingClockTime;
                allFVMax(j) = max(allSmoothFV{j});
            end
            
            allDurations = cellfun(@(x) numel(x),allFV);
            maxDur = max(allDurations);
            minDur = min(allDurations);
            maxFVVal = max(allFVMax);
            
            
            %StartingAlignmentTime = '12:00:00';
            StartingAlignmentTime = '24:00:00';
            
            
            colon = ':';
            sInMin = 60;
            minInHr = 60;
            sInHr = sInMin*minInHr;
            Day_24Hr = 24;
            zero = 0;
            
            thisStr = StartingAlignmentTime;
            match = find(thisStr == colon);
            
            Alignment_s_vid = str2double(thisStr(match(2)+1:end));
            Alignment_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
            Alignment_hrs_vid = str2double(thisStr(1:match(1)-1));
            
            
            for j = 1:nFilesinDir
                
                StartingClockTime = allFVClock{j};
                
                thisStr = StartingClockTime;
                match = find(thisStr == colon);
                
                FirstStart_s_vid = str2double(thisStr(match(2)+1:end));
                FirstStart_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
                FirstStart_hrs_vid = str2double(thisStr(1:match(1)-1));
                
                %Alignment_diff_s = FirstStart_s_vid - Alignment_s_vid;
                
                Alignment_diff_s_cnt = 0;
                %                 if Alignment_diff_s > 0
                %                     FirstStart_mins_vid = FirstStart_mins_vid+1;
                %                     Alignment_diff_s_cnt = sInMin - Alignment_diff_s;
                %                 else
                %                     Alignment_diff_s_cnt = Alignment_diff_s;
                %                 end
                
                diff_min = minInHr - FirstStart_mins_vid;
                
                if diff_min > 0
                    Alignment_diff_s_for_min = diff_min*sInMin;
                    Alignment_diff_s_cnt = Alignment_diff_s_for_min+Alignment_diff_s_cnt;
                    FirstStart_hrs_vid = FirstStart_hrs_vid+1;
                end
                
                diff_hr = Alignment_hrs_vid - FirstStart_hrs_vid;
                
                if diff_hr > 0
                    
                    Alignment_diff_s_for_hrs = abs(diff_hr)*minInHr*sInMin;
                    Alignment_diff_s_cnt = Alignment_diff_s_cnt +Alignment_diff_s_for_hrs;
                    
                end
                
                nSecondsToFirstAlignment = Alignment_diff_s_cnt;
                
                alignment_S(j) = nSecondsToFirstAlignment;
                
                
            end
            
            maxAlignmentTime = max(alignment_S);
            zeroPadded = [];
            for j = 1:nFilesinDir
                
                diffTolongest = maxAlignmentTime - alignment_S(j);
                
                %zeroPadded{j} = [nan(1, diffTolongest) allFV{j}];
                zeroPadded{j} = [nan(1, diffTolongest) allSmoothFV{j}'];
            end
            
            allPaddedDurations = cellfun(@(x) numel(x),zeroPadded);
            
            maxPaddedDur = max(allPaddedDurations);
            
            
            for j = 1:nFilesinDir
                
                diffTolongest = maxPaddedDur - allPaddedDurations(j);
                zeroPaddedFinal{j} = [ zeroPadded{j} nan(1, diffTolongest)];
            end
            
            totalDuration = numel(zeroPaddedFinal{1});
            %%
            figH = figure(100); clf
            offset = 0;
            %subplot(3, 1, [1 2])
            
            win = 1*30*60;
            tOn = 1:win:numel(zeroPaddedFinal{1});
            
            for j = 1:nFilesinDir
                
                thisFV = zeroPaddedFinal{j};
                
                
%                 [idx,C] = kmeans(thisFV',2);
%                 
%                 if C(1) < C(2)
%                     mvmtC = 2;
%                     NomvmtC = 1;
%                 else
%                     mvmtC = 1;
%                     NomvmtC = 2;
%                 end
%                 
%                 mvmtInds = find(idx ==mvmtC);
%                 nonmvmntInds = find(idx ==NomvmtC);
%                 
%                 timepoints_hr = (1:1:numel(thisFV))/3600;
%                 mvmtsTimepoints = timepoints_hr(mvmtInds);
%                 yvals = ones(1, numel(mvmtsTimepoints))*0.005;
%                 figure(100); clf
%                 plot(timepoints_hr, thisFV)
%                 hold on
%                 plot(mvmtsTimepoints, yvals, 'r.')

                thisFV_norm = thisFV./maxFVVal;
%                 allThreshInds = [];
%                 for o = 1:numel(tOn)
%                     
%                     if o == numel(tOn)
%                     thisSnippet = thisFV_norm(tOn(o):numel(zeroPaddedFinal{1}));    
%                     else
%                         
%                     thisSnippet = thisFV_norm(tOn(o):tOn(o+1)-1);
%                     end
%                     
%                     thisStd = nanstd(thisSnippet);
%                     thresh = 5*thisStd;
%                     
%                     threshInds = find(thisSnippet > thresh);
%                     
%                     allThreshInds = [allThreshInds threshInds+tOn(o)];
%                     allThresh(o) = thresh;
%                 end
%                 
%                 figure; plot(thisFV_norm);
%                 hold on
%                 plot(allThreshInds, thisFV_norm(allThreshInds) ,'r*')
%                 
                
                
                
                %thisFV_norm = thisFV./(max(thisFV));
                
                hold on
                plot(thisFV_norm-nanmean(thisFV_norm) + offset, 'k')
                
                allVals(j,:) = abs(thisFV_norm-nanmean(thisFV_norm));
                
                offset = offset+0.03;
                
            end
            
         
            %%
            %StartingClockTime = allFVClock{1};
            StartingClockTime = allFVClock{8};
            StartingAlignmentTime = '17:00:00';
            %StartingAlignmentTime = '09:00:00';
            
            
            thisStr = StartingAlignmentTime;
            match = find(thisStr == colon);
            
            Alignment_s_vid = str2double(thisStr(match(2)+1:end));
            Alignment_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
            Alignment_hrs_vid = str2double(thisStr(1:match(1)-1));
            
            
            thisStr = StartingClockTime;
            match = find(thisStr == colon);
            
            FirstStart_s_vid = str2double(thisStr(match(2)+1:end));
            FirstStart_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
            FirstStart_hrs_vid = str2double(thisStr(1:match(1)-1));
            
            Alignment_diff_s_cnt = 0;
            %                 if Alignment_diff_s > 0
            %                     FirstStart_mins_vid = FirstStart_mins_vid+1;
            %                     Alignment_diff_s_cnt = sInMin - Alignment_diff_s;
            %                 else
            %                     Alignment_diff_s_cnt = Alignment_diff_s;
            %                 end
            
            diff_min = minInHr - FirstStart_mins_vid;
            
            if diff_min > 0
                Alignment_diff_s_for_min = diff_min*sInMin;
                Alignment_diff_s_cnt = Alignment_diff_s_for_min+Alignment_diff_s_cnt;
                FirstStart_hrs_vid = FirstStart_hrs_vid+1;
            end
            
            diff_hr = Alignment_hrs_vid - FirstStart_hrs_vid;
            
            if diff_hr > 0
                
                Alignment_diff_s_for_hrs = abs(diff_hr)*minInHr*sInMin;
                Alignment_diff_s_cnt = Alignment_diff_s_cnt +Alignment_diff_s_for_hrs;
                
            end
            
            nSecondsToFirstAlignment = Alignment_diff_s_cnt;
            
            
            
            xtickts = nSecondsToFirstAlignment:sInHr:totalDuration;
            
            xLab_pt1 = Alignment_hrs_vid:1:24;
            xLab_pt2  = 1:1:24;
            xlabs_n = [xLab_pt1 xLab_pt2 xLab_pt2 xLab_pt2];
            
            theseLabs = xlabs_n(1:numel(xtickts));
            
            xlabs = [];
            for k = 1:numel(xtickts)
                xlabs{k} = [num2str(theseLabs(k)) ':00'];
            end
            
            axis tight
            set(gca, 'xtick', xtickts);
            set(gca, 'xtickLabel',  xlabs)
            
            xlim([nSecondsToFirstAlignment+3600*4 nSecondsToFirstAlignment+3600*16])
            %xlim([nSecondsToFirstAlignment nSecondsToFirstAlignment+3600*12])
            grid('on')
            xlabel('Clock  Time')
            
            ylabel('Nights')
            %ylabel('Days')
            ylim([-0.01 0.3])
            %ylim([-0.01 0.2])
            set(gca, 'ytick', []);
            %title('Activity during day')
            title('Activity during night')
            
%             subplot(4, 1, 4)
%             allmeans = nanmean(allVals, 1);
%             
%             %allmeans2 = nanmean(allVals(1:3,:), 1);
%             plot(allmeans, 'k', 'linewidth', 1.5)
%             axis tight
%             set(gca, 'xtick', xtickts);
%             set(gca, 'xtickLabel',  xlabs)
%             xlabel('Clock  Time')
%             hold on
%             %plot(allmeans2, 'b', 'linewidth', 1.5)
%             ylim([0 0.01])
%             set(gca, 'ytick', []);
%             xlim([nSecondsToFirstAlignment+3600*4 nSecondsToFirstAlignment+3600*16])
%             %xlim([nSecondsToFirstAlignment nSecondsToFirstAlignment+3600*12])
            
            grid('on')
            
            saveName = [obj.PATH.editedVidPath  '10_MultipleNights'];
            %saveName = [obj.PATH.editedVidPath  'MultipleDays-2'];
            plotpos = [0 0 35 25];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            
            %%
               figure(102); clf
            
            minval = nanmedian(min(allVals));
            maxVal = nanmedian(max(allVals));
            imagesc(flipud(allVals), [minval maxVal])
            
            
            %colormap('pink')
            colormap('bone')
            colorbar
              axis tight
            set(gca, 'xtick', xtickts);
            set(gca, 'xtickLabel',  xlabs)
            
            xlim([nSecondsToFirstAlignment+3600*4 nSecondsToFirstAlignment+3600*16])
            %xlim([nSecondsToFirstAlignment nSecondsToFirstAlignment+3600*12])
            
            xlabel('Clock  Time')
            
            saveName = [obj.PATH.editedVidPath  '10_MultipleNightsimgsc'];
            %saveName = [obj.PATH.editedVidPath  'MultipleDays-2'];
            plotpos = [0 0 45 15];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            
            
            %%
            
        end
        
        
        
        function [] = loadOFDetectionsAndMakePlot(obj, detectionsDir, dsFrameRate, StartingClockTime, StartingAlignmentTime )
            
            
            searchDir = '*OF*';
            
            filesInDir = dir(fullfile(detectionsDir, searchDir));
            nFilesinDir = numel(filesInDir);
            
            for j=1:nFilesinDir
                fileNames{j} = filesInDir(j).name;
            end
            
            VidNameShort = fileNames{1}(end-18:end-11);
            
            %% Concatenate
            fV1 = [];
            for j = 1: nFilesinDir
                
                OF = load([detectionsDir fileNames{j}]);
                fV1 = [fV1 OF.fV1];
                
            end
            
            %               figure;
            %               subplot(1, 2, 1)
            %               plot(fV1)
            %               subplot(1, 2, 2)
            %               plot(fV2)
            
            
            
            fV1_norm = fV1./(max(max(fV1)));
            
            
            %% Assumes a fps of 1 fps
            
            smooth_s = 60;
            
            smoothWin = smooth_s*dsFrameRate;
            smoothedOF = smooth(fV1_norm, smoothWin);
            
            %%
            timepoints_s = 1:1:numel(fV1_norm);
            timepoints_hrs = timepoints_s/3600;
            
            %%
            
            
            colon = ':';
            sInMin = 60;
            minInHr = 60;
            sInHr = sInMin*minInHr;
            Day_24Hr = 24;
            zero = 0;
            
            thisStr = StartingAlignmentTime;
            match = find(thisStr == colon);
            
            Alignment_s_vid = str2double(thisStr(match(2)+1:end));
            Alignment_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
            Alignment_hrs_vid = str2double(thisStr(1:match(1)-1));
            
            thisStr = StartingClockTime;
            match = find(thisStr == colon);
            
            FirstStart_s_vid = str2double(thisStr(match(2)+1:end));
            FirstStart_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
            FirstStart_hrs_vid = str2double(thisStr(1:match(1)-1));
            
            Alignment_diff_s = FirstStart_s_vid - Alignment_s_vid;
            
            Alignment_diff_s_cnt = 0;
            if Alignment_diff_s > 0
                FirstStart_mins_vid = FirstStart_mins_vid+1;
                Alignment_diff_s_cnt = sInMin - Alignment_diff_s;
            else
                Alignment_diff_s_cnt = Alignment_diff_s;
            end
            
            diff_min = minInHr - FirstStart_mins_vid;
            
            if diff_min > 0
                FirstStart_hrs_vid = FirstStart_hrs_vid +1;
                Alignment_diff_s_for_min = diff_min*sInMin;
                Alignment_diff_s_cnt = Alignment_diff_s_for_min + Alignment_diff_s_cnt;
            end
            
            
            %
            %             diff_hr = FirstStart_hrs_vid - Alignment_hrs_vid;
            %
            %             if diff_hr < 0
            %
            %                 %Alignment_diff_min_for_hrs = (minInHr - diff_min)*sInMin;
            %                 Alignment_diff_s_for_hrs = abs(diff_hr)*minInHr*sInMin;
            %                 Alignment_diff_s_cnt = Alignment_diff_s_cnt +Alignment_diff_s_for_hrs;
            %             elseif diff_hr > 0
            %                 disp('please choose a later start time')
            %                 keyboard
            %             end
            
            nSecondsToFirstAlignment = Alignment_diff_s_cnt;
            
            xtickts = nSecondsToFirstAlignment:sInHr:numel(fV1_norm);
            
            xLab_pt1 = Alignment_hrs_vid:1:24;
            xLab_pt2  = 1:1:24;
            xlabs_n = [xLab_pt1 xLab_pt2 xLab_pt2 xLab_pt2];
            
            theseLabs = xlabs_n(1:numel(xtickts));
            
            xlabs = [];
            for k = 1:numel(xtickts)
                xlabs{k} = [num2str(theseLabs(k)) ':00'];
            end
            
            
            %%
            figH = figure(400); clf
            
            
            plot(timepoints_hrs, fV1_norm, 'color', [0.7 0.7 0.7]);
            hold on
            plot(timepoints_hrs, smoothedOF, 'k', 'linewidth', 1.5)
            
            axis tight
            set(gca, 'xtick', xtickts/sInHr);
            set(gca, 'xtickLabel',  xlabs)
            xlabel('Time [Hr]')
            ylabel('Normalized OF')
            title([VidNameShort ' | Normalized OF, 1s | smooth = ' num2str(smooth_s) ' s'])
            %%
            %OFImg = getframe(figH);
            %im = OF.im;
            %image(im)
            %FImg = getframe(figH);
            %hcat = horzcat([OFImg.cdata FImg.cdata]);
            %image(hcat)
            %ylim([0 0.25])
            
            saveName = [obj.PATH.editedVidPath  VidNameShort '_OF_DSs1'];
            plotpos = [0 0 25 12];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            print_in_A4(0, saveName, '-depsc', 0, plotpos);
            
            
            
            %% Save concat OF
            
            bluecolor = [0 50 150];
            shapeInserter1 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32(bluecolor));
            img1 = step(shapeInserter1,OF.im,OF.rectim1); %insert the ROIs
            
            figure(103); clf
            image(img1)
            axis off
            title(['Video: ' VidNameShort])
            
            saveName = [obj.PATH.editedVidPath  VidNameShort '_ROI_img'];
            plotpos = [0 0 15 12];
            print_in_A4(0, saveName, '-djpeg', 0, plotpos);
            
            %% Clock Info
            Clock.StartingClockTime = StartingClockTime;
            
            rectim1 = OF.rectim1;
            im = OF.im;
            save([obj.PATH.editedVidPath  VidNameShort '_OF_DSs1_fullFile.mat'], 'fV1', 'fV1_norm', 'img1', 'im', 'rectim1', 'dsFrameRate', 'Clock');
            clear('fV1');
            
            %%
            
        end
        
        
        
        %
        %
        % function [EventClockTime_hr, EventClockTime_min, EventClockTime_s] =  determineEventClockTime(offsetStartVideo_ms, StartClockTime, thisEventTime_ms)
        %
        % sInMin = 60;
        % minInHr = 60;
        % sInHr = sInMin*minInHr;
        % Day24Hr = 24;
        %
        % colon = ':';
        % thisStr = StartClockTime;
        % match = find(thisStr == colon);
        %
        % Start_s = str2double(thisStr(match(2)+1:end));
        % Start_mins = str2double(thisStr(match(1)+1:match(2)-1));
        % Start_hrs = str2double(thisStr(1:match(1)-1));
        %
        % thisEventTime_s = (thisEventTime_ms-offsetStartVideo_ms)/1000;
        %
        % nHrsToEvent = floor(thisEventTime_s/sInHr);
        % remaining_min_s = (thisEventTime_s - (nHrsToEvent*sInHr));
        %
        % nMinToEvent = floor(remaining_min_s/sInMin);
        % nSecToEvent = round(remaining_min_s - (nMinToEvent*sInMin));
        %
        %
        % EventTime_s = Start_s+ nSecToEvent;
        %
        % if EventTime_s > sInMin
        %     Start_mins = Start_mins +1; % add another minute
        %     diff_s = EventTime_s- sInMin;
        %     EventClockTime_s = diff_s;
        %
        % elseif EventTime_s < sInMin
        %     EventClockTime_s = EventTime_s;
        % end
        %
        % EventTime_min = Start_mins+ nMinToEvent;
        % if EventTime_min > minInHr
        %     Start_hrs = Start_hrs +1; % add another minute
        %     diff_min = EventTime_min- minInHr;
        %     EventClockTime_min = diff_min;
        %
        % elseif EventTime_min < minInHr
        %     EventClockTime_min = EventTime_min;
        % end
        %
        %
        % EventTime_hr = Start_hrs+ nHrsToEvent;
        % if EventTime_hr > Day24Hr
        %
        %     EventClockTime_hr = EventTime_hr- Day24Hr; % add another minute
        %
        % elseif EventTime_hr < Day24Hr
        %     EventClockTime_hr = EventTime_hr;
        % end
        %
        % disp('')
        %
        % end
        
        %
        %
        %
        %
        % StartingAlignmentTime = '21:00:00';
        %
        % thisStr = StartingAlignmentTime;
        % match = find(thisStr == colon);
        %
        % Alignment_s_vid = str2double(thisStr(match(2)+1:end));
        % Alignment_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
        % Alignment_hrs_vid = str2double(thisStr(1:match(1)-1));
        %
        % % Find first alignment point in data
        %
        %
        % FirstStartTimeText = StartTimeText{1};
        %
        % thisStr = FirstStartTimeText;
        % match = find(thisStr == colon);
        %
        % FirstStart_s_vid = str2double(thisStr(match(2)+1:end));
        % FirstStart_mins_vid = str2double(thisStr(match(1)+1:match(2)-1));
        % FirstStart_hrs_vid = str2double(thisStr(1:match(1)-1));
        %
        % Alignment_diff_s = FirstStart_s_vid - Alignment_s_vid;
        % Alignment_diff_s_cnt = 0;
        % if Alignment_diff_s > 0
        %     FirstStart_mins_vid = FirstStart_mins_vid+1;
        %     Alignment_diff_s_cnt = sInMin - Alignment_diff_s;
        %
        % else
        %     Alignment_diff_s_cnt = Alignment_diff_s;
        % end
        %
        %
        % diff_min = FirstStart_mins_vid - Alignment_mins_vid;
        %
        % if diff_min > 0
        %     FirstStart_hrs_vid = FirstStart_hrs_vid +1;
        %     %keyboard
        %     Alignment_diff_s_for_min = (minInHr - diff_min)*sInMin;
        %     Alignment_diff_s_cnt = Alignment_diff_s_for_min + Alignment_diff_s_cnt;
        % end
        %
        % diff_hr = FirstStart_hrs_vid - Alignment_hrs_vid;
        %
        % if diff_hr < 0
        %
        %     %Alignment_diff_min_for_hrs = (minInHr - diff_min)*sInMin;
        %     Alignment_diff_s_for_hrs = abs(diff_hr)*minInHr*sInMin;
        %     Alignment_diff_s_cnt = Alignment_diff_s_cnt +Alignment_diff_s_for_hrs;
        % elseif diff_hr > 0
        %     disp('please choose a later start time')
        %     keyboard
        % end
        %
        % nSecondsToFirstAlignment = Alignment_diff_s_cnt;
        % nsIn24Hours = Day_24Hr*sInHr;
        %
        % %%
        %
        %
        % newXticks = nSecondsToFirstAlignment:(nsIn24Hours/2):numel(allSmoothedDistances);
        %
        % newXticksDays = newXticks/60/60/24;
        %
        % clocktimes = {'20:00' '8:00'};
        % clocktimes = {'21:00' '9:00'};
        %
        % evenOff = mod((numel(newXticks)), 2);
        % if evenOff ==1
        % clockTimesRep = repmat(clocktimes, [1, (numel(newXticks)-1)/2]);
        % clockTimesRep  = [clockTimesRep {'20:00'}];
        %
        % else
        % clockTimesRep = repmat(clocktimes, [1, (numel(newXticks))/2]);
        % end
        %
        % set(gca, 'Xtick', newXticksDays)
        % set(gca, 'XtickLabel', clockTimesRep)
        %
        % axis tight
        % ylim([0 yvalueForNights])
        % xlabel('Clock Time')
        % ylabel('Euclidian Distance')
        %
        % titleTxt = [turtle ' | ' datesToLoad{1} ' - ' datesToLoad{end}];
        % title(titleTxt)
        %
        
        function [] = calcOFandMakeVideo_2ROIs(obj)
            
            
            vidToLoad = obj.PATH.VidPath{:};
            
            [pathstr,name,ext] = fileparts(vidToLoad);
            dirD = obj.HOST.dirD;
            
            dbstop if error
            
            close all
            
            %% Readin in Video and calculatate optic flow
            
            VideoObj = VideoReader(vidToLoad, 'Tag', 'CurrentVideo');
            
            nFrames = VideoObj.NumberOfFrames;
            VideoFrameRate = VideoObj.FrameRate;
            vidHeight = VideoObj.Height;
            vidWidth = VideoObj.Width;
            vidFormat = VideoObj.VideoFormat;
            
            videoReader = vision.VideoFileReader(vidToLoad,'ImageColorSpace','Intensity','VideoOutputDataType','uint8'); % create required video objects
            converter = vision.ImageDataTypeConverter;
            opticalFlow1 = vision.OpticalFlow('Method','Lucas-Kanade','ReferenceFrameDelay', 1);% use of the Lucas-Kanade method for optic flow determination
            opticalFlow2 = vision.OpticalFlow('Method','Lucas-Kanade','ReferenceFrameDelay', 1);% use of the Lucas-Kanade method for optic flow determination
            opticalFlow1.OutputValue = 'Horizontal and vertical components in complex form';
            opticalFlow2.OutputValue = 'Horizontal and vertical components in complex form';
            mCnt = 1;
            disp('Extracting frames and calculating the optic flow...')
            close all
            %%
            FrameOn = 1;
            FrameOff = nFrames;
            
            %framesToGrab = 1:15:nFrames;
            for frame_ind = FrameOn+1 : FrameOff
                %for frame_ind = framesToGrab
                mov(mCnt).cdata = read(VideoObj,frame_ind);
                frame = mov(mCnt).cdata;
                im = step(converter, frame);
                if mCnt == 1
                    figure(1)
                    imshow(im) %open the first frame
                    disp('Select 1st ROI')
                    rectim1 = getrect; %choose right eye ROI
                    rectim1=ceil(rectim1);
                    figure(2)
                    imshow(im) %open the first frame
                    disp('Select 2nd ROI')
                    drawnow;
                    rectim2 = getrect; %choose right eye ROI
                    rectim2=ceil(rectim2);
                end
                im1 = im(rectim1(2):rectim1(2)+rectim1(4),rectim1(1):rectim1(1)+rectim1(3)); %choose this ROI part of the frame to calculate the optic flow
                im2 = im(rectim2(2):rectim2(2)+rectim2(4),rectim2(1):rectim2(1)+rectim2(3));
                of1 = step(opticalFlow1, im1);
                of2 = step(opticalFlow2, im2);
                V1=abs(of1); % lenght of the velocity vector
                V2=abs(of2); % lenght of the velocity vector
                meanV1=mean(mean(V1)); %mean velocity for every pixel
                meanV2=mean(mean(V2)); %mean velocity for every pixel
                fV1(mCnt)=meanV1;
                fV2(mCnt)=meanV2;
                mCnt =mCnt +1;
                disp(strcat('Frame: ',num2str(frame_ind ),' is done'))
            end
            fV1(1)=0;% suppress the artifact at the first frame
            fV2(1)=0;
            
            %% Plot the optic flow with a moving line
            fV1=fV1./(max(max(fV1)));
            
            redcolor = [150 50 0];
            bluecolor = [0 50 150];
            
            
            redcolorline = [150 50 0]/255;
            bluecolorline = [0 50 150]/255;
            
            
            timepoints = (1:1:FrameOff-1)/VideoFrameRate; %in s
            %timepoints = (FrameOn+1:1:FrameOff)/10; %in s
            
            close all
            
            fig100= figure(100); plot(fV1)
            fcnt = 1;
            %smoothWin = 1;
            
            %for p = 1:FrameOff
            for p = 1:numel(timepoints)
                cla
                
                plot(timepoints, fV1, 'color', bluecolorline)
                %plot(timepoints, smooth(fV1, smoothWin) , 'color', bluecolorline)
                
                hold on
                line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
                axis tight
                ax = gca;
                ax.Units = 'pixels';
                pos = ax.Position;
                ti = ax.TightInset;
                rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
                F1(fcnt) = getframe(ax,rect);
                fcnt = fcnt+1;
            end
            
            close(fig100)
            
            fV2=fV2./(max(max(fV2)));
            
            fig200 = figure(200); plot(fV2)
            fcnt = 1;
            
            %for p = 1:FrameOff
            for p = 1:numel(timepoints)
                cla
                plot(timepoints, fV2, 'color', redcolorline)
                %plot(timepoints, smooth(fV2, smoothWin) , 'color', redcolorline)
                hold on
                line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
                axis tight
                xlabel('Time [s]')
                ax = gca;
                ax.Units = 'pixels';
                pos = ax.Position;
                ti = ax.TightInset;
                rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
                F2(fcnt) = getframe(ax,rect);
                fcnt = fcnt+1;
            end
            close(fig200);
            
            
            OF.fV1 = fV1;
            OF.fV2 = fV2;
            
            %save([pathstr dirD 'OF-' name '__ROIs.mat'], 'OF');
            
            
            %% Saving
            plot_filenameVid = [pathstr dirD 'OF_VID-' name '.avi'];
            
            vid1 = VideoReader(vidToLoad, 'Tag', 'CurrentVideo');
            outputVideo = VideoWriter(plot_filenameVid);
            outputVideo.FrameRate = VideoFrameRate ;
            open(outputVideo);
            
            %shapeInserter1 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32([0 0 255]));
            shapeInserter1 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32(bluecolor));
            shapeInserter2 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32(redcolor));
            rectim1 = int32(rectim1);
            rectim2 = int32(rectim2);
            
            %% create a nice video output by concatenating images
            disp('Optic flow frame grabbing')
            
            i=1;
            for frame_ind = FrameOn+1 : FrameOff -1
                img1 = read(vid1,frame_ind);
                img1 = step(shapeInserter1,img1,rectim1); %insert the ROIs
                img1 = step(shapeInserter2,img1,rectim2); %insert the ROIs
                
                img2 = F1(i).cdata;
                img3 = F2(i).cdata;
                img2 = imresize(img2,[size(F2(1).cdata,1) size(F2(1).cdata,2)]);
                
                img4 = vertcat(img2,img3);
                scale=size(img4,1)/size(img1,1);
                img5 = imresize(img1,scale);
                img5 = imresize(img5,[size(img4,1) size(img5,2)]);
                imgf = horzcat(img5,img4);
                
                % play video
                %step(videoPlayer, imgt);
                
                % record new video
                writeVideo(outputVideo, imgf);
                i=i+1;
            end
            close(outputVideo);
            
        end
        
        
        function [] = calcOFandMakeVideo_1ROIs(obj)
            
            
            vidToLoad = obj.PATH.VidPath{:};
            
            [pathstr,name,ext] = fileparts(vidToLoad);
            dirD = obj.HOST.dirD;
            
            dbstop if error
            
            close all
            
            %% Readin in Video and calculatate optic flow
            
            VideoObj = VideoReader(vidToLoad, 'Tag', 'CurrentVideo');
            
            nFrames = VideoObj.NumberOfFrames;
            VideoFrameRate = VideoObj.FrameRate;
            vidHeight = VideoObj.Height;
            vidWidth = VideoObj.Width;
            vidFormat = VideoObj.VideoFormat;
            
            videoReader = vision.VideoFileReader(vidToLoad,'ImageColorSpace','Intensity','VideoOutputDataType','uint8'); % create required video objects
            converter = vision.ImageDataTypeConverter;
            opticalFlow1 = vision.OpticalFlow('Method','Lucas-Kanade','ReferenceFrameDelay', 1);% use of the Lucas-Kanade method for optic flow determination
            opticalFlow2 = vision.OpticalFlow('Method','Lucas-Kanade','ReferenceFrameDelay', 1);% use of the Lucas-Kanade method for optic flow determination
            opticalFlow1.OutputValue = 'Horizontal and vertical components in complex form';
            opticalFlow2.OutputValue = 'Horizontal and vertical components in complex form';
            mCnt = 1;
            disp('Extracting frames and calculating the optic flow...')
            close all
            %%
            FrameOn = 1;
            FrameOff = nFrames;
            
            %framesToGrab = 1:15:nFrames;
            for frame_ind = FrameOn+1 : FrameOff
                %for frame_ind = framesToGrab
                mov(mCnt).cdata = read(VideoObj,frame_ind);
                frame = mov(mCnt).cdata;
                im = step(converter, frame);
                if mCnt == 1
                    figure(1)
                    imshow(im) %open the first frame
                    disp('Select 1st ROI')
                    rectim1 = getrect; %choose right eye ROI
                    rectim1=ceil(rectim1);
                    %figure(2)
                    %imshow(im) %open the first frame
                    %disp('Select 2nd ROI')
                    %drawnow;
                    %rectim2 = getrect; %choose right eye ROI
                    %rectim2=ceil(rectim2);
                end
                im1 = im(rectim1(2):rectim1(2)+rectim1(4),rectim1(1):rectim1(1)+rectim1(3)); %choose this ROI part of the frame to calculate the optic flow
                %im2 = im(rectim2(2):rectim2(2)+rectim2(4),rectim2(1):rectim2(1)+rectim2(3));
                of1 = step(opticalFlow1, im1);
                %of2 = step(opticalFlow2, im2);
                V1=abs(of1); % lenght of the velocity vector
                %V2=abs(of2); % lenght of the velocity vector
                meanV1=mean(mean(V1)); %mean velocity for every pixel
                %meanV2=mean(mean(V2)); %mean velocity for every pixel
                fV1(mCnt)=meanV1;
                %fV2(mCnt)=meanV2;
                mCnt =mCnt +1;
                disp(strcat('Frame: ',num2str(frame_ind ),' is done'))
            end
            fV1(1)=0;% suppress the artifact at the first frame
            %fV2(1)=0;
            
            %% Plot the optic flow with a moving line
            fV1=fV1./(max(max(fV1)));
            
            redcolor = [150 50 0];
            bluecolor = [0 50 150];
            
            
            redcolorline = [150 50 0]/255;
            bluecolorline = [0 50 150]/255;
            
            
            timepoints = (1:1:FrameOff-1)/VideoFrameRate; %in s
            %timepoints = (FrameOn+1:1:FrameOff)/10; %in s
            
            close all
            
            fig100= figure(100); plot(fV1)
            fcnt = 1;
            %smoothWin = 1;
            
            %for p = 1:FrameOff
            for p = 1:numel(timepoints)
                cla
                
                plot(timepoints, fV1, 'color', bluecolorline)
                %plot(timepoints, smooth(fV1, smoothWin) , 'color', bluecolorline)
                
                hold on
                line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
                axis tight
                xlabel('Time [s]')
                ax = gca;
                ax.Units = 'pixels';
                pos = ax.Position;
                ti = ax.TightInset;
                rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
                F1(fcnt) = getframe(ax,rect);
                fcnt = fcnt+1;
            end
            
            close(fig100)
            
            %             fV2=fV2./(max(max(fV2)));
            %
            %             fig200 = figure(200); plot(fV2)
            %             fcnt = 1;
            %
            %             %for p = 1:FrameOff
            %             for p = 1:numel(timepoints)
            %                 cla
            %                 plot(timepoints, fV2, 'color', redcolorline)
            %                 %plot(timepoints, smooth(fV2, smoothWin) , 'color', redcolorline)
            %                 hold on
            %                 line([timepoints(p),timepoints(p)], [0 1], 'color', [0 0 0])
            %                 axis tight
            %                 xlabel('Time [s]')
            %                 ax = gca;
            %                 ax.Units = 'pixels';
            %                 pos = ax.Position;
            %                 ti = ax.TightInset;
            %                 rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+20, pos(4)+ti(2)+ti(4)];
            %                 F2(fcnt) = getframe(ax,rect);
            %                 fcnt = fcnt+1;
            %             end
            %             close(fig200);
            %
            
            OF.fV1 = fV1;
            % OF.fV2 = fV2;
            
            %save([pathstr dirD 'OF-' name '__ROIs.mat'], 'OF');
            
            
            %% Saving
            plot_filenameVid = [pathstr dirD 'OF_VID-' name '.avi'];
            
            vid1 = VideoReader(vidToLoad, 'Tag', 'CurrentVideo');
            outputVideo = VideoWriter(plot_filenameVid);
            outputVideo.FrameRate = VideoFrameRate ;
            open(outputVideo);
            
            %shapeInserter1 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32([0 0 255]));
            shapeInserter1 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32(bluecolor));
            %shapeInserter2 = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','LineWidth',2.5,'CustomBorderColor',int32(redcolor));
            rectim1 = int32(rectim1);
            %rectim2 = int32(rectim2);
            
            %% create a nice video output by concatenating images
            disp('Optic flow frame grabbing')
            
            i=1;
            for frame_ind = FrameOn+1 : FrameOff -1
                img1 = read(vid1,frame_ind);
                img1 = step(shapeInserter1,img1,rectim1); %insert the ROIs
                %img1 = step(shapeInserter2,img1,rectim2); %insert the ROIs
                
                img2 = F1(i).cdata;
                %img3 = F2(i).cdata;
                img2 = imresize(img2,[size(F1(1).cdata,1) size(F1(1).cdata,2)]);
                
                %img4 = vertcat(img2,img3);
                img4 = vertcat(img2);
                scale=size(img4,1)/size(img1,1);
                img5 = imresize(img1,scale);
                img5 = imresize(img5,[size(img4,1) size(img5,2)]);
                imgf = horzcat(img5,img4);
                
                % play video
                %step(videoPlayer, imgt);
                
                % record new video
                writeVideo(outputVideo, imgf);
                i=i+1;
            end
            close(outputVideo);
            
        end
        
        function [] = makeMoviesFromImages(obj, imageDir, movieName, saveDir)
            
            
            fileFormat = 1; % (1)- tif, (2) -.jpg
            %playInReverse = 1; %(1) play the images from last to first
            
            %%
            switch fileFormat
                case 1
                    imgFormat = '*.tiff';
                case 2
                    imgFormat = '*.jpg';
            end
            
            imageNames = dir(fullfile(imageDir{:},imgFormat));
            imageNames = {imageNames.name}';
            
            nImags = numel(imageNames);
            underscore = '_';
            period = '.';
            
            endingTxt_dbl = [];
            for o = 1:nImags
                underscoreInd = find(imageNames{o} == underscore);
                periodInd = find(imageNames{o} == period);
                endingTxt_dbl(o) = str2double(imageNames{o}(underscoreInd(end)+1:periodInd(1)-1));
            end
            
            [bla, inds] = sort(endingTxt_dbl, 'ascend');
            
            resortedNames = imageNames(inds);
            
            
            
            
            
            
            %% Find start and Stop
            
            %startFrame = '0080';% Lizard13
            %endFrame = '0440';% Lizard13
            
            %startFrame = '0080';% Lizard15
            %endFrame = '0480';% Lizard15
            
            %  startFrame = '0000';% surface
            %  endFrame = '1200';% surface
            
            %  matchIndsStart = cellfun(@(x) strfind(x, startFrame), imageNames, 'UniformOutput', 0);
            %  matchIndsStartInd = find(cellfun(@(x) ~isempty(x), matchIndsStart)==1);
            
            %  matchIndsEnd = cellfun(@(x) strfind(x, endFrame), imageNames, 'UniformOutput', 0);
            %  matchIndsEndInd = find(cellfun(@(x) ~isempty(x), matchIndsEnd)==1);
            
            movName = [saveDir{:} movieName];
            %% Create Output Video
            outputVideo = VideoWriter(fullfile(movName));
            outputVideo.FrameRate = 10;
            open(outputVideo)
            %%
            
            %             if playInReverse == 0
            %                 framesToGrab = matchIndsStartInd:1:matchIndsEndInd; % forward playback
            %             elseif playInReverse == 1
            %                 framesToGrab = matchIndsEndInd:-1:matchIndsStartInd; % reversed playback
            %             end
            
            %% Read in Frames
            tic
            for f = 1: nImags
                img = imread([imageDir{:} resortedNames{f}]);
                
                if fileFormat == 1
                    img2 = im2uint8(img); % need to convert for .tif files
                elseif fileFormat ==2
                    img2 = img;
                end
                writeVideo(outputVideo,img2)
                disp(['Frame: ' num2str(f) '/' num2str(nImags)]);
                
            end
            toc
            
            %%
            close(outputVideo);
            disp(['Created Video: ' movName]);
        end
        
        
        function [] = makeMultipleMoviesFromImages(obj, imageDir, movieName, saveDir, VideoFrameRate)
            
            
            fileFormat = 1; % (1)- tif, (2) -.jpg
            
            %%
            switch fileFormat
                case 1
                    imgFormat = '*.tiff';
                case 2
                    imgFormat = '*.jpg';
            end
            
            imageNames = dir(fullfile(imageDir{:},imgFormat));
            imageNames = {imageNames.name}';
            
            nImags = numel(imageNames);
            underscore = '_';
            period = '.';
            
            endingTxt_dbl = [];
            for o = 1:nImags
                underscoreInd = find(imageNames{o} == underscore);
                periodInd = find(imageNames{o} == period);
                endingTxt_dbl(o) = str2double(imageNames{o}(underscoreInd(end)+1:periodInd(1)-1));
            end
            
            [bla, inds] = sort(endingTxt_dbl, 'ascend');
            
            resortedNames = imageNames(inds);
            
            FrameCut = 2*VideoFrameRate*60*60; % 2 hour
            
            if nImags > FrameCut;
                tOn = 1:FrameCut:nImags;
                nParts = numel(tOn);
            else
                tOn = 1;
                nParts = 1;
            end
            
            for q = 1:nParts
                
                FrameOn = tOn(q);
                FrameOff = tOn(q)+FrameCut;
                
                if q== nParts
                    FrameOff =nImags;
                end
                
                %%
                movName = [saveDir{:} movieName '_' sprintf('%03d',q)];
                %% Create Output Video
                outputVideo = VideoWriter(fullfile(movName));
                outputVideo.FrameRate = 10;
                open(outputVideo)
                
                %% Read in Frames
                tic
                for f = FrameOn:FrameOff-1
                    img = imread([imageDir{:} resortedNames{f}]);
                    
                    if fileFormat == 1
                        img2 = im2uint8(img); % need to convert for .tif files
                    elseif fileFormat ==2
                        img2 = img;
                    end
                    writeVideo(outputVideo,img2)
                    disp(['Frame: ' num2str(f) '/' num2str(nImags)]);
                    
                end
                toc
                
                %%
                close(outputVideo);
                disp(['Created Video: ' movName]);
            end
        end
        
    end
    
    %%
    
    
    
    methods (Hidden)
        %class constructor
        function obj = videoAnalysis_OBJ(vidPath)
            
            
            obj = getVideoInfo(obj, vidPath);
            
            %            obj = getSessionInfo(obj, rfc);
            %           obj = findSessionDir(obj);
            
        end
    end
    
end


