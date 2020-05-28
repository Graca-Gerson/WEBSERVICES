#include "protheus.ch"

User Function MFBrwSA2()

Local cAlias      := "SA2"
Private cCadastro := "Cadastro de Fornecedores"

Private aRotina   := {}                

AADD(aRotina,{"Pesquisar"  ,"AxPesqui" ,0,1})
AADD(aRotina,{"Visualizar" ,"AxVisual" ,0,2})
AADD(aRotina,{"Incluir"    ,"U_BInclui",0,3})
AADD(aRotina,{"Alterar"	  ,"AxAltera" ,0,4})
AADD(aRotina,{"Excluir"	  ,"AxDeleta" ,0,5})

dbSelectArea(cAlias)
dbSetOrder(1)

mBrowse(6,1,22,75,cAlias)

Return( NIL )


User Function BInclui(cAlias, nReg, nOpc)

Local cTudoOk := "(Alert('OK'),.T.)"

AxInclui(cAlias,nReg,nOpc,,,,cTudoOk)

Return()
