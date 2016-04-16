    #SingleInstance
    Clipboard =
    Gui, Font, S16 Tahoma
    Gui, Add, DateTime,, LongDate
    FormatTime, Time, , hh : mm : tt
    FormatTime, Date,, LongDate
    FormatTime, Day, LongDate, dddd
    today =   % “Today is” . Day . Date . "and the time now is" . Time 
	Voice := ComObjCreate("SAPI.SpVoice")
	Voice.Speak(Today, 0x1|0X2)
     Gui, show, ,  %Day% :: %Time%
    return