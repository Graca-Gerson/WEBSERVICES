User Function FA20()

Local nPessoas := 20
Local nLugares := 18

If nPessoas < nLugares
	MsgInfo("Existem "+AllTrim(Str(nLugares- nPessoas))+"disponíveis")
Else
	MsgStop("Existem "+AllTrim(Str((ABS(nLugares- nPessoas))))+"faltando")
EndIf

Return