User Function TPaiP()

Local aMatriz 	:= {0,1,2,3}

Private nVar 	:= 10

nVar += aMatriz[3]

MsgAlert("Valor nVar Pai: " + AllTrim(Str(nVar)))

TFilha()

MsgAlert("Valor nVar Pai: " + AllTrim(Str(nVar)))

Return(.T.) 
      

Static Function TFilha()

nVar += 10

MsgAlert("Valor nVar Filha: " + AllTrim(Str(nVar)))

Return