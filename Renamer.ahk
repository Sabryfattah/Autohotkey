; This is a script to rename a group of text files in a folder. It rename each and save them to a subfolder "Renamed"
; Script by Sabry Fattah, 22 October 2013
;-------------------------------------------------------------------------------------------------------------------------
; start by selecting folder and create a renamed subfolder
FileSelectFolder, Folder
FileCreateDir,  %Folder%\Renamed
; get file names in a list and assign the filename and extension to variables "fnm" and "fxt"
FileList =
Loop %Folder%\*.txt
   FileList = %FileList%%A_LoopFileName%`n
 ;---------------------------------------------------------------------------------------
; Build Gui 
gui, font, s10 Tahoma
;gui, add, button , x10 y10 gfolder, Select Folder
gui, add, button , x10 y10  gAutoS, Autonumber@Start
gui, add, button , x280 y10  gAutoN, Autonumber@End
gui, add, Button, x10 y40 gExt, Change extension
gui, add, edit,  x140 y40 w30 VExt, 
gui, add, button, x10 y70 gPre, Add Prefix
gui, add, edit, x140  y70 VPre ,  Enter Prefix
gui, add, button, x10 y100 , Add Suffix
gui, add, edit, x140 y100 VPost gPost, Enter Suffix
gui, add, button, x10 y130 gLTrim, Trim FileName LT
gui, add, edit, x140 y130 VLNN ,  No. of Characters to Trim
gui, add, button, x10 y160 gRTrim, Trim FileName RT
gui, add, edit, x140 y160 VRNN ,  No. of Characters to Trim
gui, add, text, x10 y190, RegEx Match
gui, add, text, x140 y190 , Match Replacement
gui, add, edit, x10 y210 w80  VRegExM,
gui, add, edit, x140 y210 w125 VRegexR,
gui, add, button, x290 y210 gRegExReplace , Replace Match
gui, add, text, x10 y240, Delete xyz from start [xyz(?=.*) ] or end [xyz(?=<.*)] of file name
gui, add, text, x10 y260, Replace changes and copies only matching filenames to subfolder
gui, add, button, x10 y620 w60 h20 gRefresh , Refresh
gui, add, text, x75 y620, DoubleClick to Delete  a Single file
gui, add, button, x290 y620 w120 h20 gClear, Empty Subfolder
; Attach Listview to lower part of windows to show files
Gui, Add, ListView, x10 y280 h150  w400 gMyListView1, %Folder%
;FileSelectFolder, Folder1
; Gather a list of file names from a folder and put them into the ListView:
Gui, Add, Text, x10 y440 w400 0x10  ;Horizontal Line > Etched Gray
Loop, %Folder%\*.*
    LV_Add("", A_LoopFileName)
; Listview of changed files in subfolder
Gui, Add, ListView, x10 y450 h150 w400  gMyListView2,  %Folder%\Renamed
; show the window
Gui, submit, nohide
Gui, Show, W420 h650, File Rename
return

;-----------------------------------------------------------------------------------
;--///LISTVIEW LABELS------------------------------------------------------
MyListView1:
if A_GuiEvent = DoubleClick
{
    LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
    ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
}
return
;------------------------------------------------------------------------------
;------LABEL TO DELETE CLICKED FILE IN SUBFOLDER-----
MyListView2:
if A_GuiEvent = DoubleClick
 {
 row := LV_GetNext(, "focused")
 LV_GetText(fname, row)
 MsgBox %fname%
 FileDelete, %Folder%\Renamed\%fname%
 MsgBox  File %fname% deleted now.
 LV_Delete(row)
 }
 Return
;-----------------------------------------------------------------------------------------------
;//ALL -------------LABELS//-------------------------------------------------------------
;-------------------------------------------------------------------------------------------------
Ext:
GuiControlGet, ext
Loop, parse, FileList, `n
  {
   string =  %A_LoopField%
   stringsplit, var, string, .
  fnm = %var1%
  fxt  = %var2%
  FileCopy, %Folder%\%Fnm%.txt,  %Folder%\renamed\%fnm%.%ext%
}
gosub, Done
return
;-----------------------------------------------------------------------------------------
; change file name by RegEx Replacement
RegExReplace:
GuiControlGet, RegExM
GuiControlGet, RegExR
Loop, parse, FileList, `n
  {
   string =  %A_LoopField%
   stringsplit, var, string, .
  fnm = %var1%
 NewFN := RegExReplace(Fnm,   RegExM,  RegEXR)
 FileCopy, %Folder%\%Fnm%.txt,  %Folder%\renamed\%NewFN%.txt
}
gosub, Done
return
;------------------------------------------------------------------------------------
; Add prefix to filename
pre:
GuiControlGet, Pre
Loop, parse, FileList, `n
{
   string =  %A_LoopField%
   stringsplit, var, string, .
  fnm = %var1%
  fxt  = %var2%
 FileCopy, %Folder%\%Fnm%.txt,  %Folder%\renamed\%Pre%%Fnm%.txt
}
gosub, Done
return
;-------------------------------------------------------------------------------------------------
; Add Suffix to the start of the filenames.
Post:
GuiControlGet, Post
Loop, parse, FileList, `n
{
   string =  %A_LoopField%
   stringsplit, var, string, .
  fnm = %var1%
  fxt  = %var2%
 FileCopy, %Folder%\%Fnm%.txt,  %Folder%\renamed\%Fnm%%Post%.txt
}
gosub, Done
return
;------------------------------------------------------------------------------------------------------
; Autonumber the start of filenames
AutoN:
NN = 0
Loop, parse, FileList, `n
{
   string =  %A_LoopField%
   stringsplit, var, string, .
  fnm = %var1%
  fxt  = %var2%
   NN += 1
 FileCopy, %Folder%\%Fnm%.txt,  %Folder%\renamed\%Fnm%_%NN%.txt
}
gosub, Done
return
;------------------------------------------------------------------------------------------------------
; Autonumber the start of filenames
AutoS:
NN = 0
Loop, parse, FileList, `n
{
   string =  %A_LoopField%
   stringsplit, var, string, .
  fnm = %var1%
  fxt  = %var2%
   NN += 1
 FileCopy, %Folder%\%Fnm%.txt,  %Folder%\renamed\%NN%_%Fnm%.txt
}
gosub, Done
return
;-----------------------------------------------------------------------------------------
; Remove a number of characters from start of filenames
LTrim:
GuiControlGet, LNN
Loop, parse, FileList, `n
  {
  string =  %A_LoopField%
   stringsplit, var, string, .
  fnm = %var1%
  fxt  = %var2%
 StringTrimLeft, trfnm, fnm, %LNN%
 FileCopy, %Folder%\%fnm%.txt,  %Folder%\renamed\%trfnm%.txt
}
gosub, Done
return
;------------------------------------------------------------------------------------------
 ; Remove a number of characters from end of filenames
RTrim:
GuiControlGet, RNN
Loop, parse, FileList, `n
  {
  string =  %A_LoopField%
   stringsplit, var, string, .
  fnm = %var1%
  fxt  = %var2%
 StringTrimRight, trfnm, fnm, %RNN%
 FileCopy, %Folder%\%fnm%.txt,  %Folder%\renamed\%trfnm%.txt
}
gosub, Done
return
;------------------------------------------------------------------------------------------------------------------
Done:
Refresh:
   LV_Delete()
 Loop, %Folder%\Renamed\*.*
    LV_Add("", A_LoopFileName)
Return
;-----------------------------------------------------------------------------------------------
Clear:
FileDelete, %Folder%\renamed\*.*
Return
; change extension section
close:
ExitApp