#Include "Protheus.ch"
#Include "Rwmake.ch"
  
User Function GRptStatus()

Local aSay    := {}
Local aButton := {}
Local nOpc    := 0
Local cTitulo := "Exemplo de Funções"
Local cDesc1  := "Este programa exemplifica a utilização da função Processa() em conjunto"
Local cDesc2  := "com as funções de incremento ProcRegua() e IncProc()"
Private cPerg := "RPTSTA"

CriaPerg()
Pergunte(cPerg,.T.)

AADD( aSay, cDesc1 )
AADD( aSay, cDesc2 )

AADD( aButton, { 5, .T., {|| Pergunte(cPerg,.T. )    }} )
AADD( aButton, { 1, .T., {|| nOpc := 1, FechaBatch() }} )
AADD( aButton, { 2, .T., {|| FechaBatch()            }} )

FormBatch( cTitulo, aSay, aButton )

If nOpc <> 1
   Return Nil
Endif

RptStatus({|lEnd|RunProc(@lEnd)}, "Aguarde...","Executando rotina.", .T. )

Return Nil

Static Function CriaPerg()

Local _sAlias 	:= Alias()
Local aArea   	:= GetArea()
Local aRegs   	:= {}
Local nI		:= 0
Local nJ		:= 0
Local nCampo	:= 0
Local nX		:= 0

dbSelectArea("SX1")
dbSetOrder(1)

cPerg := PADR(cPerg,10) 

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aCampos := {"GRUPO","ORDEM","PERGUNT","VARIAVL","TIPO","TAMANHO","DECIMAL","PRESEL","GSC","VALID","VAR01","DEF01","CNT01","VAR01","DEF01","CNT01","VAR02","DEF02","CNT02","VAR03","DEF03","CNT03","VAR04","DEF04","CNT04","VAR05","DEF05","CNT05","F3"}

aAdd(aRegs,{cPerg,"01","Tabela de			","","","mv_ch1" ,"C",TamSX3("X5_TABELA")[1]	,0,0,"G",""	,"MV_PAR01","","","","","","","","","","","","","","","SX5"})
aAdd(aRegs,{cPerg,"02","Tabela ate		  	","","","mv_ch2" ,"C",TamSX3("X5_TABELA")[1]	,0,0,"G",""	,"MV_PAR02","","","","","","","","","","","","","","","SX5"})

dbSelectArea("SX1")
dbSetOrder(1)
For nX:=1 to Len(aRegs)
	If	DbSeek( cPerg + aRegs[nx][02] )   
    	If	RecLock('SX1',.F.)
			Replace SX1->X1_GRUPO  		With aRegs[nx][01]
			Replace SX1->X1_ORDEM   	With aRegs[nx][02]
			Replace SX1->X1_PERGUNTE	With aRegs[nx][03]
			Replace SX1->X1_PERSPA		With aRegs[nx][04]
			Replace SX1->X1_PERENG		With aRegs[nx][05]
			Replace SX1->X1_VARIAVL		With aRegs[nx][06]
			Replace SX1->X1_TIPO		With aRegs[nx][07]
			Replace SX1->X1_TAMANHO		With aRegs[nx][08]
			Replace SX1->X1_DECIMAL		With aRegs[nx][09]
			Replace SX1->X1_PRESEL		With aRegs[nx][10]
			Replace SX1->X1_GSC		  	With aRegs[nx][11]
			Replace SX1->X1_VALID		With aRegs[nx][12]
			Replace SX1->X1_VAR01		With aRegs[nx][13]
			Replace SX1->X1_DEF01	  	With aRegs[nx][14]
			Replace SX1->X1_DEF02		With aRegs[nx][17]
			Replace SX1->X1_DEF03		With aRegs[nx][20]
			Replace SX1->X1_DEF04		With aRegs[nx][23]
			Replace SX1->X1_DEF05		With aRegs[nx][26]
			Replace SX1->X1_F3   		With aRegs[nx][28]
			SX1->(MsUnlock())
		Else
			Help('',1,'REGNOIS')
		EndIf	
	Else
		If	RecLock('SX1',.T.)
			Replace SX1->X1_GRUPO  		With aRegs[nx][01]
			Replace SX1->X1_ORDEM   	With aRegs[nx][02]
			Replace SX1->X1_PERGUNTE	With aRegs[nx][03]
			Replace SX1->X1_PERSPA		With aRegs[nx][04]
			Replace SX1->X1_PERENG		With aRegs[nx][05]
			Replace SX1->X1_VARIAVL		With aRegs[nx][06]
			Replace SX1->X1_TIPO		With aRegs[nx][07]
			Replace SX1->X1_TAMANHO		With aRegs[nx][08]
			Replace SX1->X1_DECIMAL		With aRegs[nx][09]
			Replace SX1->X1_PRESEL		With aRegs[nx][10]
			Replace SX1->X1_GSC		  	With aRegs[nx][11]
			Replace SX1->X1_VALID		With aRegs[nx][12]
			Replace SX1->X1_VAR01		With aRegs[nx][13]
			Replace SX1->X1_DEF01	  	With aRegs[nx][14]
			Replace SX1->X1_DEF02		With aRegs[nx][17]
			Replace SX1->X1_DEF03		With aRegs[nx][20]
			Replace SX1->X1_DEF04		With aRegs[nx][23]
			Replace SX1->X1_DEF05		With aRegs[nx][26]
			Replace SX1->X1_F3   		With aRegs[nx][28]
			SX1->(MsUnlock())
		Else
			Help('',1,'REGNOIS')
		EndIf	
	Endif
Next nX


dbSelectArea(_sAlias)

RestArea(aArea)

Return NIL

Static Function RunProc(lEnd)

Local nCnt := 0

dbSelectArea("SX5")
dbSetOrder(1)
dbSeek(xFilial("SX5")+MV_PAR01,.T.)

While !Eof() .And. X5_FILIAL == xFilial("SX5") .And. X5_TABELA <= MV_PAR02
   nCnt++
   dbSkip()
EndDo

dbSeek(xFilial("SX5")+mv_par01,.T.)

SetRegua(nCnt)

While !(Eof()) .And. X5_FILIAL == xFilial("SX5") .And. X5_TABELA <= MV_PAR02
   IncRegua()
   If lEnd
      MsgInfo(cCancel,"Fim")
      Exit
   EndIf
   dbSkip()
EndDo

Return .T.