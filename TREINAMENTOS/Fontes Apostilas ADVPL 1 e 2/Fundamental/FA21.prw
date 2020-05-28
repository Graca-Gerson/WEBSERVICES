User Function FA21()

Local nQuantidade 	:= 33
Local nDinheiro 	:= 0.30
Local nPrcUnit  	:= 0.25

If nDinheiro >= (nQuantidade*nPrcUnit)
	Return nQuantidade
ElseIf nDinheiro > nPrcUnit
	nQuantidade := INT(nDinheiro / nPrcUnit)
Else
	nQuantidade := 0
EndIf

MsgAlert("Valor: " + AllTrim(nQuantidade))

Return 