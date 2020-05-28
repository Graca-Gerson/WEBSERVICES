User Function TA4()

Local nCnt
Local aX[0]
Local aY := Array(0)
Local aZ := {}
Local nSize := 15 

For nCnt := 1 To nSize
	AADD(aX, nCnt*nCnt)
	AADD(aY, nCnt+nCnt)
	AADD(aZ, nCnt*nCnt)
Next nCnt

MsgAlert(AllTrim(Str(aX[3])))
MsgAlert(AllTrim(Str(aY[5])))
MsgAlert(AllTrim(Str(aZ[4])))

Return