function [] = mass_file_rename(startFolder, searchString,replaceString)

%   define function
rename = @(name) strrep(name, searchString, replaceString);

%   Initialise our queue of folders
folderQueue = {startFolder};
%   loop init..
tic;
foldersLeft = true;
i = 0; j = 0;
while foldersLeft
    
    %   Get newest addition to queue
    currentFolder = folderQueue{end};
    %   Delete from queue
    folderQueue(:,end) = [];
    
    %   Search current folder for files & folders
    dirinfo = dir(currentFolder);
    %   Delete unecessary dummy folders
    dirinfo(1:2) = [];
    %   get files
    files   = {dirinfo(~[dirinfo.isdir]).name};
    %   get folders
    folders = {dirinfo( [dirinfo.isdir]).name};
    
    %   Rename all necessary files
    for fc = files
        %   rename filename from cell
        fOld = char(fc);
        fNew = rename(fOld);
        %   original full filename
        src  = fullfile(currentFolder, fOld);
        %   new full filename
        dest = fullfile(currentFolder, fNew);
        %   move = rename
        if ~strcmp(src,dest)
            [status,message,messageid] = movefile(src, dest);
            i = i + 1;
        end
    end
        
    %   Rename all necessary folders, then add them to our queue to search
    for dc = folders
        %   rename foldername from cell
        dOld = char(dc);
        dNew = rename(dOld);
        %   original full foldername
        src  = fullfile(currentFolder, dOld);
        %   new full foldername
        dest = fullfile(currentFolder, dNew);
        %   move = rename
        if ~strcmp(src,dest)
            [status,message,messageid] = movefile(src, dest);
            j = j + 1;
        end
        %   add to queue to scan afterwards
        folderQueue = [folderQueue, {dest}]; %#ok<AGROW>
    end
    
    %   Check if we have finished
    if isempty(folderQueue)
        foldersLeft = false;
    end
end

fprintf('Renamed %d file(s) and %d folder(s) in %.3f seconds.\n', i, j, toc);


end