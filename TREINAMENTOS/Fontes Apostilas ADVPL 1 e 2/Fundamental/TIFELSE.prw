User Function TIFELSE()

Local dVencto := CTOD("31/12/16")

If Date() > dVencto
	Alert("Vencimento ultrapassado!")
ElseIf Date() == dVencto
	Alert("Vencimento na data!")
Else
	Alert("Vencimento dentro do prazo!")
EndIf

Return