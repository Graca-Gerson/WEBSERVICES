#Include 'Protheus.ch'

// #########################################################################################
// Projeto: Curso Totvs Developer Studio
// Modulo : Treinamento Presencial
// Fonte  : 20_Debug.prw
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor  CT-TOTVS   | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 25/09/12 |								 Debug/Depuração de Códigos
// ---------+-------------------+-----------------------------------------------------------

User Function 20_Debug()
Local   nNum1 := 10
Local   nNum2 := 3

Local   cMsg  := "1. Ponto de Parada"
Static  cMsg1 := "2. Ponto de Parada"
Private cMsg2 := "3. Ponto de Parada"
Private aDias := {"Debug no TDS",date(),"Curso Totvs Developer Studio"}
Public  cNome:="teste"

// Teste do primeiro ponto de parada
If(nNum1 > 5).And. (nNum2 <> 3)
	MsgAlert(cMsg)
ElseIf (nNum1 > 5).And. (nNum2 == 3)
	MsgAlert(cMsg)
Else
	MsgAlert(cMsg)
EndIf

// Teste do Segundo ponto de parada
Do Case
		Case (nNum1== 11)
			MsgAlert(cMsg1)
		Case (nNum1== 10) .And. (nNum2 == 3)
			MsgAlert(cMsg1)
		Case (nNum1== 5)
			MsgAlert(cMsg1)	
EndCase

// Teste do Terceiro ponto de parada
For nNum=1 To 5
	MsgAlert("O valor da Variavel nNum é: " + cValToChar(nNum))
	If nNum == 4
		MsgAlert("Lendo o Vetor: " + "Hoje é dia: "+dtoc(aDias[2]) )
		MsgAlert("O comando vai encerrar... " + aDias[3])
		Exit
	EndIf
Next
		

Return


