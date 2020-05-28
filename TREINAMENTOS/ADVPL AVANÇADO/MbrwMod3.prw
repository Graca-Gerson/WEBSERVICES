#INCLUDE "protheus.ch"

User Function MbrwMod3()

Private cCadastro 	:= "Pedidos de Venda"
Private aRotina 	:= {}
Private cDelFunc 	:= ".T." // Validacao para a exclusao. Pode-//se utilizar ExecBlock
Private cAlias 		:= "SC5"
 
AADD(aRotina,{ "Pesquisa","AxPesqui"	,0,1})
AADD(aRotina,{ "Visual"  ,"U_Mod3All"	,0,2})
AADD(aRotina,{ "Inclui"	 ,"U_Mod3All"	,0,3})
AADD(aRotina,{ "Altera"	 ,"U_Mod3All"	,0,4})
AADD(aRotina,{ "Exclui"	 ,"U_Mod3All"	,0,5})

dbSelectArea(cAlias)
dbSetOrder(1)
mBrowse( 6,1,22,75,cAlias)

Return

User Function Mod3All(cAlias,nReg,nOpcx)

Local cTitulo := "Cadastro de Pedidos de Venda"
Local cAliasE := "SC5"
Local cAliasG := "SC6"
Local cLinOk  := "AllwaysTrue()"
Local cTudOk  := "AllwaysTrue()"
Local cFieldOk:= "AllwaysTrue()"
Local aCposE  := {}
Local nUsado, nX  := 0
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Opcoes de acesso para a Modelo 3                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Do Case
	Case nOpcx==3; nOpcE:=3 ; nOpcG:=3    // 3 - "INCLUIR"
	Case nOpcx==4; nOpcE:=3 ; nOpcG:=3    // 4 - "ALTERAR"
	Case nOpcx==2; nOpcE:=2 ; nOpcG:=2    // 2 - "VISUALIZAR"
	Case nOpcx==5; nOpcE:=2 ; nOpcG:=2	  // 5 - "EXCLUIR"
EndCase

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Cria variaveis M->????? da Enchoice                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
RegToMemory("SC5",(nOpcx==3 .or. nOpcx==4 )) // Se for inclusao ou alteracao permite alterar o conteudo das variaveis de memoria

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Cria aHeader e aCols da GetDados                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nUsado:=0
dbSelectArea("SX3")

dbSeek("SC6")
aHeader:={}
While !Eof() .And. X3_ARQUIVO == "SC6"
	If X3Uso(X3_USADO) .And. cNivel >= X3_NIVEL
		aAdd(aHeader, { Trim(X3Titulo()),;
		X3_CAMPO,;
		X3_PICTURE,;
		X3_TAMANHO,;
		X3_DECIMAL,;
		X3_VALID,;
		X3_USADO,;
		X3_TIPO,;
		X3_ARQUIVO,;
		X3_CONTEXT })
	EndIf
	DbSkip()
EndDo

If nOpcx==3 // Incluir
	aCols:={Array(nUsado+1)}
	aCols[1,nUsado+1]:=.F.
	For nX:=1 to nUsado
		aCols[1,nX]:=CriaVar(aHeader[nX,2])
	Next
Else
	aCols:={}
	dbSelectArea("SC6")
	dbSetOrder(1)
	dbSeek(xFilial()+M->C5_NUM)
	While !eof().and.C6_NUM==M->C5_NUM
		AADD(aCols,Array(nUsado+1))
		For nX:=1 to nUsado
			aCols[Len(aCols),nX]:=FieldGet(FieldPos(aHeader[nX,2]))
		Next 
		aCols[Len(aCols),nUsado+1]:=.F.
		dbSkip()
	End
Endif

If Len(aCols)>0
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Executa a Modelo 3                                           
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aCposE := {"C5_CLIENTE"}

lRetMod3 := Modelo3(cTitulo, cAliasE, cAliasG, aCposE, cLinOk,;
 cTudOk,nOpcE, nOpcG,cFieldOk)
	
If lRetMod3
		Aviso("Modelo3()","Confirmada operacao!",{"Ok"})
	Endif
EndIf

Return