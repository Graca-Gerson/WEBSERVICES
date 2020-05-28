User Function TOper()

Local nSalario 	:= 1000
Local nDesconto := 0.10
Local nAumento
Local nSalLiquido

nAumento := nSalario * 1.20

nSalLiquido := nAumento * (1-nDesconto)

MsgAlert("Valor: " + AllTrim(Str(nSalLiquido)))

Return