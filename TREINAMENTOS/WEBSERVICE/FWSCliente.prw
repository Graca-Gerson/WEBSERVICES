#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://localhost:8070/ws/TCLIENTE.apw?WSDL
Gerado em        01/14/19 12:32:27
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _HBMXSOJ ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSTCLIENTE
------------------------------------------------------------------------------- */

WSCLIENT WSTCLIENTE

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD GRAVACLIENTE

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   oWSACLIENTE               AS TCLIENTE_CLIENTES
	WSDATA   cCCPF                     AS string
	WSDATA   c_CEMP                    AS string
	WSDATA   c_CFIL                    AS string
	WSDATA   cGRAVACLIENTERESULT       AS string

	// Estruturas mantidas por compatibilidade - NÃO USAR
	WSDATA   oWSCLIENTES               AS TCLIENTE_CLIENTES

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSTCLIENTE
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20170918 NG] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSTCLIENTE
	::oWSACLIENTE        := TCLIENTE_CLIENTES():New()

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWSCLIENTES        := ::oWSACLIENTE
Return

WSMETHOD RESET WSCLIENT WSTCLIENTE
	::oWSACLIENTE        := NIL 
	::cCCPF              := NIL 
	::c_CEMP             := NIL 
	::c_CFIL             := NIL 
	::cGRAVACLIENTERESULT := NIL 

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWSCLIENTES        := NIL
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSTCLIENTE
Local oClone := WSTCLIENTE():New()
	oClone:_URL          := ::_URL 
	oClone:oWSACLIENTE   :=  IIF(::oWSACLIENTE = NIL , NIL ,::oWSACLIENTE:Clone() )
	oClone:cCCPF         := ::cCCPF
	oClone:c_CEMP        := ::c_CEMP
	oClone:c_CFIL        := ::c_CFIL
	oClone:cGRAVACLIENTERESULT := ::cGRAVACLIENTERESULT

	// Estruturas mantidas por compatibilidade - NÃO USAR
	oClone:oWSCLIENTES   := oClone:oWSACLIENTE
Return oClone

// WSDL Method GRAVACLIENTE of Service WSTCLIENTE

WSMETHOD GRAVACLIENTE WSSEND oWSACLIENTE,cCCPF,c_CEMP,c_CFIL WSRECEIVE cGRAVACLIENTERESULT WSCLIENT WSTCLIENTE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GRAVACLIENTE xmlns="http://localhost:8070/">'
cSoap += WSSoapValue("ACLIENTE", ::oWSACLIENTE, oWSACLIENTE , "CLIENTES", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("CCPF", ::cCCPF, cCCPF , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("_CEMP", ::c_CEMP, c_CEMP , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("_CFIL", ::c_CFIL, c_CFIL , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</GRAVACLIENTE>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8070/GRAVACLIENTE",; 
	"DOCUMENT","http://localhost:8070/",,"1.031217",; 
	"http://localhost:8070/ws/TCLIENTE.apw")

::Init()
::cGRAVACLIENTERESULT :=  WSAdvValue( oXmlRet,"_GRAVACLIENTERESPONSE:_GRAVACLIENTERESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure CLIENTES

WSSTRUCT TCLIENTE_CLIENTES
	WSDATA   cA1_BAIRRO                AS string
	WSDATA   cA1_CEP                   AS string
	WSDATA   cA1_CGC                   AS string
	WSDATA   cA1_COD                   AS string
	WSDATA   cA1_COD_MUN               AS string
	WSDATA   cA1_CODPAIS               AS string
	WSDATA   cA1_EMAIL                 AS string
	WSDATA   cA1_END                   AS string
	WSDATA   cA1_ENDNUM                AS string
	WSDATA   cA1_EST                   AS string
	WSDATA   cA1_ESTADO                AS string
	WSDATA   cA1_INSCRM                AS string
	WSDATA   cA1_LOJA                  AS string
	WSDATA   cA1_MUN                   AS string
	WSDATA   cA1_NOME                  AS string
	WSDATA   cA1_NREDUZ                AS string
	WSDATA   cA1_PAIS                  AS string
	WSDATA   cA1_PESSOA                AS string
	WSDATA   cA1_TIPO                  AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT TCLIENTE_CLIENTES
	::Init()
Return Self

WSMETHOD INIT WSCLIENT TCLIENTE_CLIENTES
Return

WSMETHOD CLONE WSCLIENT TCLIENTE_CLIENTES
	Local oClone := TCLIENTE_CLIENTES():NEW()
	oClone:cA1_BAIRRO           := ::cA1_BAIRRO
	oClone:cA1_CEP              := ::cA1_CEP
	oClone:cA1_CGC              := ::cA1_CGC
	oClone:cA1_COD              := ::cA1_COD
	oClone:cA1_COD_MUN          := ::cA1_COD_MUN
	oClone:cA1_CODPAIS          := ::cA1_CODPAIS
	oClone:cA1_EMAIL            := ::cA1_EMAIL
	oClone:cA1_END              := ::cA1_END
	oClone:cA1_ENDNUM           := ::cA1_ENDNUM
	oClone:cA1_EST              := ::cA1_EST
	oClone:cA1_ESTADO           := ::cA1_ESTADO
	oClone:cA1_INSCRM           := ::cA1_INSCRM
	oClone:cA1_LOJA             := ::cA1_LOJA
	oClone:cA1_MUN              := ::cA1_MUN
	oClone:cA1_NOME             := ::cA1_NOME
	oClone:cA1_NREDUZ           := ::cA1_NREDUZ
	oClone:cA1_PAIS             := ::cA1_PAIS
	oClone:cA1_PESSOA           := ::cA1_PESSOA
	oClone:cA1_TIPO             := ::cA1_TIPO
Return oClone

WSMETHOD SOAPSEND WSCLIENT TCLIENTE_CLIENTES
	Local cSoap := ""
	cSoap += WSSoapValue("A1_BAIRRO", ::cA1_BAIRRO, ::cA1_BAIRRO , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_CEP", ::cA1_CEP, ::cA1_CEP , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_CGC", ::cA1_CGC, ::cA1_CGC , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_COD", ::cA1_COD, ::cA1_COD , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_COD_MUN", ::cA1_COD_MUN, ::cA1_COD_MUN , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_CODPAIS", ::cA1_CODPAIS, ::cA1_CODPAIS , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_EMAIL", ::cA1_EMAIL, ::cA1_EMAIL , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_END", ::cA1_END, ::cA1_END , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_ENDNUM", ::cA1_ENDNUM, ::cA1_ENDNUM , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_EST", ::cA1_EST, ::cA1_EST , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_ESTADO", ::cA1_ESTADO, ::cA1_ESTADO , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_INSCRM", ::cA1_INSCRM, ::cA1_INSCRM , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_LOJA", ::cA1_LOJA, ::cA1_LOJA , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_MUN", ::cA1_MUN, ::cA1_MUN , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_NOME", ::cA1_NOME, ::cA1_NOME , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_NREDUZ", ::cA1_NREDUZ, ::cA1_NREDUZ , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_PAIS", ::cA1_PAIS, ::cA1_PAIS , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_PESSOA", ::cA1_PESSOA, ::cA1_PESSOA , "string", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("A1_TIPO", ::cA1_TIPO, ::cA1_TIPO , "string", .T. , .F., 0 , NIL, .F.,.F.) 
Return cSoap


