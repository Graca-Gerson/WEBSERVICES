User Function FA18()

Local cCampo    := "A1_NOME"
Local nPosUnder := AT(cCampo,"N")

cPrefixo := SUBSTR(cCampo,1, nPosUnder) // ' "A1_"

MsgAlert(cPrefixo)

Return