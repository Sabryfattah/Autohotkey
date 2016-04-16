^Z::
WinSet, AlwaysOnTop
Gui, Add, Text, w300, Author ; this just displays text as a label to the user
Gui, Add, Edit, w300 vAuthor, ; The edit box allows the user to type input. The vCall_Type associates a variable with that name to this control
Gui, Add, Text, w300, Title ; this just displays text as a label to the user
Gui, Add, Edit, w300 vTitle, ; The edit box allows the user to type input. The vCall_Type associates a variable with that name to this control
Gui, Add, Text, w300, Journal ; this just displays text as a label to the user
Gui, Add, Edit, w300 vJournal, ; The edit box allows the user to type input. The vCall_Type associates a variable with that name to this control
Gui, Add, Text, w300, Date_Pub. ; this just displays text as a label to the user
Gui, Add, Edit, w300 vDate_Pub, ; The edit box allows the user to type input. The vCall_Type associates a variable with that name to this control
Gui, Add, Text, w300, Volume ; this just displays text as a label to the user
Gui, Add, Edit, w300 vVolume, ; The edit box allows the user to type input. The vCall_Type associates a variable with that name to this control
Gui, Add, Text, w300, Issue_No ; this just displays text as a label to the user
Gui, Add, Edit, w300 vIssue_No, ; The edit box allows the user to type input. The vCall_Type associates a variable with that name to this control
Gui, Add, Text, w300, Pages ; this just displays text as a label to the user
Gui, Add, Edit, w300 vPages, ; The edit box allows the user to type input. The vCall_Type associates a variable with that name to this control
Gui, Add, Button, w300 gButton1, Send Data to File ; a button, the gButton1 is a gLabel which means that when the button is pressed, the code below with the label Button1 will be executed
Gui, Show, x1200 y0  ;Tells the script to display the Gui to the user. This allows you to build the whole Gui before displaying it
Return ; this tells the script to stop and wait for some input from the user

Button1:
; APA Style Citations: Author, I. N. (Year). Title of the article. Title of the Journal or Periodical, volume number, page numbers.
; 
Gui, Submit, NoHide ; this command tells the gui to get any variables which have been entered by the user, the NoHide means that the Gui will still be visible 
MsgBox, (%Author%  %Date_Pub%)  %Author%  %Date_Pub% `, `" %Title% `" `, %Journal% `, Vol. %Volume% `,  No. %Issue_No% `, pp. %Pages% `.
L = (%Author%  %Date_Pub%)
R = %Author%  (%Date_Pub%) `. %Title% `. %Journal% `, Vol. %Volume% `,  No. %Issue_No% `, pp. %Pages% `.
Clipboard=
IniWrite % Clipboard, Journal.txt, References, %R%
Return

^\::
Send %L%
Return

GuiClose:  ; this runs when the Gui is closed
ExitApp