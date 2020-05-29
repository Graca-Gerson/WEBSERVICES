#INCLUDE  "PROTHEUS.CH"
#INCLUDE "APWEBEX.CH"

//-------------------------------------------------------------------------------------------------------
Web Function PWSV011()

Local cHtml := ""

WEB EXTENDED INIT cHtml START "InSite"

cHtml += ExecInPage( "PWSV011" )

WEB EXTENDED END

Return cHtml


//-------------------------------------------------------------------------------------------------------
Web Function PWSV012()

Local cHtml := ""

WEB EXTENDED INIT cHtml START "InSite"

cHtml += ExecInPage( "PWSV012" )

WEB EXTENDED END

Return cHtml


//-------------------------------------------------------------------------------------------------------
Web Function PWSV013()

Local cHtml := ""
Local oObj

WEB EXTENDED INIT cHtml START "InSite"

oObj := WSUSERPRESENTATION():New()

WsChgURL( @oObj, "USERPRESENTATION.apw" )

If Empty( HttpSession->PWSV013INFO )
	HttpSession->PWSV013INFO := { Nil, Nil }
EndIf

If ExistBlock('PEGETPRES')
	HttpSession->PWSV013INFO[1] := execBlock('PEGETPRES', .f., .f., {3, GetUsrCode()})
ElseIf oObj:GETPRESENTATION()
	HttpSession->PWSV013INFO[1] := oObj:cGETPRESENTATIONRESULT
EndIf

If oObj:GETDAILYNEWS()
	HttpSession->PWSV013INFO[2] := oObj:oWSGETDAILYNEWSRESULT
EndIf

If oObj:GETPHOTO()
	HttpSession->_IMG_INST := oObj:cGETPHOTORESULT
EndIf

cHtml += ExecInPage( "PWSV013" )

WEB EXTENDED END

Return cHtml