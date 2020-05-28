User Function FA40()

DbSelectArea("SZ1")

DbSetOrder(1) // Z1_FILIAL + Z1_COD + Z1_LOJA
DbSeek("01" + "900001" + "01") // Busca exata

If Found()
	RecLock("SZ1",.F.)  // Define que será realizada uma alteração no registro posicionado.
		DbDelete() // Efetua a exclusão lógica do registro posicionado.
	MsUnLock() // Confirma e finaliza a operação.
EndIf

Return