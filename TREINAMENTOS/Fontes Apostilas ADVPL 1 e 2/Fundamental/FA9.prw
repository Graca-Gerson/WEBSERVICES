User Function FA9()

IF Type("dDataBase") == "D"
	MsgInfo("Database do sistema: "+DtoC(dDataBase))
ELSE
	MsgInfo("Variável indefinida no momento")
EndIf

Return