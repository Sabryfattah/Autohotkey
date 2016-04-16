#\::
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
WinGetTitle, title, A
name := RegExReplace(title,"- Message.*", "")
	ToReturn := gst()
FileAppend, %ToReturn%,  D:\%name%.txt
   }
      return
   }
}
return

;This function will Get Selected Text to Clipboard automatically
;==========================================
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
return

#x::
ExitApp
return
