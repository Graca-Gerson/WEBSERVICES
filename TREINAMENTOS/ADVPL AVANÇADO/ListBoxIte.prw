#Include "Protheus.ch"

User Function ListBoxIte()
 
Local aVetor   := {}
Local oDlg     := Nil
Local oLbx     := Nil
Local cTitulo  := "Consulta Tabela"
Local nChave   := 0
Local cChave   := ""

dbSelectArea("SX5")
dbSetOrder(1)
dbSeek(xFilial("SX5"))

CursorWait()

//+-----------------------------------------+
//| Carrega o vetor conforme a condição |
//+-----------------------------------------+

While !Eof() .And. X5_FILIAL == xFilial("SX5") .And. X5_TABELA=="00"
   AADD( aVetor, Trim(X5_CHAVE)+" - "+Capital(Trim(X5_DESCRI)) )
 dbSkip()
EndDo

CursorArrow()

If Len( aVetor ) == 0
   Aviso( cTitulo, "Não existe dados a consultar", {"Ok"} )
   Return
Endif

//+-----------------------------------------------+
//| Monta a tela para usuário visualizar consulta |
//+-----------------------------------------------+
DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL

@ 10,10 LISTBOX oLbx VAR nChave ITEMS aVetor SIZE 230,95 OF oDlg PIXEL

oLbx:bChange := {|| cChave := SubStr(aVetor[nChave],1,2) }

DEFINE SBUTTON FROM 107,183 TYPE 14 ACTION LoadTable(cChave) ;
 ENABLE OF oDlg
DEFINE SBUTTON FROM 107,213 TYPE  1 ACTION oDlg:End() ;
 ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTER

Return

Static Function LoadTable(cTabela)

Local aTabela 	:= {}
Local oDlg 		:= NIL
Local oLbx 		:= NIL

dbSelectArea("SX5")
dbSeek(xFilial("SX5")+cTabela)

dbEval({||AADD(aTabela,{X5_CHAVE,Capital(X5_DESCRI)})},,{|| X5_TABELA==cTabela})

If Len(aTabela)==0
   Aviso( "FIM", "Necessário selecionar um item", {"Ok"} )
   Return
Endif

DEFINE MSDIALOG oDlg TITLE "Dados da tabela selecionada" FROM 300,400 TO 540,900 PIXEL
@ 10,10 LISTBOX oLbx FIELDS HEADER "Tabela", "Descrição" SIZE 230,095 OF oDlg PIXEL	
oLbx:SetArray( aTabela )
oLbx:bLine := {|| {aTabela[oLbx:nAt,1],aTabela[oLbx:nAt,2]} }
DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg

Return