User Function TWhile()

Local nAux 		:= 200
Local nCnt		:= 2
Local nSomaPar	:= 0

nAux := Int(nAux / 2) 

While nAux > 0
	nSomaPar += nCnt
	nCnt += 1
	nAux -= 1
EndDo

Alert( "A soma dos 100 primeiros números é: " + ;
       cValToChar(nSomaPar) ) 

Return