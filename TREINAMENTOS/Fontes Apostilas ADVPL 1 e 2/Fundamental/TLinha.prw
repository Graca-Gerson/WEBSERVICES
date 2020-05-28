User Function TLinha()

Local cNome := "Pedro da Silva"
Local cEnd	:= "Ruas das Flores, 77"
Local cTel	:= "031-98888-7677"
Local cFax	:= "031-3454-7677"
Local cEmail:= "treinamento@treinamento.com"

If 	!Empty(cNome) .And. !Empty(cEnd) .And. ; //<enter>
	!Empty(cTel) .And. !Empty(cFax) .And. ; //<enter>
	!Empty(cEmail)
	
 	MsgAlert(AllTrim(cNome) + ", "+ AllTrim(cEnd) + ", " +;
 			 AllTrim(cTel) + ", " + AllTrim(cFax) + ", " +;
 			 AllTrim(cEmail) + ".")
EndIf

Return