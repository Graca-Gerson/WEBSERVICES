User Function FA35()

Local cCampos := ""

DbSelectArea("SA1")

aStructSA1 := DbStruct()

For nX := 1 to Len(aStructSA1)
	cCampos += aStructSA1[nX][1] + "/"
Next nX

Alert(cCampos)

Return