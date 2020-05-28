#Include "Protheus.ch"

User Function GProces2()

Private oProcess := NIL

oProcess := MsNewProcess():New({|lEnd| RunProc(lEnd,oProcess)},"Processando","Lendo...",.T.)
oProcess:Activate()

Return Nil


Static Function RunProc(lEnd,oObj)
Local nI := 0
Local aTabela := {}
Local nCnt := 0
                   
aTabela := {{"00",0},{"13",0},{"35",0},{"T3",0}}

dbSelectArea("SX5")
cFilialSX5 := xFilial("SX5")
dbSetOrder(1)
For nI:=1 To Len(aTabela)
   dbSeek(cFilialSX5+aTabela[nI,1])
   While !Eof() .And. X5_FILIAL+X5_TABELA == cFilialSX5+aTabela[nI,1]
      If lEnd
         Exit
      EndIf
      nCnt++
      dbSkip()
   EndDo
   aTabela[nI,2] := nCnt
   nCnt := 0
Next nI

oObj:SetRegua1(Len(aTabela))
For nI:=1 To Len(aTabela)
   If lEnd
      Exit
   EndIf
   oObj:IncRegua1("Lendo Tabela: "+aTabela[nI,1])
   dbSelectArea("SX5")
   dbSeek(cFilialSX5+aTabela[nI,1])
   oObj:SetRegua2(aTabela[nI,2])
   While !Eof() .And. X5_FILIAL+X5_TABELA == cFilialSX5+aTabela[nI,1]
      oObj:IncRegua2("Lendo chave: "+X5_CHAVE)
      If lEnd
         Exit
      EndIf
      dbSkip()
   EndDo
Next nI

Return