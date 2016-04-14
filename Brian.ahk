#SingleInstance force
DetectHiddenWindows, On 
SetTitleMatchMode, 2 
;=============================== Read Aloud Contents of Clipboard copied by Mouse move ==================================
~LButton::
TimeButtonDown = %A_TickCount%
; Wait for it to be released
Loop
{
   Sleep 10
   GetKeyState, LButtonState, LButton, P
   if LButtonState = U  ; Button has been released.
      break
   elapsed = %A_TickCount%
   elapsed -= %TimeButtonDown%
   if elapsed > 200  ; Button was held down too long, so assume it's not a double-click.
   {
      MouseGetPos x0, y0            ; save start mouse position
      Loop
   {
     Sleep 20                    ; yield time to others
     GetKeyState keystate, LButton
     IfEqual keystate, U, {
       MouseGetPos x, y          ; position when button released
       break
     }
   }
   if (x-x0 > 5 or x-x0 < -5 or y-y0 > 5 or y-y0 < -5)
   {    
   Process, Close, SayDynamic.exe
   text := gst()
   Run, SayDynamic.exe %text%, C:\Say, Hide, PID
   }
      return
   }
}
return

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
return