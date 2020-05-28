User Function FA26()

Local nCount := 0 // Variável para verificar quantos registros há no intervalo

DbSelectArea("SA1")
DbSetOrder(1) // A1_FILIAL + A1_COD + A1_LOJA
DbGoTop()

While !BOF() // Enquanto não for o início do arquivo
	nCount++ // Incrementa a variável de controle de registros no intervalo
	DbSkip(-1)
EndDo

MsgInfo("Existem :"+STRZERO(nCount,6)+ "registros no intervalo")

// Retorno esperado :000001, pois o DbGoTop posiciona no primeiro 
// registro.

Return