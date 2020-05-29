#INCLUDE "APWEBEX.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "PWSANONI.CH"
#INCLUDE "FILEIO.CH"

Web Function PWSANONI()

Local cHtml := ""
Local oObj

WEB EXTENDED INIT cHtml

	oObj := WSRHCURRICULUM():New()
	WsChgURL(@oObj,"RHCURRICULUM.APW")

	If !Empty(HttpPost->cCurricCpf)
		HttpSession->cCurricCpf 	:= HttpPost->cCurricCpf
		HttpSession->cCurricPass 	:= HttpPost->cCurricPass
	EndIf

	If !Empty( HttpSession->cCurricCpf )
		If oObj:GetCurriculum( "MSALPHA", HttpSession->cCurricCpf, HttpSession->cCurricPass, 2 )

			HttpSession->GetCurriculum 	:= {oObj:oWSGetCurriculumRESULT:oWSCURRIC1}
			HttpSession->GETTABLES 		:= {oObj:oWSGetCurriculumRESULT:oWSCURRIC2}

			if empty(HttpPost->cNome) .and. empty(HttpPost->cEmail) .and. empty(HttpPost->cObsAnoni)
				cHtml += ExecInPage( "PWSANONI" ) // pagina de solicitacao
			else
				//Web Service
				oObj := WSANONIMIZA():New()
				WsChgURL( @oObj, "ANONIMIZA.APW" )

				//Parametros
				oObj:cNome			:= HttpPost->cNome
				oObj:cEmail			:= HttpPost->cEmail
				oObj:cObservacao	:= HttpPost->cObsAnoni
				oObj:cCPF			:= HttpSession->cCurricCpf

				HttpSession->cTitulo := STR0001
				HttpSession->cMensagem := ""

				if oObj:PutSolic()
					HttpSession->cMensagem := STR0016
				else
					HttpSession->cMensagem := STR0017
				endif

				cHtml += ExecInPage( "ANONIMSG" )

			endif
		Else
			HttpSession->cCurricCpf := ""
			cHtml += ExecInPage( "PWSLOGIN" )
		EndIf
	Else
		HttpSession->cCurricCpf := ""
		cHtml += ExecInPage( "PWSLOGIN" )
	EndIf

WEB EXTENDED END

Return cHtml



Web Function PWSLOGIN()
	Local cHtml := ""
	Local oObj
	Local oObjCfg
	Public	cPaisLoc

	WEB EXTENDED INIT cHtml

		If Empty(HttpSession->GetCurriculum)
			oObjCfg := WSCFGDICTIONARY():New()
			WsChgUrl(@oObjCfg,"CFGDICTIONARY.apw")
			oObjCfg:GETPARAM( "MSALPHA", "MV_PAISLOC" )
			cPaisLoc:=oObjCfg:cGETPARAMRESULT

			oObj := WSRHCURRICULUM():New()
			WsChgURL(@oObj,"RHCURRICULUM.APW")

			cHtml += ExecInPage( "PWSLOGIN" )
		Else
			W_PWSANONI()
		EndIf
	WEB EXTENDED END
Return cHtml