User Function TIf()

Local dVencto := CTOD("31/12/16")

If Date() > dVencto
	Alert("Vencimento ultrapassado!")
Endif

Return