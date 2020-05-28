User Function TPaiS()

Local aMatriz 	:= {0,1,2,3}

Static nVar 	:= 10

nVar += aMatriz[3]

TFilha()

MsgAlert("Valor nVar Pai: " + AllTrim(Str(nVar)))

Return(.T.) 
      

Static Function TFilha()

Static nVar

MsgAlert("Valor nVar Filha: " + AllTrim(Str(nVar)))

Return