#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBEX.CH"
#INCLUDE "PWSR030.CH"

#DEFINE PAGE_LENGTH 10
/*************************************************************/


/*************************************************************/
/* Agenda do Candidato - Tela de Login			    		 */
/*************************************************************/
Web Function PWSR030()	//RHCurriculum -> GetSchedule
Local cHtml := ""
Local oObj   
Local oObjCfg                                            

Private	cTtlLogin	:= STR0003 //'Agenda do Candidato'
Private nCurrentPage
		   
	If Empty(HttpSession->GetCurriculum) .OR. Empty(HttpSession->GetCurriculum[1]:cCurriculum)
		WEB EXTENDED INIT cHtml
			oObjCfg := WSCFGDICTIONARY():New()
			WsChgUrl(@oObjCfg,"CFGDICTIONARY.apw")
			oObjCfg:GETPARAM( "MSALPHA", "MV_PAISLOC" )
			cPaisLoc:=oObjCfg:cGETPARAMRESULT
			
			oObj := WSRHCURRICULUM():New()
			WsChgURL(@oObj,"RHCURRICULUM.APW")     
			
			HttpSession->cCurricCpf 	:= HttpPost->cCurricCpf
			HttpSession->cCurricPass 	:= HttpPost->cCurricPass
			
			cHtml += ExecInPage( "PWSR030" )
		WEB EXTENDED END
	Else
		W_PWSR030A()	
	EndIf	

Return cHtml


Web Function PWSR030A()	//RHCurriculum -> GetSchedule
Local cHtml := ""
Local oObj
Local oObjCurr
Local lLoginOk	:= .F. 	

HttpSession->nPageLength	:= PAGE_LENGTH
HttpSession->FiltroVagas	:= ''
HttpSession->FiltroField	:= ''
HttpSession->aSchedule		:= {}

	WEB EXTENDED INIT cHtml
			
		oObjCurr := WSRHCURRICULUM():New()
		WsChgURL(@oObjCurr,"RHCURRICULUM.APW")
			
		If Empty(HttpSession->GetCurriculum) .OR. Empty(HttpSession->GetCurriculum[1]:cCurriculum) 
			If !Empty(HttpPost->cCurricCpf) 
		 
				HttpSession->cCurricCpf 	:= HttpPost->cCurricCpf
				HttpSession->cCurricPass := HttpPost->cCurricPass
				
				If oObjCurr:GetCurriculum( "MSALPHA", HttpSession->cCurricCpf, HttpSession->cCurricPass, 2 )
					HttpSession->GetCurriculum 	:= {oObjCurr:oWSGetCurriculumRESULT:oWSCURRIC1}
					HttpSession->GetTables 		:= {oObjCurr:oWSGetCurriculumRESULT:oWSCURRIC2}
					lLoginOk	:= .T.
				Else
					lLoginOk	:= .F.
					HttpSession->cCurricCpf		:= ''
					HttpSession->cCurricPass	:= ''
					HttpSession->GetCurriculum	:= {}
					HttpSession->ShowVacancy	:= {}
					HttpSession->oRequests 		:= {}
					
					Return RHALERT( "", STR0003, STR0008, "W_PWSR020A.APW" ) //"Agenda do candidato"###"Curric. invalido"
				EndIf		
			Else
				lLoginOk	:= .F.
				Return RHALERT( " ", STR0001, STR0009, "W_PWSR020A.APW" ) //"Portal Candidato"###"CPF deve ser informado."
			EndIf
		Else
			lLoginOk	:= .T.
		EndIf
			
			                      	
		If lLoginOk				
			oObj := WSRHCURRICULUM():New()
			WsChgURL(@oObj,"RHCURRICULUM.APW")
		    
			Default HttpSession->aSchedule := {}
			Default HttpGet->Page:= "1"	 	
		 	nCurrentPage:= Val(HttpGet->Page)
						
			oObj:cCurricCode 	:= Alltrim(HttpSession->GetCurriculum[1]:cCurriculum)
			oObj:nCurrentPage 	:= nCurrentPage
			
			If !Empty(HttpPost->cFilterValue)
				oObj:cFilterValue			:= HttpPost->cFilterValue
				oObj:cFilterField			:= HttpPost->cFilterField
				HttpSession->FiltroVagas	:= HttpPost->cFilterValue
				HttpSession->FiltroField	:= HttpPost->cFilterField 
			EndIf
			
			If oObj:GetSchedule()				
				HttpSession->aSchedule	:= oObj:oWsGetScheduleResult:oWsListOfRequest:oWsTSCheduleRequest				
				HttpSession->nPageTotal	:= oObj:oWsGetScheduleResult:nPagesTotal
				
				
				If !Empty(HttpPost->cCurrentPage)
					If Val(HttpPost->cCurrentPage) > 0 .AND. Val(HttpPost->cCurrentPage) <= HttpSession->nPageTotal 
						HttpSession->nCurrentPage	:= Val(HttpPost->cCurrentPage)
						HttpSession->CurrentPage	:= HttpSession->nCurrentPage
					Else
						HttpSession->nCurrentPage	:= HttpSession->CurrentPage
					EndIf
				Else
					HttpSession->nCurrentPage	:= 1	
				EndIf
				
			Else
				HttpSession->_HTMLERRO := { STR0025, PWSGetWSError(), "W_PWSR030.APW" }	//"Erro"
				Return ExecInPage("PWSAMSG" )
			EndIf				
	
			cHtml := ExecInPage( "PWSR030A" )
		Else
			conout( PWSGetWSError() )			
		EndIf
	WEB EXTENDED END			
Return cHtml

Web Function PWSR031()	//RHCurriculum -> GetActivity
Local cHtml := ""
Local oObj

HttpSession->aSchedule	:= {} 

	WEB EXTENDED INIT cHtml
		
		oObj := WSRHCURRICULUM():New()
		WsChgURL(@oObj,"RHCURRICULUM.APW")
		
		oObj:cCurricCode 	:= Alltrim(HttpSession->GetCurriculum[1]:cCurriculum)
		oObj:cVacancyCode 	:= Alltrim(HttpPost->cVacancyCode)
		
		If oObj:GetActivity()
			HttpSession->aSchedule	:= oObj:oWsGetActivityResult:oWsListOfRequest:oWsTSCheduleRequest
		Else
			HttpSession->_HTMLERRO := { STR0025, PWSGetWSError(), "W_PWSR030.APW" }	//"Erro"
			Return ExecInPage("PWSAMSG" )
		EndIf
				
		cHtml := ExecInPage( "PWSR031" )	
	WEB EXTENDED END			
Return cHtml