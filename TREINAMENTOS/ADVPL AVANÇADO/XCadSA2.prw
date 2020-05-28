#include "protheus.ch"

User Function XCadSA2()

Local cVldAlt := U_VldAlt(SA2->A2_NOME,nOpc) // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := U_VldExc(SA2->A2_NOME,nOpc) // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "SA2"

dbSelectArea("SA2")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de Fornecedor",cVldExc,cVldAlt)

Return Nil

 
User Function VldAlt(cNome,nOpc)

Local aArea 	:= GetArea()
Local lRet		:= ".F."

Static nOpc		:= 1

If nOpc == 4
	If Empty(cNom)
		MsgInfo("Não é possivel fazer a alteração, pois o nome está em branco!!!")
		lRet := ".F."
	Else
		MsgInfo("Favor efetuar alteração!!!")
		lRet := ".T."
	Endif
EndIf

RestArea(aArea)

Return lRet



User Function VldExc(cNom,nOpc)

Local aArea 	:= GetArea()
Local lRet		:= ".F."

Static nOpc		:= 1

If nOpc == 5
	If Empty(cNom)
		MsgInfo("Não é possivel fazer a exclusão, pois o nome está em branco!!!")
		lRet := ".F."
	Else
		MsgInfo("Favor efetuar exclusão!!!")
		lRet := ".T."
	Endif
EndIf

RestArea(aArea)

Return lRet