#Include "Protheus.ch"

User Function TD1()

Local cTexto 	:= "Informe o CNPJ:"
Local cTitulo	:= "Busca por Fornecedor"
Local cCGC		:= Space(TamSx3("A1_CGC")[1])

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 080,300 PIXEL
 
	@ 001,001 TO 040, 150 OF oDlg PIXEL
	@ 010,010 SAY   cTexto SIZE 55, 07 OF oDlg PIXEL

	@ 010,060 MSGET cCGC   SIZE 55, 11 OF oDlg PIXEL ;
           PICTURE "@R 99.999.999/9999-99"
           
DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpca := 1,oDlg:End());
  ENABLE OF oDlg
DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpca := 2,oDlg:End());
  ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTERED

If nOpca == 1
	If Empty(AllTrim(cCGC))
		Alert("Favor Preencher com o CNPJ!!!")
	Else		
		MsgAlert("Processando CNPJ:" + AllTrim(cCGC))
	EndIf
EndIf

Return