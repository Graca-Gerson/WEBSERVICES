User Function FA37()

DbSelectArea("SZ1")
DbSetOrder(1) // A1_FILIAL + A1_COD + A1_LOJA
DbSeek("01" + "900001" + "01") // Busca exata

If Found() // Avalia o retorno do último DbSeek realizado
RecLock("SZ1",.F.)
	SZ1->Z1_NOME := "CLIENTE CURSO ADVPL BÁSICO"
	SZ1->Z1_NREDUZ := "ADVPL BÁSICO"
MsUnLock() // Confirma e finaliza a operação

EndIf

Return