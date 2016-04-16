; This script will backup files and folders from a drive or root folder to a a backup folder on Drive H
; Select the folder to backup  and it will copy  only the new and modified files under their coressponding directories
; XCOPY PARAMETERS:
;			/d[:mm-dd-yyyy] : Copies source files changed on or after the specified date only. If you do not include a mm-dd-yyyy value, xcopy copies all Source files that are newer than existing Destination files. This command-line option allows you to update files that have changed. 
;			/s : Copies directories and subdirectories, unless they are empty. If you omit /s, xcopy works within a single directory.

;			/e : Copies all subdirectories, even if they are empty. Use /e with the /s and /t command-line options.

;			/t : Copies the subdirectory structure (that is, the tree) only, not files. To copy empty directories, you must include the /e command-line option. 
;			/c : Ignores errors. 
;			/q : Suppresses the display of xcopy messages. 
;			/h : Copies files with hidden and system file attributes. By default, xcopy does not copy hidden or system files. 
;			/r : Copies read-only files. 
;			/y : Suppresses prompting to confirm that you want to overwrite an existing destination file. 
;			/k : Copies files and retains the read-only attribute on destination files if present on the source files. By default, xcopy removes the read-only attribute. 
;			/u : Copies files from Source that exist on Destination only, i.e. Update.
;			
#SingleInstance
SetBatchLines, -1  ; Make the operation run at maximum speed.
; define $Source and  $destination
Destination  = E:\Backup
FileSelectFolder, source
splitpath, Source, , , , Name
   ; If the %Name of the folder does not exist in destination folder, create it
ifNotExist, E:\Backup\%name%
  FileCreateDir, E:\Backup\%name%
   ; Run Xcopy and wait for it to finish
MsgBox, 48, Processing, Please Wait . . . . . . . `nThis may take few minutes. ., 10
RunWait, %comspec%  /c xcopy "%source%" "E:\Backup\%name%"  /D /E /C /Q /H /R /Y /K , , Hide, PID
; Close processess
Process, close, %PID%
Process Close, xcopy.exe
Process Close, conhost.exe
MsgBox Finished Copying Folder: %folder%
MsgBox, Finished copying All Folders
Return
