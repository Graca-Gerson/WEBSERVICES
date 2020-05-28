User Function CalcFat(nFator)

Local nCnt			:= 0
Local nResultado 	:= 0

For nCnt := nFator To 1 Step -1
	nResultado *= nCnt
Next nCnt

Alert("O fatorial de " + AllTrim(Str(nFator)) +  " é " + AllTrim(Str(nResultado)))
 
Return