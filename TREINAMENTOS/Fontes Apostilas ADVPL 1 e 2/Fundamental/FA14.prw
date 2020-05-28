User Function FA14()

Local cArg1 	:= "Último"
Local nConta 	:= 0           
Local cLetra 	:= ""        
Local cRet   	:= ""

cArg1 := Upper(cArg1)

For nConta:= 1 To Len(cArg1)	
	cLetra := SubStr(cArg1, nConta, 1)
Do Case
	Case (Asc(cLetra) > 191 .and. Asc(cLetra) < 198) .or.;
 		(Asc(cLetra) > 223 .and. Asc(cLetra) < 230)
		cLetra := "A"
	Case (Asc(cLetra) > 199 .and. Asc(cLetra) < 204) .or.;
 		(Asc(cLetra) > 231 .and. Asc(cLetra) < 236)
		cLetra := "E"
	Case (Asc(cLetra) > 204 .and. Asc(cLetra) < 207) .or.;
		(Asc(cLetra) > 235 .and. Asc(cLetra) < 240)
		cLetra := "I"
 		Case (Asc(cLetra) > 209 .and. Asc(cLetra) < 215) .or.;
 		(Asc(cLetra) == 240) .or. (Asc(cLetra) > 241 .and. ;
            Asc(cLetra) < 247)
			cLetra := "O"
		
	Case (Asc(cLetra) > 216 .and. Asc(cLetra) < 221) .or.;
 		(Asc(cLetra) > 248 .and. Asc(cLetra) < 253)
	 	 cLetra := "U"
		
 	Case Asc(cLetra) == 199 .or. Asc(cLetra) == 231
			cLetra := "C"

 		EndCase   

	cRet := cRet+cLetra

Next

MsgAlert(Upper(cRet))

Return 