function [] = backup()
%this function will backup all the excel files in the current directory to
%the BackupMemory folder in the current directory.  it just copies and
%moves files.

%for now, we are just going to hardcode the xls files to copy to back up.
%in the future, we can iterate through the directory (help cd) and back up
%all the xls files

[a b c] = copyfile('good.xlsx','\\Pcs-file-hou\Redir\jnguyen\My Documents\CATS Dev\Tyd\Sentiment\BackupMemory');
[a b c] = copyfile('bad.xlsx','\\Pcs-file-hou\Redir\jnguyen\My Documents\CATS Dev\Tyd\Sentiment\BackupMemory');
disp('Backups complete for good and bad xlsx.  Copies are stored in BackupMemory subfolder.')