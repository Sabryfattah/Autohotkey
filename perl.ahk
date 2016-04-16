#NoEnv
#Persistent
#z::
;===============================================================
; This script allow ypu to run Perl script and interact with it 
; The gui shows two windows, enter the code in the upper one, then enter code
; this will write a  Perl file tmp.pl
; then click on Run button which will run the code and show output in the second lower window
;=========== ========            Build Gui         ==============================
Gui, +Resize  ; Make the window resizable.
gui, font, s16 cwhite, Verdana  
gui, color, , black
;Gui, Font, s14 w800 cfffb00, Bookman Old Style
;Gui, color, black
Gui, Add, Edit,     x10 y10    w1250 h310  BackgroundTrans vWin1,
Gui, Add, Edit,     x10 y330 w1250 h310  BackgroundTrans vWin2,
;Gui, Add, Button, x120 y450 w100   h30 gRun, Run
Gui, Add, Button, x140 y650 w100   h30 gClear, Clear
Gui, Add, Button, xp+120 y650 w100   h30 gSave, Save
Gui, Add, Button, xp+120 y650 w100   h30 gSaveAs, SaveAs
Gui, Add, Button, xp+120 y650 w100   h30 gOpen,Open
Gui, Add, Button, xp+120 y650 w100   h30 gRun, Run
Gui, Add, Button,xp+120  y650 w100   h30 gtest, Test
Gui, Add, Button, xp+120 y650 w100   h30 gEnd, End
Gui, Submit, NoHide
Gui, Show, Maximize, Perl App
return
;===============   Open The Perl Script File ============================
Open:
FileDelete, code.txt
;---------------- Select the file
FileSelectFile, file
;---------------- Get the file name from the full path ---------------------------------------------------
SplitPath, file, name, dir, ext, bare, drive
 ;----------------- Read this file into variable "code" -----------------------------------------
FileRead, code, %file%
; --------------- Show this file in the Win1 Window ------------------------------------------
GuiControl, ,Win1, %code%
return
;==================== Processing ====================================
Run:
FileDelete, tmp.txt
sleep, 100
Run, %comspec% /c perl %name%, , Hide
;------------------ Get output file into variable clip -------------
Sleep, 100
FileRead, output, tmp.txt
--------------------- Show the output file content in the OUT windowd control ---------
GuiControl, , Win2, %output%
return
;===============================================================
; If you make changes to the open file, it can be saved again into the same name or another name
;==========       Save Contents of WIndow 1               ==============
save:
;---------------- Choose file name to save ---------------------------------------------------------------
GuiControlGet, Win1
/*
;------------------------------ Remove line numbers ----------------------------------------------------
WLN := RegExReplace(Win1,"\d.?:", "") 
;---- Save the contents of the modifed  WLN (without line numbers)  into the same name of file chosen ------
*/
FileDelete,  %name%
FileAppend, %win1%, %name%
return
;========================SaveAs=================================
SaveAs:
FileSelectFile,filename, S
GuiControlGet, Win1
FileDelete,  %filename%
FileAppend, %win1%, %filename%
return
; ====================== Clear both Windows ===============================
Clear:
GuiControl, , Win1
GuiControl, , Win2
return
; ================ Close Running Executables =================================
End:
FileDelete, tmp.txt
FileDelete, tmp.pl
process, close, cmd.exe
process, close, conhost.exe
process, close, perl.exe
Return
;====================Run Code in Win1 as a test ==========================
test:
;------------------ Delete both tmp files -------------------------------------------------------------------------
FileDelete, tmp.pl
sleep, 100
;--------------- get Win1 control content and save it in Win1 variable ------------------------------------------
GuiControlGet, Win1
/*;------------------ Save the contents of the Win1 Control variable into a temporary Perl file ------------------
string :=RegExReplace(Win1,"\d.?:", "") 
*/
FileAppend, %Win1%, tmp.pl
;--------------------- Run tmp perl and get output into a tmp.txt file  (both STDOUT or STDERR) ------------
Run, %comspec% /c perl tmp.pl > tmp.txt 2>&1, , Hide
;-------------------- Read the tmp.txt (output file) into variable "Out" -----------------------------------------
FileRead, out, tmp.txt
;--------------------- Show the output file content in the OUT windowd control -----------------------------
GuiControl, , Win2, %out%
return
;================ close window and quit  script   ======================
Guiclose:
gui, destroy
process, close, cmd.exe
process, close, conhost.exe
process, close, perl.exe
return
