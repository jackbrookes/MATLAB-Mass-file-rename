%   NOTES - does not rename parent folder
%         - case sensitive

%   First, select the parent folder containing the files/folders you wish
%   to rename.
f = uigetdir();

%   define search string and replace string
%       -replaces spaces with underscores
s = '_P';
r = '_PM';

%   run function
mass_file_rename(f, s, r);