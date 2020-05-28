#include "Protheus.ch"

User Function MrbwGetD()

Private cCadastro	:= "Pedidos de Venda"
Private aRotina	:=	{{"Pesquisar"	, "axPesqui"	, 0, 1},;
					{"Visualizar"	, "U_ModGtd"	, 0, 2},;
					{"Incluir"		, "U_ModGtd"	, 0, 3}}

DbSelectArea("SC5")
DbSetOrder(1)

MBrowse(6,1,22,75,"SC5")

Return 


User Function ModGtd(cAlias,nReg,nOpc)

Local nX 	 		:= 0
Local nUsado 		:= 0
Local aButtons		:= {} 
Local aCpoEnch 		:= {}
Local cAliasE 		:= cAlias
Local aAlterEnch	:= {}
Local aPos			:= {000,000,080,400}
Local nModelo		:= 3 
Local lF3 			:= .F. 
Local lMemoria		:= .T.
Local lColumn		:= .F.                         
Local caTela 		:= "" 
Local lNoFolder		:= .F.                            
Local lProperty		:= .F.
Local aCpoGDa       := {}
Local cAliasGD		:= "SC6"
Local nSuperior    	:= 081	
Local nEsquerda    	:= 000
Local nInferior    	:= 250
Local nDireita     	:= 400
Local cLinOk       	:= "AllwaysTrue" 
Local cTudoOk      	:= "AllwaysTrue" 
Local cIniCpos     	:= "C6_ITEM" 
Local nFreeze      	:= 000 
Local nMax         	:= 999
Local cFieldOk     	:= "AllwaysTrue" 
Local cSuperDel     := ""
Local cDelOk        := "AllwaysFalse" 
Local aHeader       := {}
Local aCols         := {}                      
Local aAlterGDa		:= {}

Private oDlg
Private oGetD      
Private oEnch
Private aTELA[0][0]
Private aGETS[0]

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek(cAliasE)

While !Eof() .And. SX3->X3_ARQUIVO == cAliasE
  If !(SX3->X3_CAMPO $ "C5_FILIAL") .And. cNivel >= SX3->X3_NIVEL .And.;
     X3Uso(SX3->X3_USADO)
	AADD(aCpoEnch,SX3->X3_CAMPO)
	EndIf		 
	DbSkip()
EndDo

aAlterEnch := aClone(aCpoEnch)

DbSelectArea("SX3")
DbSetOrder(1)
MsSeek(cAliasGD)

While !Eof() .And. SX3->X3_ARQUIVO == cAliasGD
	If ! (AllTrim(SX3->X3_CAMPO) $ "C6_FILIAL") .And.;
      cNivel >= SX3->X3_NIVEL .And. X3Uso(SX3->X3_USADO)		
		AADD(aCpoGDa,SX3->X3_CAMPO)
	EndIf		 
	DbSkip()
EndDo

aAlterGDa := aClone(aCpoGDa)

nUsado:=0
dbSelectArea("SX3")
dbSeek("SC6")
aHeader:={}
While !Eof().And.(x3_arquivo=="SC6")
	If X3USO(x3_usado).And.cNivel>=x3_nivel
    	nUsado:=nUsado+1
		aAdd(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,x3_tamanho,;
		x3_decimal,"AllwaysTrue()",x3_usado, x3_tipo, x3_arquivo, x3_context } )
	EndIf
    dbSkip()
EndDo

If nOpc==3 // Incluir
	aCols:={Array(nUsado+1)}
	aCols[1,nUsado+1]:=.F.
	For nX:=1 to nUsado
		If aHeader[nX,2] == "C6_ITEM"
			aCols[1,nX]:= "0001"
		Else
			aCols[1,nX]:=CriaVar(aHeader[nX,2])
		EndIf
	Next
Else
	aCols:={}
	dbSelectArea("SC6")
	dbSetOrder(1)
	dbSeek(xFilial()+M->C5_NUM)
	While !eof().and.C6_NUM==M->C5_NUM
		aAdd(aCols,Array(nUsado+1))
		For nX:=1 to nUsado
			aCols[Len(aCols),nX]:=FieldGet(FieldPos(aHeader[nX,2]))
		Next 
		aCols[Len(aCols),nUsado+1]:=.F.
		dbSkip()
	EndDo
EndIf

oDlg 	:= MSDIALOG():New(000,000,400,600, cCadastro,,,,,,,,,.T.)
	RegToMemory("SC5", If(nOpc==3,.T.,.F.))
	
oEnch := MsMGet():New(cAliasE,nReg,nOpc,/*aCRA*/,/*cLetra*/,/*cTexto*/,;
 		    aCpoEnch,aPos,aAlterEnch, nModelo, /*nColMens*/, /*cMensagem*/,;
          /*cTudoOk*/, oDlg,lF3, lMemoria,lColumn,caTela,lNoFolder,;
          lProperty)
				
	oGetD:= MsNewGetDados():New(nSuperior, nEsquerda, nInferior, nDireita,;
        nOpc,cLinOk,cTudoOk, cIniCpos, aAlterGDa, nFreeze, nMax,cFieldOk,;
        cSuperDel,cDelOk, oDLG, aHeader, aCols)
				
oDlg:bInit := {|| EnchoiceBar(oDlg, {||oDlg:End()},{||oDlg:End()},,aButtons)}
oDlg:lCentered := .T.
oDlg:Activate()

Return