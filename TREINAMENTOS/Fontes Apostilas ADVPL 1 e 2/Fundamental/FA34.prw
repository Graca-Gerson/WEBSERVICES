User Function FA34()

Local bCondic := { | | A1_COD >= "000001" .AND. A1_COD <= "001000" }

dbSelectArea('SA1')
dbSetOrder(1)     // A1_FILIAL + A1_COD
dbSetFilter(bCondic)
dbGoBotton()

While !EOF()
   MsgInfo("Você está no cliente: " + A1_COD)
   dbSkip()
EndDo

Return