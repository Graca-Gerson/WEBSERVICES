#Include "Protheus.ch"

User Function GMsgRun()

LOCAL nCnt := 0

dbSelectArea("SX1")
dbGoTop()

MsgRun("Lendo arquivo, aguarde...","T�tulo opcional",;
       {||dbEval({|x| nCnt++}) })

MsgInfo("Ufa!!!, li "+AllTrim(Str(nCnt))+" registros",FunName())

Return