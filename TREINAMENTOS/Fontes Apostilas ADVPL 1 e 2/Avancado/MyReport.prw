#include "protheus.ch"

User Function MyReport()
Local oReport

If TRepInUse()	//verifica se a op��o relat�rios personaliz�veis est� dispon�vel
	Pergunte("MTR025",.T.)//Fun��o apenas para mostrar a chamada de parametros

	oReport := ReportDef()
	oReport:PrintDialog()	
EndIf
Return