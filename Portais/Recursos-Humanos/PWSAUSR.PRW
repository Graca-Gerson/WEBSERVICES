#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBEX.CH"  

#DEFINE cCodUser "MSALPHA"

/*******************************************************************
* Funcao: PWSA088 - Consulta Certificacoes profissionais - HCM
* Autor:	Juliana Barros
* Data:		23/08/2005
********************************************************************/
Web Function PWSA088()

Local cHtml 	:= "" 
Local oParam	:= ""
Local oPart		:= ""
Local oObj		:= ""
Local cCodigo 	:= ""
Local cTitulo 	:= ""
Local cCodVis	:= ""

WEB EXTENDED INIT cHtml START "InSite"
                                       
oParam	:= WSCFGDICTIONARY():NEW()
oPart	:= WSRHEMPLOYEDCURRICULUM():New()
oObj 	:= WSRHUsuario():New()

WsChgURL(@oObj,"RHUsuario.APW")
WsChgURL(@oParam,"CFGDICTIONARY.APW") 
WsChgURL(@oPart,"RHEMPLOYEDCURRICULUM.APW")                           

If !empty( HttpPost->cCodigo )
	cCodigo := HttpPost->cCodigo
	cTitulo := HttpPost->cTitulo
Else
	cCodigo := HttpGet->cCodigo
	cTitulo := HttpGet->cTitulo
EndIf                                        

	If oParam:GETPARAM( cCodUser, "MV_APDVIS" )
		cCodVis := oParam:cGETPARAMRESULT
	EndIf
	    
	//PEGA DADOS DO PARTICIPANTE QUE ESTA ENTRANDO AGORA
	If !Empty(HttpPost->ParticipantID)
		HttpSession->cPartAcesso := {"",""}
		HttpSession->cPartAcesso[1] := HttpPost->ParticipantID
		HttpSession->cPartAcesso[2] := HttpPost->tpAvaliador		
	EndIf
	
	If oPart:GETPARTICIPANT( cCodUser, HttpSession->cPartAcesso[1], cCodVis )
	    HttpSession->aUsuario := {oPart:oWSGETPARTICIPANTRESULT:CREGISTRATION,oPart:oWSGETPARTICIPANTRESULT:CNAME, oPart:oWSGETPARTICIPANTRESULT:CFILIAL, oPart:oWSGETPARTICIPANTRESULT:CEVALUATORNAME, oPart:oWSGETPARTICIPANTRESULT:DLASTUPDATE, oPart:oWSGETPARTICIPANTRESULT:CCODMENTOR, oPart:oWSGETPARTICIPANTRESULT:CMENTORNAME}
		
	Else
		HttpSession->_HTMLERRO := { "Erro:", PWSGetWSError(), "W_PWSA00C.APW" }
 		Return ExecInPage("PWSAMSG")	
	EndIf
		

	If oObj:BrwHCM( cCodUser, HttpSession->cPartAcesso[1] )
		HttpPost->aHCM := oObj:oWSBRWHCMRESULT:oWSHCMLIST

		HttpPost->cTitulo := cTitulo
		HttpPost->cCodigo := cCodigo
		cHtml += ExecInPage( "PWSA075" )
	Else
		HttpSession->_HTMLERRO := { "Erro:", PWSGetWSError(), "W_PWSA076.APW" }
 		Return ExecInPage("PWSAMSG")
	EndIf

WEB EXTENDED END

Return cHtml

