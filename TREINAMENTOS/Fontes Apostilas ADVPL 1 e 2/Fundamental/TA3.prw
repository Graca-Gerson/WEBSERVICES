User Function TA3()

Local nCnt
Local aX[10]
Local aY := Array(10)
Local aZ := {0,0,0,0,0,0,0,0,0,0}

For nCnt := 1 To 10
 	aX[nCnt] := nCnt * nCnt
	aY[nCnt] := nCnt + nCnt
	aZ[nCnt] := nCnt * nCnt
 Next nCnt

MsgAlert(AllTrim(Str(aX[3])))
MsgAlert(AllTrim(Str(aY[5])))
MsgAlert(AllTrim(Str(aZ[4])))

Return