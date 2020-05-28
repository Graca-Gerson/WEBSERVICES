User Function FA31()

DbSelectArea("SA1")
DbSetOrder(2) // A1_FILIAL + A1_NOME
DbGotop() // Posiciona o cursor no início da área de trabalho ativa.

While !EOF() // Enquanto o cursor da área de trabalho ativa não indicar fim de arquivo
	MsgInfo("Você está no cliente:" + SA1->A1_NOME)
	DbSkip()
End

Return