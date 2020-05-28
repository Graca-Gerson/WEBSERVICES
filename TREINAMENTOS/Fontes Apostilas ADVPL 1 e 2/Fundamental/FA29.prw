User Function FA29()

DbSelectArea("SA1")
DbSetOrder(1) // acordo com o arquivo SIX -> A1_FILIAL+A1_COD+A1_LOJA

IF DbSeek("01" + "000001" + "02" ) // Filial: 01, Código: 000001, Loja: 02

	MsgInfo("Cliente localizado", "Consulta por cliente")

Else
	MsgAlert("Cliente não encontrado", "Consulta por cliente")

Endif

Return