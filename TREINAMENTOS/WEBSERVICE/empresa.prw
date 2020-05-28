#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://localhost:8070/ws/CTT.apw?WSDL
Gerado em        01/11/19 11:11:44
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _PMSSLMD ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSCTT
------------------------------------------------------------------------------- */

WSCLIENT WSCTT

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD LISTAEMPRESA

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   cCCODEMP                  AS string
	WSDATA   oWSLISTAEMPRESARESULT     AS CTT_ARRAYOFESTRUTURAEMP

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSCTT
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20170918 NG] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSCTT
	::oWSLISTAEMPRESARESULT := CTT_ARRAYOFESTRUTURAEMP():New()
Return

WSMETHOD RESET WSCLIENT WSCTT
	::cCCODEMP           := NIL 
	::oWSLISTAEMPRESARESULT := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSCTT
Local oClone := WSCTT():New()
	oClone:_URL          := ::_URL 
	oClone:cCCODEMP      := ::cCCODEMP
	oClone:oWSLISTAEMPRESARESULT :=  IIF(::oWSLISTAEMPRESARESULT = NIL , NIL ,::oWSLISTAEMPRESARESULT:Clone() )
Return oClone

// WSDL Method LISTAEMPRESA of Service WSCTT

WSMETHOD LISTAEMPRESA WSSEND cCCODEMP WSRECEIVE oWSLISTAEMPRESARESULT WSCLIENT WSCTT
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<LISTAEMPRESA xmlns="http://localhost:8070/">'
cSoap += WSSoapValue("CCODEMP", ::cCCODEMP, cCCODEMP , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</LISTAEMPRESA>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8070/LISTAEMPRESA",; 
	"DOCUMENT","http://localhost:8070/",,"1.031217",; 
	"http://localhost:8070/ws/CTT.apw")

::Init()
::oWSLISTAEMPRESARESULT:SoapRecv( WSAdvValue( oXmlRet,"_LISTAEMPRESARESPONSE:_LISTAEMPRESARESULT","ARRAYOFESTRUTURAEMP",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure ARRAYOFESTRUTURAEMP

WSSTRUCT CTT_ARRAYOFESTRUTURAEMP
	WSDATA   oWSESTRUTURAEMP           AS CTT_ESTRUTURAEMP OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CTT_ARRAYOFESTRUTURAEMP
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CTT_ARRAYOFESTRUTURAEMP
	::oWSESTRUTURAEMP      := {} // Array Of  CTT_ESTRUTURAEMP():New()
Return

WSMETHOD CLONE WSCLIENT CTT_ARRAYOFESTRUTURAEMP
	Local oClone := CTT_ARRAYOFESTRUTURAEMP():NEW()
	oClone:oWSESTRUTURAEMP := NIL
	If ::oWSESTRUTURAEMP <> NIL 
		oClone:oWSESTRUTURAEMP := {}
		aEval( ::oWSESTRUTURAEMP , { |x| aadd( oClone:oWSESTRUTURAEMP , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CTT_ARRAYOFESTRUTURAEMP
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_ESTRUTURAEMP","ESTRUTURAEMP",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSESTRUTURAEMP , CTT_ESTRUTURAEMP():New() )
			::oWSESTRUTURAEMP[len(::oWSESTRUTURAEMP)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ESTRUTURAEMP

WSSTRUCT CTT_ESTRUTURAEMP
	WSDATA   cM0_ACTRAB                AS string
	WSDATA   cM0_ASSPAT1               AS string
	WSDATA   cM0_ASSPAT2               AS string
	WSDATA   cM0_ASSPAT3               AS string
	WSDATA   cM0_BAIRCOB               AS string
	WSDATA   cM0_BAIRENT               AS string
	WSDATA   cM0_CAIXA                 AS string
	WSDATA   cM0_CAUSA                 AS string
	WSDATA   cM0_CEPCOB                AS string
	WSDATA   cM0_CEPENT                AS string
	WSDATA   cM0_CGC                   AS string
	WSDATA   nM0_CHKSUM                AS integer
	WSDATA   cM0_CIDCOB                AS string
	WSDATA   cM0_CIDENT                AS string
	WSDATA   cM0_CNAE                  AS string
	WSDATA   cM0_CNES                  AS string
	WSDATA   cM0_COD_ATV               AS string
	WSDATA   cM0_CODFIL                AS string
	WSDATA   cM0_CODIGO                AS string
	WSDATA   cM0_CODMUN                AS string
	WSDATA   cM0_CODZOSE               AS string
	WSDATA   cM0_COMPCOB               AS string
	WSDATA   cM0_COMPENT               AS string
	WSDATA   cM0_CORPKEY               AS string
	WSDATA   cM0_CTPSW                 AS string
	WSDATA   cM0_DESZOSE               AS string
	WSDATA   nM0_DOCSEQ                AS integer
	WSDATA   cM0_DSCCNA                AS string
	WSDATA   dM0_DTAUTOR               AS date
	WSDATA   cM0_DTBASE                AS string
	WSDATA   dM0_DTRE                  AS date
	WSDATA   dM0_DTRNTRC               AS date
	WSDATA   dM0_DTVLD                 AS date
	WSDATA   cM0_EMERGEN               AS string
	WSDATA   cM0_EMPB2B                AS string
	WSDATA   cM0_ENDCOB                AS string
	WSDATA   cM0_ENDENT                AS string
	WSDATA   cM0_EQUIP                 AS string
	WSDATA   cM0_ESTCOB                AS string
	WSDATA   cM0_ESTENT                AS string
	WSDATA   cM0_FAX                   AS string
	WSDATA   cM0_FAX_IMP               AS string
	WSDATA   cM0_FAX_PO                AS string
	WSDATA   cM0_FILIAL                AS string
	WSDATA   cM0_FPAS                  AS string
	WSDATA   cM0_IMP_CON               AS string
	WSDATA   cM0_INS_SUF               AS string
	WSDATA   cM0_INSC                  AS string
	WSDATA   cM0_INSCANT               AS string
	WSDATA   cM0_INSCM                 AS string
	WSDATA   cM0_INTCTRL               AS string
	WSDATA   cM0_LEIAUTE               AS string
	WSDATA   cM0_LIBMOD                AS string
	WSDATA   cM0_LICENSA               AS string
	WSDATA   cM0_MODEND                AS string
	WSDATA   cM0_MODINSC               AS string
	WSDATA   cM0_NATJUR                AS string
	WSDATA   cM0_NIRE                  AS string
	WSDATA   cM0_NOME                  AS string
	WSDATA   cM0_NOMECOM               AS string
	WSDATA   nM0_NUMPROP               AS integer
	WSDATA   cM0_PICTURE               AS string
	WSDATA   cM0_PRODRUR               AS string
	WSDATA   cM0_PSW                   AS string
	WSDATA   cM0_PSWSTRT               AS string
	WSDATA   cM0_RNTRC                 AS string
	WSDATA   cM0_SEQUENC               AS string
	WSDATA   nM0_SIZEFIL               AS integer
	WSDATA   cM0_STATUS                AS string
	WSDATA   cM0_TEL                   AS string
	WSDATA   cM0_TEL_IMP               AS string
	WSDATA   cM0_TEL_PO                AS string
	WSDATA   cM0_TPESTAB               AS string
	WSDATA   nM0_TPINSC                AS integer
	WSDATA   cX_MENSAGEM               AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CTT_ESTRUTURAEMP
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CTT_ESTRUTURAEMP
Return

WSMETHOD CLONE WSCLIENT CTT_ESTRUTURAEMP
	Local oClone := CTT_ESTRUTURAEMP():NEW()
	oClone:cM0_ACTRAB           := ::cM0_ACTRAB
	oClone:cM0_ASSPAT1          := ::cM0_ASSPAT1
	oClone:cM0_ASSPAT2          := ::cM0_ASSPAT2
	oClone:cM0_ASSPAT3          := ::cM0_ASSPAT3
	oClone:cM0_BAIRCOB          := ::cM0_BAIRCOB
	oClone:cM0_BAIRENT          := ::cM0_BAIRENT
	oClone:cM0_CAIXA            := ::cM0_CAIXA
	oClone:cM0_CAUSA            := ::cM0_CAUSA
	oClone:cM0_CEPCOB           := ::cM0_CEPCOB
	oClone:cM0_CEPENT           := ::cM0_CEPENT
	oClone:cM0_CGC              := ::cM0_CGC
	oClone:nM0_CHKSUM           := ::nM0_CHKSUM
	oClone:cM0_CIDCOB           := ::cM0_CIDCOB
	oClone:cM0_CIDENT           := ::cM0_CIDENT
	oClone:cM0_CNAE             := ::cM0_CNAE
	oClone:cM0_CNES             := ::cM0_CNES
	oClone:cM0_COD_ATV          := ::cM0_COD_ATV
	oClone:cM0_CODFIL           := ::cM0_CODFIL
	oClone:cM0_CODIGO           := ::cM0_CODIGO
	oClone:cM0_CODMUN           := ::cM0_CODMUN
	oClone:cM0_CODZOSE          := ::cM0_CODZOSE
	oClone:cM0_COMPCOB          := ::cM0_COMPCOB
	oClone:cM0_COMPENT          := ::cM0_COMPENT
	oClone:cM0_CORPKEY          := ::cM0_CORPKEY
	oClone:cM0_CTPSW            := ::cM0_CTPSW
	oClone:cM0_DESZOSE          := ::cM0_DESZOSE
	oClone:nM0_DOCSEQ           := ::nM0_DOCSEQ
	oClone:cM0_DSCCNA           := ::cM0_DSCCNA
	oClone:dM0_DTAUTOR          := ::dM0_DTAUTOR
	oClone:cM0_DTBASE           := ::cM0_DTBASE
	oClone:dM0_DTRE             := ::dM0_DTRE
	oClone:dM0_DTRNTRC          := ::dM0_DTRNTRC
	oClone:dM0_DTVLD            := ::dM0_DTVLD
	oClone:cM0_EMERGEN          := ::cM0_EMERGEN
	oClone:cM0_EMPB2B           := ::cM0_EMPB2B
	oClone:cM0_ENDCOB           := ::cM0_ENDCOB
	oClone:cM0_ENDENT           := ::cM0_ENDENT
	oClone:cM0_EQUIP            := ::cM0_EQUIP
	oClone:cM0_ESTCOB           := ::cM0_ESTCOB
	oClone:cM0_ESTENT           := ::cM0_ESTENT
	oClone:cM0_FAX              := ::cM0_FAX
	oClone:cM0_FAX_IMP          := ::cM0_FAX_IMP
	oClone:cM0_FAX_PO           := ::cM0_FAX_PO
	oClone:cM0_FILIAL           := ::cM0_FILIAL
	oClone:cM0_FPAS             := ::cM0_FPAS
	oClone:cM0_IMP_CON          := ::cM0_IMP_CON
	oClone:cM0_INS_SUF          := ::cM0_INS_SUF
	oClone:cM0_INSC             := ::cM0_INSC
	oClone:cM0_INSCANT          := ::cM0_INSCANT
	oClone:cM0_INSCM            := ::cM0_INSCM
	oClone:cM0_INTCTRL          := ::cM0_INTCTRL
	oClone:cM0_LEIAUTE          := ::cM0_LEIAUTE
	oClone:cM0_LIBMOD           := ::cM0_LIBMOD
	oClone:cM0_LICENSA          := ::cM0_LICENSA
	oClone:cM0_MODEND           := ::cM0_MODEND
	oClone:cM0_MODINSC          := ::cM0_MODINSC
	oClone:cM0_NATJUR           := ::cM0_NATJUR
	oClone:cM0_NIRE             := ::cM0_NIRE
	oClone:cM0_NOME             := ::cM0_NOME
	oClone:cM0_NOMECOM          := ::cM0_NOMECOM
	oClone:nM0_NUMPROP          := ::nM0_NUMPROP
	oClone:cM0_PICTURE          := ::cM0_PICTURE
	oClone:cM0_PRODRUR          := ::cM0_PRODRUR
	oClone:cM0_PSW              := ::cM0_PSW
	oClone:cM0_PSWSTRT          := ::cM0_PSWSTRT
	oClone:cM0_RNTRC            := ::cM0_RNTRC
	oClone:cM0_SEQUENC          := ::cM0_SEQUENC
	oClone:nM0_SIZEFIL          := ::nM0_SIZEFIL
	oClone:cM0_STATUS           := ::cM0_STATUS
	oClone:cM0_TEL              := ::cM0_TEL
	oClone:cM0_TEL_IMP          := ::cM0_TEL_IMP
	oClone:cM0_TEL_PO           := ::cM0_TEL_PO
	oClone:cM0_TPESTAB          := ::cM0_TPESTAB
	oClone:nM0_TPINSC           := ::nM0_TPINSC
	oClone:cX_MENSAGEM          := ::cX_MENSAGEM
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CTT_ESTRUTURAEMP
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cM0_ACTRAB         :=  WSAdvValue( oResponse,"_M0_ACTRAB","string",NIL,"Property cM0_ACTRAB as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_ASSPAT1        :=  WSAdvValue( oResponse,"_M0_ASSPAT1","string",NIL,"Property cM0_ASSPAT1 as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_ASSPAT2        :=  WSAdvValue( oResponse,"_M0_ASSPAT2","string",NIL,"Property cM0_ASSPAT2 as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_ASSPAT3        :=  WSAdvValue( oResponse,"_M0_ASSPAT3","string",NIL,"Property cM0_ASSPAT3 as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_BAIRCOB        :=  WSAdvValue( oResponse,"_M0_BAIRCOB","string",NIL,"Property cM0_BAIRCOB as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_BAIRENT        :=  WSAdvValue( oResponse,"_M0_BAIRENT","string",NIL,"Property cM0_BAIRENT as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CAIXA          :=  WSAdvValue( oResponse,"_M0_CAIXA","string",NIL,"Property cM0_CAIXA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CAUSA          :=  WSAdvValue( oResponse,"_M0_CAUSA","string",NIL,"Property cM0_CAUSA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CEPCOB         :=  WSAdvValue( oResponse,"_M0_CEPCOB","string",NIL,"Property cM0_CEPCOB as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CEPENT         :=  WSAdvValue( oResponse,"_M0_CEPENT","string",NIL,"Property cM0_CEPENT as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CGC            :=  WSAdvValue( oResponse,"_M0_CGC","string",NIL,"Property cM0_CGC as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::nM0_CHKSUM         :=  WSAdvValue( oResponse,"_M0_CHKSUM","integer",NIL,"Property nM0_CHKSUM as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cM0_CIDCOB         :=  WSAdvValue( oResponse,"_M0_CIDCOB","string",NIL,"Property cM0_CIDCOB as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CIDENT         :=  WSAdvValue( oResponse,"_M0_CIDENT","string",NIL,"Property cM0_CIDENT as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CNAE           :=  WSAdvValue( oResponse,"_M0_CNAE","string",NIL,"Property cM0_CNAE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CNES           :=  WSAdvValue( oResponse,"_M0_CNES","string",NIL,"Property cM0_CNES as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_COD_ATV        :=  WSAdvValue( oResponse,"_M0_COD_ATV","string",NIL,"Property cM0_COD_ATV as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CODFIL         :=  WSAdvValue( oResponse,"_M0_CODFIL","string",NIL,"Property cM0_CODFIL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CODIGO         :=  WSAdvValue( oResponse,"_M0_CODIGO","string",NIL,"Property cM0_CODIGO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CODMUN         :=  WSAdvValue( oResponse,"_M0_CODMUN","string",NIL,"Property cM0_CODMUN as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CODZOSE        :=  WSAdvValue( oResponse,"_M0_CODZOSE","string",NIL,"Property cM0_CODZOSE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_COMPCOB        :=  WSAdvValue( oResponse,"_M0_COMPCOB","string",NIL,"Property cM0_COMPCOB as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_COMPENT        :=  WSAdvValue( oResponse,"_M0_COMPENT","string",NIL,"Property cM0_COMPENT as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CORPKEY        :=  WSAdvValue( oResponse,"_M0_CORPKEY","string",NIL,"Property cM0_CORPKEY as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_CTPSW          :=  WSAdvValue( oResponse,"_M0_CTPSW","string",NIL,"Property cM0_CTPSW as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_DESZOSE        :=  WSAdvValue( oResponse,"_M0_DESZOSE","string",NIL,"Property cM0_DESZOSE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::nM0_DOCSEQ         :=  WSAdvValue( oResponse,"_M0_DOCSEQ","integer",NIL,"Property nM0_DOCSEQ as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cM0_DSCCNA         :=  WSAdvValue( oResponse,"_M0_DSCCNA","string",NIL,"Property cM0_DSCCNA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::dM0_DTAUTOR        :=  WSAdvValue( oResponse,"_M0_DTAUTOR","date",NIL,"Property dM0_DTAUTOR as s:date on SOAP Response not found.",NIL,"D",NIL,NIL) 
	::cM0_DTBASE         :=  WSAdvValue( oResponse,"_M0_DTBASE","string",NIL,"Property cM0_DTBASE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::dM0_DTRE           :=  WSAdvValue( oResponse,"_M0_DTRE","date",NIL,"Property dM0_DTRE as s:date on SOAP Response not found.",NIL,"D",NIL,NIL) 
	::dM0_DTRNTRC        :=  WSAdvValue( oResponse,"_M0_DTRNTRC","date",NIL,"Property dM0_DTRNTRC as s:date on SOAP Response not found.",NIL,"D",NIL,NIL) 
	::dM0_DTVLD          :=  WSAdvValue( oResponse,"_M0_DTVLD","date",NIL,"Property dM0_DTVLD as s:date on SOAP Response not found.",NIL,"D",NIL,NIL) 
	::cM0_EMERGEN        :=  WSAdvValue( oResponse,"_M0_EMERGEN","string",NIL,"Property cM0_EMERGEN as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_EMPB2B         :=  WSAdvValue( oResponse,"_M0_EMPB2B","string",NIL,"Property cM0_EMPB2B as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_ENDCOB         :=  WSAdvValue( oResponse,"_M0_ENDCOB","string",NIL,"Property cM0_ENDCOB as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_ENDENT         :=  WSAdvValue( oResponse,"_M0_ENDENT","string",NIL,"Property cM0_ENDENT as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_EQUIP          :=  WSAdvValue( oResponse,"_M0_EQUIP","string",NIL,"Property cM0_EQUIP as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_ESTCOB         :=  WSAdvValue( oResponse,"_M0_ESTCOB","string",NIL,"Property cM0_ESTCOB as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_ESTENT         :=  WSAdvValue( oResponse,"_M0_ESTENT","string",NIL,"Property cM0_ESTENT as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_FAX            :=  WSAdvValue( oResponse,"_M0_FAX","string",NIL,"Property cM0_FAX as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_FAX_IMP        :=  WSAdvValue( oResponse,"_M0_FAX_IMP","string",NIL,"Property cM0_FAX_IMP as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_FAX_PO         :=  WSAdvValue( oResponse,"_M0_FAX_PO","string",NIL,"Property cM0_FAX_PO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_FILIAL         :=  WSAdvValue( oResponse,"_M0_FILIAL","string",NIL,"Property cM0_FILIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_FPAS           :=  WSAdvValue( oResponse,"_M0_FPAS","string",NIL,"Property cM0_FPAS as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_IMP_CON        :=  WSAdvValue( oResponse,"_M0_IMP_CON","string",NIL,"Property cM0_IMP_CON as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_INS_SUF        :=  WSAdvValue( oResponse,"_M0_INS_SUF","string",NIL,"Property cM0_INS_SUF as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_INSC           :=  WSAdvValue( oResponse,"_M0_INSC","string",NIL,"Property cM0_INSC as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_INSCANT        :=  WSAdvValue( oResponse,"_M0_INSCANT","string",NIL,"Property cM0_INSCANT as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_INSCM          :=  WSAdvValue( oResponse,"_M0_INSCM","string",NIL,"Property cM0_INSCM as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_INTCTRL        :=  WSAdvValue( oResponse,"_M0_INTCTRL","string",NIL,"Property cM0_INTCTRL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_LEIAUTE        :=  WSAdvValue( oResponse,"_M0_LEIAUTE","string",NIL,"Property cM0_LEIAUTE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_LIBMOD         :=  WSAdvValue( oResponse,"_M0_LIBMOD","string",NIL,"Property cM0_LIBMOD as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_LICENSA        :=  WSAdvValue( oResponse,"_M0_LICENSA","string",NIL,"Property cM0_LICENSA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_MODEND         :=  WSAdvValue( oResponse,"_M0_MODEND","string",NIL,"Property cM0_MODEND as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_MODINSC        :=  WSAdvValue( oResponse,"_M0_MODINSC","string",NIL,"Property cM0_MODINSC as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_NATJUR         :=  WSAdvValue( oResponse,"_M0_NATJUR","string",NIL,"Property cM0_NATJUR as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_NIRE           :=  WSAdvValue( oResponse,"_M0_NIRE","string",NIL,"Property cM0_NIRE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_NOME           :=  WSAdvValue( oResponse,"_M0_NOME","string",NIL,"Property cM0_NOME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_NOMECOM        :=  WSAdvValue( oResponse,"_M0_NOMECOM","string",NIL,"Property cM0_NOMECOM as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::nM0_NUMPROP        :=  WSAdvValue( oResponse,"_M0_NUMPROP","integer",NIL,"Property nM0_NUMPROP as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cM0_PICTURE        :=  WSAdvValue( oResponse,"_M0_PICTURE","string",NIL,"Property cM0_PICTURE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_PRODRUR        :=  WSAdvValue( oResponse,"_M0_PRODRUR","string",NIL,"Property cM0_PRODRUR as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_PSW            :=  WSAdvValue( oResponse,"_M0_PSW","string",NIL,"Property cM0_PSW as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_PSWSTRT        :=  WSAdvValue( oResponse,"_M0_PSWSTRT","string",NIL,"Property cM0_PSWSTRT as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_RNTRC          :=  WSAdvValue( oResponse,"_M0_RNTRC","string",NIL,"Property cM0_RNTRC as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_SEQUENC        :=  WSAdvValue( oResponse,"_M0_SEQUENC","string",NIL,"Property cM0_SEQUENC as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::nM0_SIZEFIL        :=  WSAdvValue( oResponse,"_M0_SIZEFIL","integer",NIL,"Property nM0_SIZEFIL as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cM0_STATUS         :=  WSAdvValue( oResponse,"_M0_STATUS","string",NIL,"Property cM0_STATUS as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_TEL            :=  WSAdvValue( oResponse,"_M0_TEL","string",NIL,"Property cM0_TEL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_TEL_IMP        :=  WSAdvValue( oResponse,"_M0_TEL_IMP","string",NIL,"Property cM0_TEL_IMP as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_TEL_PO         :=  WSAdvValue( oResponse,"_M0_TEL_PO","string",NIL,"Property cM0_TEL_PO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cM0_TPESTAB        :=  WSAdvValue( oResponse,"_M0_TPESTAB","string",NIL,"Property cM0_TPESTAB as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::nM0_TPINSC         :=  WSAdvValue( oResponse,"_M0_TPINSC","integer",NIL,"Property nM0_TPINSC as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cX_MENSAGEM        :=  WSAdvValue( oResponse,"_X_MENSAGEM","string",NIL,"Property cX_MENSAGEM as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return


