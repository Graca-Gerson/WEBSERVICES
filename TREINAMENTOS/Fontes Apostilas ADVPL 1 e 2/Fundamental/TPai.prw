User Function TPai()

Local nVar 		:= 10
Local aMatriz 	:= {0,1,2,3}

nVar += aMatriz[3]

TFilha()

MsgAlert("Valor nVar Pai: " + AllTrim(Str(nVar)))

Return(.T.) 
      

Static Function TFilha()

Local nVar := 13

MsgAlert("Valor nVar Filha: " + AllTrim(Str(nVar)))

Return