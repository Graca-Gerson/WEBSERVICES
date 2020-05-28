User Function FA8()

LOCAL nL	:= 0
Local nD	:= 0
Local nP 	:= 0
Local cData := "20180822"

nL := Len(cdata)
nD := 0
nP := 1

While nL > 0
	nP := nP + 1
	nD := nD + (Val(SubStr(cData, nL, 1)) * nP)
	If nP = 9
		nP := 1
	End
	nL := nL - 1
End

nD := 11 - (mod(nD,11))
If (nD == 0 .Or. nD == 1 .Or. nD == 10 .Or. nD == 11)
	nD := 1
End

MsgAlert("Valor: " +AllTrim(Str(nD)))

Return