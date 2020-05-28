#Include 'Protheus.ch'
#INCLUDE "FWMVCDEF.CH"

User Function CNTA300()
 
Local lRet := .T.
Local aParam  := PARAMIXB
Local oModel  := ''
Local oStruct := ''
Local cIdPonto   := ''
Local cIdModel   := ''

If aParam <> NIL
	oModel     := aParam[1] // Retorno do Model
	cIdPonto   := aParam[2] // Nome do id de execução do ponto de entrada
	cIdModel   := aParam[3] // Id do Modelo que esta sendo executado

	If cIdPonto == "FORMPRE" // Verifica se pode ativação do modelo
		MsgInfo("Ponto de Entrada no Inico do Contrato!!!")
		Return .T.
	EndIf
EndIf
 
Return .T.
