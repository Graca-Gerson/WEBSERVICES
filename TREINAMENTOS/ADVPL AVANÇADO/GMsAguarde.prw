#Include "Protheus.ch"

User Function GMsAguarde()

Private lEnd := .F.

MsAguarde({|lEnd| RunProc(@lEnd)},"Aguarde...","Processando Clientes",.T.)

Return

Static Function RunProc(lEnd)

dbSelectArea("SX5")
dbSetOrder(1)
dbGoTop()

While !Eof()
   If lEnd
      MsgInfo(cCancel,"Fim")
      Exit
   Endif
   MsProcTxt("Tabela: "+SX5->X5_TABELA+" Chave: "+SX5->X5_CHAVE)
   dbSkip()
EndDo

Return