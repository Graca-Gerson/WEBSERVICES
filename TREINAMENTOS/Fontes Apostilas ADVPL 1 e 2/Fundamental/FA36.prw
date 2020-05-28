User Function FA36()

DbSelectArea("SZ1")
RecLock("SZ1",.T.)
	SZ1->A1_FILIAL := xFilial("SZ1") // Retorna a filial de acordo com as configurações do ERP.
	SZ1->Z1_COD := "900001"
	SZ1->Z1_LOJA := "01"
MsUnLock() // Confirma e finaliza a operação.

Return