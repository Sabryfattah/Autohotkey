#Persistent
FileDelete, newseg.txt
URLDownloadToFile, http://www.egyptindependent.com//rss-feed-term/113/rss.xml, newseg.xml
FileRead, xmldata, newseg.xml
doc := ComObjCreate("MSXML2.DOMDocument.6.0")
doc.loadXML(xmldata)
Loop, 15
{
x := A_Index
xpath = .//item[%x%]/title
ud := doc.selectSingleNode(xpath)
var1 := ud.text 
xpath = .//item[%x%]/description
ud := doc.selectSingleNode(xpath)
var2 := ud.text 
fileappend,  `n %var1%. `n `n %var2% `n , newseg.txt
}

Fileread, news, newseg.txt
text := RegExReplace(news, "(<[^>]*>|(&(r|l)dquo;?)|(&nbsp;s?)|(&(r|l)squo;s?)|(&quot;)|(&#39;(s|t)?))" , " `n")
FileDelete, newseg.txt
fileappend,  %text%, newseg.txt
run, newseg.txt
return