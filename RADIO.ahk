#Persistent
#NoEnv
SetBatchLines -1
DetectHiddenWindows, On
SetTitleMatchMode, 2
;-----------------------------------------------------------------------------------------------------------
vlcx  = C:\Users\Sabry\AppData\Local\Screamer Radio\sc.exe
Stations =                     

(Join| 
Venice;http://109.123.116.202:8022/ ;
BBC1;http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio2_mf_pls;
BBC1Extra;http://www.bbc.co.uk/radio/listen/live/r1x_aaclca.pls;
BBC2;http://www.bbc.co.uk/radio/listen/live/r2_aaclca.pls ;
BBC3;http://www.bbc.co.uk/radio/listen/live/r3_aaclca.pls ;
BBC4;http://www.bbc.co.uk/radio/listen/live/r4_aaclca.pls ;
Cinemix;http://94.23.51.96:8000/listen.pls; http://www.cinemix.us ;
BBCWorld;http://www.bbc.co.uk/worldservice/meta/tx/nb/live/ennws.pls ;
Newcastle;http://bbc.co.uk/radio/listen/live/bbcnewcastle.asx ; 
ClassicFM; http://media-ice.musicradio.com/ClassicFM.m3u;
PianoSolo;http://vistaweb.streamguys.com/pianosolo64k.asx;
Radio Mozart; http://listen.radionomy.com/radio-mozart.m3u;
Radio Misr; http://www.streamingthe.net/Radio-Masr-88.7-FM-Cairo/p/24249 ;
)
stringsplit,g,stations,|               
           total :=g0                      
;===============================================================================
Gui, Color, 000000  
GuiControl, +Center, WinText
Gui, Font, S12  Bold, Tahoma  
Gui, Add, picture, x10 y10 gMute, ico/Mute.jpg
Gui, Add, picture, xp+50 gStop, ico/Stop.jpg
Gui, Add, Picture, xp+50 gReplay, ico/play.jpg
Gui, Add, Picture, xp+50  gRecord, ico/Record.jpg
Gui, Add, Picture, xp+50 gQuit, ico/Quit.jpg
Gui, Add, Picture, x180 yp+80 gPlus, ico/Plus.jpg
Gui, Add, Picture, x180 yp+120 gMinus, ico/Minus.jpg
Gui, Add, Picture, x180 yp+120 gCompress, ico/Compressor.jpg
Gui, Font, cFFFFFF s12 q5
;Gui, Show, w440 h50, Volume Slider
gui, add,text,section x10 y60 w0 h0,  
Gui, Add, StatusBar, BackGroundFFB1,
Gui, Show, x1200 y1 w265 h500, Internet Radio
gosub,readbuttons                 
loop,%total%                       
  ib%a_index%:=a_index
gosub,readstations             
return
;-----------------------------------------------------------------------------------------
Readbuttons:                         
loop,
  {
  loop,parse,stations,`|        
     {
     x=%a_loopfield%           
     stringreplace,x,x,|,,all    
     stringsplit,h,x,`;           
     Gui, Add, Button, xp   y+7 h23 w150 vIB%a_index% gStartButton,%h1%   
     GuiControl, enable,IB%a_index% 
     if (a_index=total)           
         return
      }
   }
return
;---------------------------------------------------------------------------------
Readstations:
  loop,parse,stations,`|                   
     {
     x=%a_loopfield%                    
    stringreplace,x,x,|,,all               
    stringsplit,h,x,`;  
    h1=%h1%    
    h2=%h2%                                
    url%a_index%=
    url%a_index%  .= h2                 
      }
return
;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
startbutton:
gui, submit,nohide 
r:=%a_GuiControl%                        
if r=                                               
  return
selected=%r%                            
e:=url%r%                                     
gosub,clears
GuiControl, disable,  IB%r%  
GuiControlGet, IB%r%
name := % IB%r% 
SB_SetText("Current Station:    " name)
gosub quit
gosub, run                                     
return
;---------------------------------------------------------------------------------
Run:
Run, C:\Users\Sabry\AppData\Local\Screamer Radio\sc.exe %e%,, Hide, PID
;Run, C:\Program Files\MPC-HC\mpc-hc64.exe %e%,, Hide, PID
return
;--------------------------------------------------------------------------------
Mute:
ControlSend, , m, C:\Users\Sabry\AppData\Local\Screamer Radio\sc.exe ahk_class ConsoleWindowClass
return
;--------------------------------------------------------------------------------
Stop:
ControlSend, , s, C:\Users\Sabry\AppData\Local\Screamer Radio\sc.exe ahk_class ConsoleWindowClass
return
;------------
;--------------------------------------------------------------------------------
Record:
ControlSend, , r, C:\Users\Sabry\AppData\Local\Screamer Radio\sc.exe ahk_class ConsoleWindowClass
return
;------------
;--------------------------------------------------------------------------------
Quit:
ControlSend, , q, C:\Users\Sabry\AppData\Local\Screamer Radio\sc.exe ahk_class ConsoleWindowClass
return
;------------
;--------------------------------------------------------------------------------
Replay:
ControlSend, , p, C:\Users\Sabry\AppData\Local\Screamer Radio\sc.exe ahk_class ConsoleWindowClass
return
;------------
;--------------------------------------------------------------------------------
Plus:
ControlSend, , {+}, C:\Users\Sabry\AppData\Local\Screamer Radio\sc.exe ahk_class ConsoleWindowClass
return
;------------
;--------------------------------------------------------------------------------
Minus:
ControlSend, , {-}, C:\Users\Sabry\AppData\Local\Screamer Radio\sc.exe ahk_class ConsoleWindowClass
return
;------------
;--------------------------------------------------------------------------------
Compress:
ControlSend, , c, C:\Users\Sabry\AppData\Local\Screamer Radio\sc.exe ahk_class ConsoleWindowClass
return
;------------
;------------------------------------------------------------------------------------------------------------
clears:
loop,%total%
   {
   GuiControl, enable,IB%a_index%
   GuiControl, enable,RB%a_index%
   }
return
;===================  Volume MouseWheel  ===========================
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
;------------------------------------------------------------------------------------------------------
/*VolumeGLabel: ; Sets volume, controlled by slider
	Gui, Submit, NoHide
	SoundSet, %VolumeControl%, Wave
	GuiControl,, VolumeDisplay, Volume: %VolumeControl% `%
Return
Gui, Add, Text, x40 y455 w180 h30 vVolumeDisplay +Left +0x200 BackgroundTrans, Volume: 0`%
Gui, Add, Slider, x10 y480 w160 h30 -Theme Thick25 NoTicks Range0-100 Center vVolumeControl gVolumeGLabel AltSubmit, 0 ; Last number is position of slider (0 - 100)
Gui,  Add, Button, x190 y480 w50 h26 -Theme gMuteVolumeButton, Mute
MuteVolumeButton:
	toggle := !toggle ; Toggles "Mute" button for on/off effect
	If toggle
		{
			GuiControl, Text, VolumeDisplay, Volume: (muted)
			GuiControl, Disable, VolumeControl
			SoundSet, 0, Wave
		}
	If !toggle
		{
			Gui, Submit, NoHide
			GuiControl, Text, VolumeDisplay, Volume: %VolumeControl%`%
			GuiControl, Enable, VolumeControl
			SoundSet, %VolumeControl%, Wave
		}
Return
*/
;===============================================================
escape:
ExitApp
return




