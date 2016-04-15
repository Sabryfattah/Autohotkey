ch1 := chr(185)
ch2 := chr(178)
ch3 := chr(179)
ch4 := chr(176)
;=========================== GUI ====================================
Menu, FileMenu, Add, &Delete, FileDelete  ; See remarks below about Ctrl+O.
Menu, FileMenu, Add, E&xit, Exit
Menu, HelpMenu, Add, &How to Search, Help
Menu, MyMenuBar, Add, &File, :FileMenu  ; Attach the two sub-menus that were created above.
Menu, MyMenuBar, Add, &Help, :HelpMenu
Gui, Font, s14 tahoma ;set font
Gui, +Resize
gui, add, text, x10 y10 w150, [Select a Folder]
gui, add, DropDownList, xp yp+30  w230 vPath, C:\|C:\AHK|C:\Users\Sabry\Documents\ScanSnap|"C:\Program Files (x86)"|"C:\Program Files"|C:\windows|C:\Users\Sabry\Downloads|C:\Perl64\lib|C:\Perl64\site\lib|-----------------------------------------------------------------------------------------------------
|D:\|D:\Cloud_Backup|D:\Documents|D:\Software|----------------------------------------------------------------------------------------------------------------------------------------
|E:\||E:\Confidential|E:\Correspondence|E:\Finance|E:\Computer|E:\Health|E:\Holidays|E:\Scanned|E:\Personal|E:\Writings|-----------------------------------------------------------------------------------------------------------------------------------------
|H:\
gui, add, text, xp yp+40 , [Select a file Extension]
gui, add, DropDownList, xp yp+30  w150  vEXT , *|TXT|PDF|DOCX|XLSX|DOC|XLS|AHK|HTML|PL|ZIP|RAR|EXE|COM|CSV|EPUB|MOBI
gui, add, text, xp yp+40 w150 , [Search Field]
gui, add, Edit, xp yp+30 w150 vString,
gui, add, text, xp yp+40 w180 , [Search and Open]
gui, add, button, xp yp+30 h35 w150 default gWhere, Search Names %ch1% 
gui, add, button, xp yp+40h35 w150 default gFindstr, Search Content %ch2%
gui, add, button, xp yp+40h35 w150 default gregex, Regex Search %ch3% 
gui, add, button, xp yp+40h35 w150 default gFolder, Open_Location %ch4% 
Gui, add, edit, x12 y410 w200 h25 vWord1, Enter word1
Gui, add, edit,  xp yp+40 w200 h25  vWord2, Enter word2
Gui, add, edit,  xp yp+40 w200 h25  vWord3, Enter word3
Gui, Font, s11 tahoma ;set font
gui, add, text, xp yp+40 h200 w200,
Gui, Font, s14 tahoma ;set font
Gui, Add, ListView, grid BackgroundFFDD99  r24 x250 y10 w980  vLV gFileList, FileList
Gui, Menu, MyMenuBar
gui, show, h500 W950 ; Show GUI
Return
;============================= SEARCH ING ================================================
; ----------------------------------------------------- Search for files (Where) ---------------------------------------------------------------
Where:
gui, Listview, LV
gui, submit, nohide 
; Focus on rows in LV2
GuiControl, Focus, FileList
Run, %comspec% /c where /R  %Path% `*%string%`*.%EXT%>tmp.txt, , Hide, PID
Gosub, Progress
gosub, FileList
return
;------------------------------------------------ Findstr ------------------------------------------------------------------------------------------
Findstr:
gui, Listview, LV
gui, submit, nohide
GuiControl, Focus, FileList
Run, %comspec% /c findstr /r /s /m /i /c:%string% `"%Path%`"\*.%ext%> tmp.txt , , Hide, PID
gosub, Progress
gosub, FileList
return
;===================================================================================
FileList:
gui, Listview, LV
gui, submit, nohide
GuiControl, Focus, FileList
LV_Delete()
Loop, read, tmp.txt
{
    Loop, parse, A_LoopReadLine, `n
    {
	LV_Add("",A_LoopField)
    LV_ModifyCol()
    }
}
if  A_GuiEvent = Doubleclick
 {
	LV_GetText(RowText, A_EventInfo)
	RunWait, %comspec% /c Start "" `"%RowText%`", , Hide
	}
Return
;==============================================================================================
Folder:
SplitPath, RowText, , Dir, , ,
RunWait, %comspec% /c Start "" `"%Dir%`", , Hide
Return
;===========================================================
Regex:
gui, Listview, LV
gui, submit, nohide
GuiControl, Focus, FileList
cr = ^
string = `"%word1%`".*`"%word2%`".*`"%word3%`"
Run, %comspec% /c findstr /r /s /m /i /c:`"%string%`" `"%Path%`"\*.%ext%> tmp.txt , , Hide, PID
gosub, Progress
gosub, FileList
return
;===================================
Exit:
gui, hide
Return
;=========================================================================
Progress:
cntr=1
Loop
{
;ifExist, C:\windows\system\ntimage.gif, SplashImage, %windir%\system32\ntimage.gif,,,, Installation
	Progress, %cntr%, `"%string%`" in %Path% , Searching....,Please Wait Search to finish [Esc to close], Tahoma
	cntr++
	sleep, 100
	If cntr > 100
		cntr = 1
		Process, Exist, %PID%
	If errorlevel = 0
   	     break
		
}
Progress, Off
Process, Close, findstr.exe
Return
;===============================================================
FileDelete:
RowNumber := LV_GetNext(RowNumber) 
LV_GetText(file2del, RowNumber)
MsgBox The following file will be deleted : `n`r %file2del%
FileDelete, %file2del%
return

Help:
MsgBox, , How to Search,  (1)%ch1%  Search Names : Enter name of a file names (or part of it). `n(2)%ch2% Search Content : to find files containing any on of the words entered in the Search Field, or to find an exact phrase enter it inside quotes "".`n(3)%ch3% Regex Search: to search for  "word1" "word2" "word3"  on same line in file, enter it in corresponding fields then click Regex Search.`n(4)%ch4% Open Location: Open file in listview before opening location.`n `r For Example to search for "Visa Debit Card" as an exact "quoted" phrase use the search field.`n If you want to search for a file where Visa AND Debit AND Card are separated by any text on the same line, use Regex
Return

MenuHandler:

Return

HelpMenu:
Return
;=========================================================
Escape::
Process, Close, findstr.exe
Process, Close, where.exe
return
;==========================================================