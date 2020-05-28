User Function FA15()

Local cNoMascara 	:= ""
Local nX		 	:= 0
Local cString		:= "Teste de Funcao" 
Local cMascara		:= ""
Local nTamanho		:= 10

IF !Empty(cMascara) .AND. AT(cMascara,cString) > 0
	FOR nX := 1 TO Len(cString)
		IF !(SUBSTR(cString,nX,1) $ cMascara)
			cNoMascara += SUBSTR(cString,nX,1)
		ENDIF
	NEXT nX
	cNoMascara := PADR(ALLTRIM(cNoMascara),nTamanho)
ELSE
	cNoMascara := PADR(ALLTRIM(cString),nTamanho)
ENDIF

MsgAlert(cNoMascara)

Return