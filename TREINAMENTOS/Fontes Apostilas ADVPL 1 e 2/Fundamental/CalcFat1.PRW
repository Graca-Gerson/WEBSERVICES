User Function TF3()

Local nFat := Nil

U_CalcFat(nFat)

Return


User Function CalcFat(nFator)

Local nCnt
Local nResultado := 0

// O Valor do nCnt irá assumir o valor do nFator que é Nulo

For nCnt := nFator To 1 Step -1 
  nResultado *= nCnt
Next nCnt 
// Ao efetuar o Next, o interpretador realiza a ação nCnt += 1. 
// Isso irá gerar um erro log pois o nCnt será Nulo

Return nResultado