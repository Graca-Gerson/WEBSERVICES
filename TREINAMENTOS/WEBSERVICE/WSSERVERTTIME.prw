#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://localhost:8070/ws/SERVERTIME.apw?WSDL
Gerado em        01/10/19 11:40:11
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _ILZKELO ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSSERVERTIME
------------------------------------------------------------------------------- */

WSCLIENT WSSERVERTIME

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD GETSERVERTIME

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   cPARAMETRO                AS string
	WSDATA   cGETSERVERTIMERESULT      AS string

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSSERVERTIME
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20170918 NG] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSSERVERTIME
Return

WSMETHOD RESET WSCLIENT WSSERVERTIME
	::cPARAMETRO         := NIL 
	::cGETSERVERTIMERESULT := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSSERVERTIME
Local oClone := WSSERVERTIME():New()
	oClone:_URL          := ::_URL 
	oClone:cPARAMETRO    := ::cPARAMETRO
	oClone:cGETSERVERTIMERESULT := ::cGETSERVERTIMERESULT
Return oClone

// WSDL Method GETSERVERTIME of Service WSSERVERTIME

WSMETHOD GETSERVERTIME WSSEND cPARAMETRO WSRECEIVE cGETSERVERTIMERESULT WSCLIENT WSSERVERTIME
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETSERVERTIME xmlns="http://localhost:8070/">'
cSoap += WSSoapValue("PARAMETRO", ::cPARAMETRO, cPARAMETRO , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</GETSERVERTIME>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8070/GETSERVERTIME",; 
	"DOCUMENT","http://localhost:8070/",,"1.031217",; 
	"http://localhost:8070/ws/SERVERTIME.apw")

::Init()
::cGETSERVERTIMERESULT :=  WSAdvValue( oXmlRet,"_GETSERVERTIMERESPONSE:_GETSERVERTIMERESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.



