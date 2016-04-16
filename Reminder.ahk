#Persistent
MODIFIED=20120113
;-----------------------------Environment   --------------------------------------------------------------------------------
#NoEnv                        ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input                ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
;---------- Select data file
F1= data\Reminders.txt
S=;                          ;-- COMMA is the delimiter
filename1 :=%modified% . "ADD-MODIFY-DELETE          Edit=RightClick            DELETE=DOUBLECLICK"
; ----------Build GUI --------
Gui +Resize
Gui , Font, S12
Gui, Add, Button, x+ y+8 , AddNew
Gui, Add, Button, x+10 yp, Refresh
Gui, Add, Button, x+10 yp, ReWrite
Gui, Add,Text, x+10 yp+8 h25 w280 , SEARCH FOR  TASK IN LIST
Gui, Add, edit, xp+230 yp h25 w100 vWordToSearch gSearch
; Create the ListView and its columns:
Gui, Add, ListView, backgroundteal cwhite xm r20 w1150 grid checked AltSubmit vMyListView gMyListView, Task|Date|Priority|Category|Remarks
;----------Fill Listview --------------------
gosub,LB1
;----------------Make all columns sortable ------------------
LV_ModifyCol(1, 350)  ; For sorting, indicate that the Size column is an integer.
LV_ModifyCol(2, 100)  ; For sorting, indicate that the Size column is an integer.
LV_ModifyCol(3, 100)  ; For sorting, indicate that the Size column is an integer.
LV_ModifyCol(4, 300)  ; For sorting, indicate that the Size column is an integer.
LV_ModifyCol(5, 300)  ; For sorting, indicate that the Size column is an integer.
LV_ModifyCol(6, 300)  ; For sorting, indicate that the Size column is an integer.
; ---------- Show Listview -------------------------------------
Gui, Show, , %filename1%
GuiControl,Focus,WordToSearch
return
;======================= Listview ===========================
; Gather a list of file names from the selected folder and append them to the ListView:
MyListView:
Gui, Submit,nohide
Gui,1:ListView, MyListView
  RN:=LV_GetNext("C")
  RF:=LV_GetNext("F")
  GC:=LV_GetCount()
  
  ;------- which column  LV_1 is the name of Listview variable -----------------
if A_GuiEvent=ColClick
   {
   gosub,cc
   return
   }
;----------------------------------
;GuiControlGet, MyListView
; ----------------------- One Click  to highlight the row
if A_GuiEvent = Normal
{
LV_GetText(C1,A_EventInfo,1)
LV_GetText(C2,A_EventInfo,2)
LV_GetText(C2,A_EventInfo,3)
LV_GetText(C2,A_EventInfo,4)
LV_GetText(C2,A_EventInfo,5)
GuiControl, , C,%C1% %C2%  %C3%  %C4%  %C5%
}
; ------------ Double Click to delete the row ------------------
if A_GuiEvent = DoubleClick
{
  row := LV_GetNext(, "focused")
  MsgBox row no. %row% deleted
  LV_Delete(row)
MouseGetPos,x,y
  }
return

;==================== RightClick to Edit row =================

if A_GuiEvent = RightClick
 {
  LV_GetText(C1,A_EventInfo,1)
  LV_GetText(C2,A_EventInfo,2)
  LV_GetText(C3,A_EventInfo,3)
  LV_GetText(C4,A_EventInfo,4)
  LV_GetText(C5,A_EventInfo,5)
  RN:=LV_GetNext("C")
  RF:=LV_GetNext("F")
  GC:=LV_GetCount()


GuiControl,3:Focus,Name
Gui,3:Font,  S10 CDefault , FixedSys

Gui,3:Add,Text,  x1  y5 w80 h20, AA
Gui,3:Add,Edit,  x80 y5 w500 h20 vA31, %C1%

Gui,3:Add,Text,  x1  y30 w80  h20, BB
Gui,3:Add,Edit,  x80 y30 w500 h20 vA32, %C2%

Gui,3:Add,Text,  x1  y60 w80  h20, CC
Gui,3:Add,Edit,  x80 y60 w500 h20 vA33, %C3%

Gui,3:Add,Text,  x1  y90 w80  h20, DD
Gui,3:Add,Edit,  x80 y90 w500 h20 vA34, %C4%

Gui,3:Add,Text,  x1  y90 w80  h20, EE
Gui,3:Add,Edit,  x80 y90 w500 h20 vA35, %C5%

Gui,3:Add, Button, x550 y120 w40 h25, OK
Gui,3:Show, x2 y385 w600 h150, MODIFY
return
;----------


3ButtonOK:
Gui,3:submit
FileRead, FileContent, %F1%
FileDelete, %F1%
StringReplace, FileContent, FileContent, %C1%%s%%C2%%s%%C3%%s%%C4%%s%%C5% , %A31%%s%%A32%%s%%A33%%s%%A34%%s%%A35%
FileAppend, %FileContent%, %F1%
GoSub, LB1

3GuiClose:
3GuiEscape:
Gui, 3:Destroy
return
 }
;------------ END EDIT MODIFY LV --------
;------------ END EDIT MODIFY LV --------

;------------------------- Fill the Listview ------------------------------
; fill the listview table
LB1:
Gui, 1: default
Gui, Listview, Mylistview
LV_Delete()
loop,read,%F1%
{
stringsplit, BX,A_LoopReadLine,`;
LV_Add("", BX1,BX2,BX3,BX4,BX5)
}
return
;---------------------- Refresh Button  ----------------------------
; Button Refresh action is to read the file again
ButtonRefresh:
LV_Delete()
loop,read,%F1%
{
stringsplit, BX, A_LoopReadLine,`;
LV_Add("", BX1,BX2,BX3,BX4,BX5)
}
return
;----------------------Add Button -----------------------------------
; Add button
ButtonAddNew:
C1:=
C2:=
C3:=
C4:=
C5:=
GuiControl,,C1, %C1%
GuiControl,,C2, %C2%
GuiControl,,C3, %C3%
GuiControl,,C4, %C4%
GuiControl,,C5, %C5%
GuiControl, focus, C1
;=================== DATA ENTRY FORM ==============================
; DATA Entry Form use #x to trigger, change labels to suit your purpose and to match listviews

Gui,2:Font,  S11 C0000, Tahoma

Gui,2:Add,Text, x1  y5   w80  h20, Task
Gui,2:Add,Edit, x80 y5   w590 h20 vC1,%C1%


Gui,2:Add,Text, x1  y35  w80  h20, Date
Gui,2:Add,Edit, x80 y35  w590 h20 vC2,%C2%

;Gui,2: Add,Text, x1  y35  w80  h20,Time
;Gui,2: Add, DropDownList, x80 y35 w590 vC2, N1|N2|N3|N4|N5


Gui,2: Add, Text, x1  y65  w80  h20, Priority
Gui,2: Add, Edit, x80 y65  w590 h20 vC3, %C3%

Gui,2: Add, Text, x1  y95  w80  h20, Category
Gui,2: Add, Edit, x80 y95  w590 h20 vC4,%C4%

Gui,2: Add, Text, x1  y125 w80  h20, Remarks
Gui,2: Add, Edit, x80 y125 w590 h20 vC5,%C5%

Gui,2: Add, Button, x385 y150 w70 h25, CLEAR
Gui,2: Add, Button, x465 y150 w80 h25, CANCEL
Gui,2: Add, Button, x555 y150 w40 h25, OK

Gui,2: Show, x0 y0 w1150 h180, DATA-INPUT
return
;-------------------- Write Button  and Backup Old file ---------------------------------------------------
Buttonrewrite:
FileRead, content, %F1%
FileAppend, %Content% ,  backup/%A_Now%.txt
;FileAppend, %F1%.* , A_Now ".txt"

FileDelete, %F1%

loop, % LV_GetCount() 
{		

	RowNum := A_Index

	loop, 5

		LV_GetText(col%A_Index% , RowNum, a_index)

	FileAppend, % col1 ";" col2 ";" col3 ";" col4 ";" col5 "`n", % F1

}

Run , %F1%
return
;----------------------- Button OK, Close or Escape in DATA Entry Form ---------------------------------------------------------
; button OK or close or escape will make view disappear
2ButtonOK:
2GuiClose:
2GuiEscape:
Gui,2:submit
IF C1=
{
Gui destroy
return
}
;----------------------after closing the DATA Entry Form Write content to File -----------------------------------------
FILEAPPEND, %C1%`; %C2%`; %C3% `; %C4% `; %C5%`r`n, %F1%
gosub,LB1
Return
;-------------------- Cancel Button  In DATA Entry Form ----------
; Cancel will remove DATA ENTRY window 2
2ButtonCancel:
Gui,2: destroy
return
;-----------------------Clear Button In DATA Entry Form ------
; Clear button will clear fields in DATA ENTRY window 2
2ButtonClear:
C1:=
C2:=
C3:=
C4:=
C5:=
GuiControl,, C1, %C1%
GuiControl,, C2, %C2%
GuiControl,, C3, %C3%
GuiControl,, C4, %C4%
GuiControl,, C5, %C5%
GuiControl, focus, C1
Return
;================= Search Edit Field ===================================
Search:
gui, submit,nohide
I=0
LV_Delete()
loop,read,%F1%
  {
  LR:=A_LoopReadLine
  if LR=
   continue
  LR=%LR%                                    ;-- remove leading space
  stringsplit,C,LR,`;  ;%s%                       ;-- split with delimiter
  If InStr(LR,WordToSearch)
      {
      i++
      LV_Add("",C1,C2,C3,C4,C5)
      }
  }
GuiControl,1:,ix,%i%
return
;-------------- Function Get Listviewx  Columnx  --------------------------------------------------------
   CC:
   ;---- user jaysp Fri Aug 20, 2010 3:42 pm  Get Listview columnx
   ;-------- http://www.autohotkey.com/forum/viewtopic.php?t=61655&highlight=clicked+column ---
   ;MouseGetPos,x,y,%Filename1%                   ;-- Get mouse position relative to the window

   MouseGetPos X, Y, WinID, Ctrl
   GuiControlGet, LV_1, Pos                      ;-- Get the x coordinate of the listview relative to the window
   scrollpos := DllCall("GetScrollPos", "UInt", ChildHWND, "Int", 0) ;--Get the position of the scrollbar
   highcoord := LV_1X - scrollpos                ;-- Get the relative position on the x axis

   ;-- Get the widths of all columns
   w_index=0
   Loop % LV_GetCount("Column")
      {
      SendMessage, 4125, A_Index - 1, 0, SysListView321 ;-- Gets the width of each cell
      w_index += 1
      columnWidth%w_index% := ErrorLevel
      }

   ;-- Get the relative position of each cell, see if x falls in the range and display the column
   Loop, %w_index%
      {
      highcoord := highcoord + columnWidth%A_Index%
      lowcoord  := highcoord - columnWidth%A_Index%
      If x between %lowcoord% and %highcoord%
          Columnx:=A_index
      LV_GetText( ThisHeader, 0, columnx )       ; Get column header.
      }
return
;========================= end script Listview basics ==========================================
;================ Close App when XD is clicked ==========================
GuiClose:  ; When the window is closed, exit the script automatically:
ExitApp