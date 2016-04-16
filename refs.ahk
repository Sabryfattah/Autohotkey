#C:: ; input referenc number then copy reference to references.txt file and replace the reference text with number entered. 
InputBox, N, Reference No., Enter Reference No.
Clipboard=
Send ^c
ClipWait
IniWrite % Clipboard, refs.txt, References, %N%
Send %N%
Return

#z:: ; sort the reference.txt file alphabetically
FileRead, Contents, refs.txt
if not ErrorLevel  ; Successfully loaded.
{
    Sort, Contents
    FileDelete,  refs (sorted).txt
    FileAppend, %Contents%, refs (sorted).txt
    Contents =  ; Free the memory.
}
return