#INCLUDE "APWEBEX.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "PLSMGER.CH"

/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪目北
北矲un噭o    砅PLCAB    矨utor  � Thiago Guilherme      � Data �024/01/14  潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪拇北
北�          矯ria o cabe鏰lho das not韈ias no portal					     潮�
北滥哪哪哪哪牧哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪馁北
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌
/*/

Web Function PPLCAB()

LOCAl cRet := ""
LOCAL cHtml := ""

WEB EXTENDED INIT cHtml START "InSite"

cRet := "<html>"
cRet += "<head>"
cRet += "<link href='imagens-pls/estilo.css' rel='stylesheet' type='text/css'>"
cRet += "<style type=text/css>"
cRet += "body { margin:0px; }"
cRet += "</style>"
cRet += "<script type='text/javascript' src='imagens-pls/jquery-1.7.1.min.js'></script> "
cRet += "<script type='text/javascript' src='imagens-pls/jspls.js'></script>"
cRet += "</head>"
cRet += "<BODY>"
cRet += "<div id='cab' onclick='openNews()'>"
cRet += "<h4><center>Espa鏾 Not韈ias</center></BODY></HTML></h4>"
cRet += "<span class='imgCabSpan'>"
cRet += "<img src='imagens-pls/hideNews.png' id='shNews' alt='expand/collapse' height='16' width='16' class='imgCab'/>"
cRet += "</span>"
cRet += "<span class='imgCabSpan'>"
cRet += "<img src='imagens-pls/news.png' alt='expand/collapse' height='16' width='16' class='imgCab'/>"
cRet += "</span>"
cRet += "</div>"
cRet += "</body>"
cRet += "</html>"

WEB EXTENDED END

Return cRet


