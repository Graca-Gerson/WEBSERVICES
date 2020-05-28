User Function FA25()

DbSelectArea("SA1")
DbGoto(100) // Posiciona no registro 100

If !EOF() // Se a área de trabalho não estiver em final de arquivo
	MsgInfo("Você está no cliente:"+A1_NOME)
EndIf

Return