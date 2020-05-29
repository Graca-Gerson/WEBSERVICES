#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBEX.CH"
#INCLUDE "PWSA230.CH"

Web Function PWSA230()
	Local cHtml   	:= ""
	
	HttpSession->cTypeRequest 	:= "I"		//GAPS de Fatores
	HttpGet->titulo				:= STR0002	//"Meus GAPS"
	HttpGet->objetivo			:= STR0003	//"Verificar as diferen�as entre as pontua��es dos fatores de avalia��o associadas ao funcion�rio e as pontua��es dos fatores de avalia��o associadas ao cargo."
	HttpSession->aStructure 	:= {} 
	HttpSession->cHierarquia 	:= ""
	  
	HttpCTType("text/html; charset=ISO-8859-1")	
	
	WEB EXTENDED INIT cHtml START "InSite"
		fGetInfRotina("W_PWSA230.APW")
		GetMat()
			    
		cHtml := ExecInPage("PWSA260A")	
	WEB EXTENDED END
Return cHtml


Web Function PWSA231()
	Local cHtml:= ""
	Local oWSEvaluationFactors
	Private aFields
	Private aEvaluationFactors
	HttpCTType("text/html; charset=ISO-8859-1")
	WEB EXTENDED INIT cHtml START "InSite"
		HttpSession->DadosFunc := HttpSession->aStructure[val(HttpGet->nIndice)]			
		
		oWSEvaluationFactors := WSRHEVALUATIONFACTORS():New()
		WsChgURL(@oWSEvaluationFactors, "RHEVALUATIONFACTORS.APW")
				
		oWSEvaluationFactors:cBranch 		:= HttpSession->DadosFunc:cEmployeeFilial
		oWSEvaluationFactors:cRegistration 	:= HttpSession->DadosFunc:cRegistration

	
		If oWSEvaluationFactors:GetEvaluationFactorsGAP()
			oEmployee	:= oWSEvaluationFactors:oWSGetEvaluationFactorsGAPResult:oWSEmployee
			aGAPS		:= oWSEvaluationFactors:oWSGetEvaluationFactorsGAPResult:oWSGAPS:oWSTEvaluationFactorsGAP
		Else
			HttpSession->_HTMLERRO := { "Erro", PWSGetWSError(), "W_PWSA230.APW" }
			Return ExecInPage("PWSAMSG" )
		EndIf
			
		cHtml += ExecInPage("PWSA231")
	WEB EXTENDED END	
Return cHtml