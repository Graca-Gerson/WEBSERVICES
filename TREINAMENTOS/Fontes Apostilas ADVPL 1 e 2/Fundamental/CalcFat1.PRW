User Function TF3()

Local nFat := Nil

U_CalcFat(nFat)

Return


User Function CalcFat(nFator)

Local nCnt
Local nResultado := 0

// O Valor do nCnt ir� assumir o valor do nFator que � Nulo

For nCnt := nFator To 1 Step -1 
  nResultado *= nCnt
Next nCnt 
// Ao efetuar o Next, o interpretador realiza a a��o nCnt += 1. 
// Isso ir� gerar um erro log pois o nCnt ser� Nulo

Return nResultado