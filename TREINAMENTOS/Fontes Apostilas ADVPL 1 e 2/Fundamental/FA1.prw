User Function FA1()

cData := "31/12/2016"
dData := CTOD(cData)

If dDataBase >= dData
	MsgAlert("Data do sistema fora da competência")
Else
	MsgInfo("Data do sistema dentro da competência")
EndIf

Return