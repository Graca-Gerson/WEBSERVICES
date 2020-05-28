User Function FA32()

DbSelectArea("SA1")
DbSetOrder(2) // A1_FILIAL + A1_NOME
DbGoBotton() // Posiciona o cursor no final da área de trabalho ativa.

While !BOF() // Enquanto o cursor da área de trabalho ativa não indicar início de arquivo
	MsgInfo("Você está no cliente:" + SA1->A1_NOME)
	DbSkip(-1)
EndDo

Return