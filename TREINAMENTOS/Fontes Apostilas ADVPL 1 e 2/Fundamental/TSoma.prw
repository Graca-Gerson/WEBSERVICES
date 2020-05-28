User Function TSoma()

Local nCnt
Local nSoma := 0 // Inicializa a variável com zero para a soma.

For nCnt := 1 To 10
	nSoma += nCnt
Next nCnt

MsgAlert(Str(nSoma))

Return