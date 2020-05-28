User Function FA13()

Local cNome := ALLTRIM(SA1->A1_NOME)

MSGINFO("Dados do campo A1_NOME:" + ;
		"Tamanho:" + CVALTOCHAR(LEN(SA1->A1_NOME))+;
		"Texto:" + CVALTOCHAR(LEN(cNome)))
Return