#Persistent
#NoEnv
SetBatchLines -1
ListLines Off
SetKeyDelay, 10
SetTitleMatchMode, 2
DetectHiddenWindows On
FileEncoding, UTF-8
; Example: Simple text editor with menu bar.
;==================================Menu and Gui ==============================
; Create the sub-menus for the menu bar:
Menu, FileMenu, Add, &New       #N, FileNew
Menu, FileMenu, Add, &Open     #O, FileOpen
Menu, FileMenu, Add, &Save      #S, FileSave
Menu, FileMenu, Add, Save &As  #A, FileSaveAs
Menu, FileMenu, Add, Ap&pend  #P, Append
Menu, FileMenu, Add, &Delete    #D, DeleteCurrent 
Menu, FileMenu, Add, &Clipbrd   #C, ReadClip
Menu, EditMenu, Add, &AraRead    #R, AraRead
Menu, EditMenu, Add, &AraSave    #Z, AraSave
Menu, FileMenu, Add  ; Separator line.
Menu, FileMenu, Add, E&xit, FileExit
Menu, HelpMenu, Add, &About, HelpAbout
Menu, EditMenu, Add, &Font, EditFont


Gui1:
; Create the menu bar by attaching the sub-menus to it:
Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Edit, :EditMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu
; Attach the menu bar to the window:
Gui, 1: Default
Gui, Menu, MyMenuBar
; Create the main Edit control and display the window:
Gui, +Resize  ; Make the window resizable.
gui, font, s16 cwhite, Verdana  
gui, color, , black
; Create the main Edit control and display the window:
Gui, Add, Edit, hwndhMainEdit vMainEdit WantTab W600 R20
Gui, Show, Maximize, Untitled
CurrentFileName =  ; Indicate that there is no current file.
return

;================================= Subroutines ==================================
#N::
FileNew:
GuiControl,, MainEdit  ; Clear the Edit control.
return
;------------------------------------------------------
#O::
FileOpen:
Gui, +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFile, SelectedFileName, 3, C:\Users\Sabry\Desktop\Scanned, Open File, *.txt
if SelectedFileName =  ; No file selected.
    return
Gosub FileRead
return
;--------------------------------------------------------
FileRead:  ; Caller has set the variable SelectedFileName for us.
FileRead, MainEdit, %SelectedFileName%  ; Read the file's contents into the variable.
if ErrorLevel
{
    MsgBox Could not open "%SelectedFileName%".
    return
}
GuiControl,, MainEdit, %MainEdit%  ; Put the text into the control.
CurrentFileName = %SelectedFileName%
Gui, Show,, %CurrentFileName%   ; Show file name in title bar.
return
;--------------------------------------------------------------
#S::
FileSave:
if CurrentFileName =   ; No filename selected yet, so do Save-As instead.
    Goto FileSaveAs
Gosub SaveCurrentFile
return
;---------------------------------------------------------------
#A::
FileSaveAs:
Gui, +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFile, SelectedFileName, S16,, Save File, Text Documents (*.txt)
if SelectedFileName =  ; No file selected.
    return
CurrentFileName = %SelectedFileName%
Gosub SaveCurrentFile
return
;-----------------------------------------------------------------
SaveCurrentFile:  ; Caller has ensured that CurrentFileName is not blank.
IfExist %CurrentFileName%
{
    FileDelete %CurrentFileName%
    if ErrorLevel
    {
        MsgBox The attempt to overwrite "%CurrentFileName%" failed.
        return
    }
}
GuiControlGet, MainEdit  ; Retrieve the contents of the Edit control.
FileAppend, %MainEdit%, %CurrentFileName%  ; Save the contents to the file.
; Upon success, Show file name in title bar (in case we were called by FileSaveAs):
Gui, Show,, %CurrentFileName%
return
;---------------------------------------------------------------------------------------
#H::
HelpAbout:
Gui, 2:+owner1  ; Make the main window (Gui #1) the owner of the "about box".
Gui  +Disabled  ; Disable main window.
Gui, 2:  Font, S12 , Tahoma
Gui, 2: Add, Text,, This is a simple text editor with black background and white text font.`nYou select a file to open, save it, save it under a new name,`nTo close the file, open a blank new file. To delete a file select it first to avoid mistakes.
Gui, 2: Add, Button, Default, OK
Gui, 2: Show
return
;---------------------------------------------------------------------------------------
EditFont:
InputBox, font, Change Font Size, Enter Font Size
Gui, Font, S%font% Verdana
GuiControl, Font, MainEdit
return
;------------------------------------------------------------------------------------------
#Z::
AraRead:
FileSelectFile, SelectedFile, 3, C:\Users\Sabry\Desktop\Scanned, Open File, *.txt
splitpath, SelectedFile,name, dir, ext
Run, %name%, %dir%, Hide, PID
WinActivate, %name% - Notepad
clipboard = ; Empty the clipboard
Send, ^a
Send, ^c
ClipWait, 0.1
;Send, ^a
;Send, ^c
WinActivate, Untitled ahk_class AutoHotkeyGUI
Gui, Font, S24 Verdana 
Gui, +E0x00400000L
GuiControl,, MainEdit  ; Clear the Edit control.
GuiControl, font, MainEdit
send, ^v
;clipboard =
;Process, Close, %PID%
Return
;---------------------------------------------------------------------------------------------
AraSave:
;clipboard = ; Empty the clipboard
Send, ^a
Send, ^c
ClipWait, 0.1
Run, notepad,, Max, PID
sleep, 100
ControlSend, Edit1, ^v, Untitled - Notepad
sleep, 500
PostMessage, 0x111, 3, 0, , Untitled - Notepad 
;process, Close, PID
return
;======================
#P::
Append:
Send ^{End}
Send, `r `r
FileSelectFile, File2, 3,, Open File, Text Documents (*.txt)
FileRead, text2, %file2%
    sAppend =  %text2%
    AppendText(hMainEdit, &sAppend)
SendMessage, 0x0115, 7, 0,, ahk_id %hMainEdit% ;WM_VSCROLL       ;Scroll to bottom
Return
;--------------------------------------------------------------------------------------------
#D::
DeleteCurrent:
MsgBox,4,, Are you sure that you want to delete %CurrentFileName%?
	IfMsgBox  No
    {
       Exit
    }
	IfMsgBox Yes
    {
      MsgBox, 4, confirmation, %CurrentFileName% will be deleted
       FileDelete, %CurrentFileName%
       gosub, FileNew
       Return
   }
Return
;---------------------------------------------------------------------------------
#C::
ReadClip:
GuiControl,, MainEdit, %Clipboard%  ; Put the text into the control.
Gui, Show,, Clipboard ; Show file name in title bar.
Return
;---------------------------------------------------------------------------------
AboutButtonOK:  ; This section is used by the "about box" above.
AboutGuiClose:
AboutGuiEscape:
Gui, 1: -Disabled  ; Re-enable the main window (must be done prior to the next step).
Gui, Destroy  ; Destroy the about box.
return
;---------------------------------------------------------------------------------
GuiDropFiles:  ; Support drag & drop.
Loop, Parse, A_GuiEvent, `n
{
    SelectedFileName = %A_LoopField%  ; Get the first file only (in case there's more than one).
    break
}
Gosub FileRead
return
;-------------------------------------------------------------------------------------
GuiSize:
if ErrorLevel = 1  ; The window has been minimized.  No action needed.
    return
; Otherwise, the window has been resized or maximized. Resize the Edit control to match.
NewWidth := A_GuiWidth - 20
NewHeight := A_GuiHeight - 20
GuiControl, Move, MainEdit, W%NewWidth% H%NewHeight%
return
;============= Append Function ======================================
AppendText(hEdit, ptrText) {
    SendMessage, 0x000E, 0, 0,, ahk_id %hEdit% ;WM_GETTEXTLENGTH
    SendMessage, 0x00B1, ErrorLevel, ErrorLevel,, ahk_id %hEdit% ;EM_SETSEL
    SendMessage, 0x00C2, False, ptrText,, ahk_id %hEdit% ;EM_REPLACESEL
}
;====================== TTS APP ============================================
;============================================================================
;This function will Get Selected Text to Clipboard automatically
;=========================                  Get Selected Text to Clipboard              =============================================
gst() {   ; GetSelectedText by Learning one
IsClipEmpty := (Clipboard = "") ? 1 : 0
if !IsClipEmpty {
ClipboardBackup := ClipboardAll
While !(Clipboard = "") {
Clipboard =
Sleep, 10
}
}
Send, ^c
ClipWait, 0.1
ToReturn := Clipboard, Clipboard := ClipboardBackup
if !IsClipEmpty
ClipWait, 0.5, 1
Return ToReturn
}
;================================  Volume MouseWheel  ========================================
~WheelUp::mouseWheelVolume("+8")
~WheelDown::mouseWheelVolume("-8")
mouseWheelVolume(step)
{  mouseGetPos,mx,my,wnd
   wingetClass,cls,ahk_id %wnd%
   if cls=Shell_TrayWnd
   {  SoundSet %step%
      soundSet 0,,mute
      soundGet vol
      ifInString,vol,.
         stringMid,vol,vol,1,% inStr(vol,".")-1
      ;tooltip, Volume:%vol%`%,% mx+8,% my+8,19
   }
}
   return
   ;========================================================================================
^\::Process, Close, SayDynamic.exe
+^a::Run,  C:\Program Files (x86)\TextAloud\TextaloudMP3.exe -auto, Hide ,PID
+^\::Process, Close, TextaloudMP3.exe 
;==================================================================
#Down::
send,  ^c 
Process, Close, SayDynamic.exe
   text := gst()
   Run, SayDynamic.exe %text%, C:\Say, Hide, PID
   Send, {Down}
return
;=======================================================================
#Right::
send,  ^c 
Process, Close, SayDynamic.exe
   text := gst()
   ;Run, SayDynamic.exe %text%, C:\Say, Hide, PID
   Send, {Down}
return
;============================= Exit ========================================

FileExit:     ; User chose "Exit" from the File menu.
GuiClose:  ; User closed the window.
ExitApp