FileDelete, temp.txt
#a:: 
Clipboard = 
Send ^c 
If Clipboard = ; if clipboard is empty skip search within glossary 
   Return 
lookup := Clipboard
URLDownloadToFile, http://lookwayup.com/lwu.exe//lwu/d?w=%lookup%, temp.txt
FILEREAD, STRING, temp.txt
TEXT := REGEXREPLACE(string, "<.*?>|(&#3(4|9);|\n)", "")
TEXT := REGEXREPLACE(text, ".*?(?=;1)", "") 
TEXT := REGEXREPLACE(text, "(?<=(popularity rank in the U.S)).*", "") 
TEXT := REGEXREPLACE(TEXT, "_uacct|;|&nbsp", "`n")
TEXT := REGEXREPLACE(TEXT, "What is the definition of|;(?=1)", "") 
TEXT := REGEXREPLACE(TEXT, "\.(?=(\d\.))", "`n") 
MsgBox %TEXT%
RETURN