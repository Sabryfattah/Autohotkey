#Persistent
FileDelete, weather.xml
FileDelete, news.txt
URLDownloadToFile, http://feeds.bbci.co.uk/news/rss.xml?edition=uk, newsuk.xml
FileRead, xmldata, newsuk.xml
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
fileappend,  `n %var1%. `n `n %var2% `n , news.txt
}
Fileread, news, News.txt
run, news.txt
return