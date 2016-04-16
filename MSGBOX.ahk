#NoEnv

#Numpad2::
clipboard = ; Empty the clipboard
Send, ^c
ClipWait, 2
if ErrorLevel
{
    MsgBox, The attempt to copy text onto the clipboard failed.
    return
}
WinSet,  AlwaysOnTop, On, ReadBox
Gui, Font, s20  cFFFF00, Proxima Nova
Gui, color, black, black
GuiControl, +VScroll, Edit
Gui, Add, Edit, w1220 h650 cFFF000  ,  %clipboard% ; vword gNextWord
Run, SayDynamic.exe %clipboard%, C:\Say, Hide, PID
Gui, Show, x10 y10 w1250 h700, ReadBox
MouseClick Left, 100, 100
return


#Numpad1::
end:
Guiclose:
Process, Close, SayDynamic.exe
gui, destroy
return
;--------------------- Volume Control ----------------------------------------------------------------------
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