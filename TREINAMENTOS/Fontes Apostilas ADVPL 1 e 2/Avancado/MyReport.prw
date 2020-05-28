#include "protheus.ch"

User Function MyReport()
Local oReport

If TRepInUse()	//verifica se a opção relatórios personalizáveis está disponível
	Pergunte("MTR025",.T.)//Função apenas para mostrar a chamada de parametros

	oReport := ReportDef()
	oReport:PrintDialog()	
EndIf
Return