User Function PET043()

Local cParam 	:= PARAMIXB[1]
Local aReturn 	:= {}         

Do Case
	Case cParam == 1 
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aAdd( aReturn, "SERVICEORDERID")
			aAdd( aReturn, "TECHNICIANCODE")
			aAdd( aReturn, "SEQUENCE")
			aAdd( aReturn, "ARRIVALDATE")
			aAdd( aReturn, "ARRIVALTIME")
			aAdd( aReturn, "EXITDATE")
			aAdd( aReturn, "EXITTIME")
			aAdd( aReturn, "BEGINDATE")
			aAdd( aReturn, "BEGINTIME")
			aAdd( aReturn, "FINISHDATE")
			aAdd( aReturn, "FINISHTIME")
			aAdd( aReturn, "FAILURECODE")
			aAdd( aReturn, "ACCUMULATOR")
			aAdd( aReturn, "INVOICEDHOURS")
			aAdd( aReturn, "TASKCODE")
	Case cParam == 2     
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aAdd( aReturn, "SERVICEORDERID")
			aAdd( aReturn, "TECHNICIANCODE")
			aAdd( aReturn, "SEQUENCE")
			aAdd( aReturn, "ARRIVALDATE")
			aAdd( aReturn, "ARRIVALTIME")
			aAdd( aReturn, "EXITDATE")
			aAdd( aReturn, "EXITTIME")
			aAdd( aReturn, "BEGINDATE")
			aAdd( aReturn, "BEGINTIME")
			aAdd( aReturn, "FINISHDATE")
			aAdd( aReturn, "FINISHTIME")
			aAdd( aReturn, "TRANSFER")
			aAdd( aReturn, "FAILURECODE")
			aAdd( aReturn, "ACCUMULATOR")
			aAdd( aReturn, "INVOICEDHOURS")
			aAdd( aReturn, "TASKCODE")
EndCase
						
Return aReturn