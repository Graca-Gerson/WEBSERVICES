#INCLUDE "TOTVS.CH"
User Function tstGet()
Local cHtmlPage
 
// Buscar página
cHtmlPage := Httpget('http://www.servidor.com.br/pageteste.htm')
conout("WebPage", cHtmlPage)
 
// Chamar página passando parâmetros
cHtmlPage := Httpget('http://www.servidor.com.br/funteste.asp?Id=123&Nome=Teste')
conout("WebPage", cHtmlPage)
 
// ou
cHtmlPage := Httpget('http://www.servidor.com.br/funteste.asp','Id=123&Nome=Teste')
conout("WebPage", cHtmlPage)
 
// ou utilizando a função Escape (recomendado)
cHtmlPage := Httpget('http://www.servidor.com.br/funteste.asp','Id=' + Escape('123') + '&Nome=' + Escape('Ana Silva'))
conout("WebPage", cHtmlPage)
Return