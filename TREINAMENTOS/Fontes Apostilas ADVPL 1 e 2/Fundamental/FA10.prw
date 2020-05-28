#Include "Protheus.ch"


User Function FA10(nTamanho, cTitulo, cSay) 

Local cTexto   	:= ""
Local nColF    	:= 0
Local nLargGet 	:= 0

Private oDlg	

Default cTitulo := "Tela para informar texto"
Default cSay    := "Informe o texto:"
Default nTamanho:= 1

IF ValType(nTamanho) != "N"  // Se o parâmetro foi passado errado
	nTamanho 	:= 1
ENDIF

cTexto   := Space(nTamanho)
nLargGet := Round(nTamanho * 2.5,0)
nColf    := Round(195 + (nLargGet * 1.75) ,0)

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 120,nColF PIXEL

@ 005,005 TO 060, Round(nColF/2,0) OF oDlg PIXEL
@ 010,010 SAY cSay SIZE 55, 7 OF oDlg PIXEL
@ 010,065 MSGET cTexto SIZE nLargGet, 11 OF oDlg PIXEL ;
          Picture "@!" VALID !Empty(cTexto)

DEFINE SBUTTON FROM 030, 010 TYPE 1 ;
                    ACTION (nOpca := 1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 030, 040 TYPE 2 ;
                    ACTION (nOpca := 0,oDlg:End()) ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTERED

cTexto := Iif(nOpca==1,cTexto,"")

If !Empty(cTexto)
	MsgAlert(cTexto)
EndIf

Return cTexto