#include "protheus.ch"

User Function MBrw1SA1()
 
Private cCadastro := "Cadastro de Cliente"
Private aRotina := { {"Pesquisar"	,"AxPesqui",0,1} ,;
             		 {"Visualizar"	,"AxVisual",0,2} ,;
					 {"Incluir"		,"U_Inclui",0,3} ,;
             		 {"Alterar"		,"AxAltera",0,4} ,;
             		 {"Excluir"		,"U_Exclui",0,5} }

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

Private cString := "SA1"

dbSelectArea("SA1")
dbSetOrder(1)

dbSelectArea(cString)
mBrowse( 6,1,22,75,cString)

Return Nil



User Function Inclui(cAlias, nReg, nOpc)

Local cTudoOk := "( Alert('OK'),.T.)"
Local nOpcao	 := 0

nOpcao := AxInclui(cAlias,nReg,nOpc,,,,cTudoOk)

If nOpcao == 1
	MsgInfo("Inclus�o conclu�da com sucesso!")
ElseIf nOpcao	 == 2
	MsgInfo("Inclus�o cancelada!")
Endif

Return Nil



User Function Exclui(cAlias, nReg, nOpc)

Local cTudoOk := "(Alert('OK'),.T.)"
Local nOpcao	 := 0

nOpcao := AxDeleta(cAlias,nReg,aRotina[nOpc,4]) 
// Identifica corretamente a op��o definida para o fun��o em aRotinas com mais do que os 5 elementos padr�es.

If nOpcao == 1
	MsgInfo("Exclus�o realizada com sucesso!")
ElseIf nOpcao == 2
	MsgInfo("Exclus�o cancelada!")
Endif

Return Nil