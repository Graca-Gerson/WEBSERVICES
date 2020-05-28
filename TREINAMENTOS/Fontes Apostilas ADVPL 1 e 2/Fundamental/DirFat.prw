User Function DirFat()

Local nResultado := 0
Local nFatorUser := 0

nFatorUser := GetFator()

nResultado := U_CalcFat(nFatorUser)

Return

Static Function GetFator()

Local nFat := 23

Return nFat