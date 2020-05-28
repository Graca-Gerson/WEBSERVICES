User Function TPaiPUB()

Local aMatriz 	:= {0,1,2,3}

Public nVar 	:= 10

nVar += aMatriz[3]

MsgAlert("Valor nVar Pai: " + AllTrim(Str(nVar)))

U_TFilha()

MsgAlert("Valor nVar Pai: " + AllTrim(Str(nVar)))

Return(.T.) 
      

User Function TFilha()

nVar += 17

MsgAlert("Valor nVar Filha: " + AllTrim(Str(nVar)))

Return