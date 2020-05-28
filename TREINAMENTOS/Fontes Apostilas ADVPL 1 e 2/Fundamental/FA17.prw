User Function FA17()

cLin  := Space(100) // Cria a string base

cCpo := PADR(SA1->A1_FILIAL,02) // Informação que será armazenada na string

cLin := Stuff(cLin,01,02,cCpo) // Substitui o conteúdo de cCpo na string base

MsgAlert(cLin)

Return