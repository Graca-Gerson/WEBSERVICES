#include "protheus.ch"

User Function List_Box()

Local aVetor 		:= {}
Local oDlg
Local oLbx
Local cTitulo 		:= "Cadastro de Bancos"
Local cFilSA6
Local aCabecalho 	:= {" ","Banco", "Agencia", "C/C", "Nome Banco", "Fantasia", "Bairro", "Município"}

dbSelectArea("SA6")
dbSetOrder(1)
cFilSA6 := xFilial("SA6")
dbSeek(cFilSA6)

// Carrega o vetor conforme a condição.
While !Eof() .And. A6_FILIAL == cFilSA6
  AADD( aVetor, ;
  {A6_COD,A6_AGENCIA,A6_NUMCON,A6_NOME,A6_NREDUZ,A6_BAIRRO,A6_MUN})
  dbSkip()
EndDo

// Se não houver dados no vetor, avisar usuário e abandonar rotina.
If Len( aVetor ) == 0
   Aviso( cTitulo, "Não existe dados a consultar", {"Ok"} )
   Return
EndIf

// Monta a tela para usuário visualizar consulta.
DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL
   // Primeira opção para montar o listbox.
   @ 10,10 LISTBOX oLbx FIELDS HEADER ;
   "Banco", "Agencia", "C/C", "Nome Banco", "Fantasia", "Bairro", "Município" ;
   SIZE 230,95 OF oDlg PIXEL	

   oLbx:SetArray( aVetor )
   oLbx:bLine := {|| {aVetor[oLbx:nAt,1],;
                      aVetor[oLbx:nAt,2],;
                      aVetor[oLbx:nAt,3],;
                      aVetor[oLbx:nAt,4],;
                      aVetor[oLbx:nAt,5],;
                      aVetor[oLbx:nAt,6],;
                      aVetor[oLbx:nAt,7]}}
   // Segunda opção para monta o listbox

   oLbx := TWBrowse():New(10,10,230,95,,aCabecalho,, oDlg,,,,,,,,,,,,.F.,,.T.,,.F.,,,)
   oLbx:SetArray( aVetor )
   oLbx:bLine := {||aEval(aVetor[oLbx:nAt],{|z,w| aVetor[oLbx:nAt,w] } ) }	                    
DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTER

Return