#include "protheus.ch"

User Function MBrwSA1()

Private cCadastro := "Cadastro de Cliente"
Private aRotina := { {"Pesquisar"	,"AxPesqui",0,1} ,;
             		 {"Visualizar"	,"AxVisual",0,2} ,;
					 {"Incluir"		,"AxInclui",0,3} ,;
             		 {"Alterar"		,"AxAltera",0,4} ,;
             		 {"Excluir"		,"AxDeleta",0,5} }

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
 
Private cString := "SA1"

dbSelectArea("SA1")
dbSetOrder(1)

dbSelectArea(cString)
mBrowse( 6,1,22,75,cString)

Return Nil