User Function TCalc3()

Local nPercentual := 10
Local nResultado

nResultado := 250 * (1 + (nPercentual / 100))

MsgAlert("Valor: " + AllTrim(Str(nResultado)))

Return