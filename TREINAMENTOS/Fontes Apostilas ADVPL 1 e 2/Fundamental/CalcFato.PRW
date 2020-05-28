User Function CalcFat(nFator)

Local nCnt
Local nResultado := 0

Default nFator := 1

For nCnt := nFator To 1 Step -1
	nResultado *= nCnt
Next nCnt	

Alert("O fatorial de " + cValToChar(nFator) +  " é " + ValToChar(nResultado))

Return nResultado