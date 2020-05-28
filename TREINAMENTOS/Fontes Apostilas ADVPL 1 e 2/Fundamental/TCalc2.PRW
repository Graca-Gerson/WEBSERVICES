User Function TCalc2()

Local nPercentual
Local nResultado

nPercentual := 10

nResultado := 250 * (1 + (nPercentual / 100))

MsgAlert("Valor: " + AllTrim(Str(nResultado)))

Return