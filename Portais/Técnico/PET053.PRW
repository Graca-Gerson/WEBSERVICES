User Function PET053()

Local cParam 	:= PARAMIXB[1]
Local aReturn 	:= {}         

Do Case
	Case cParam == 1

	Case cParam == 2
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aAdd( aReturn, "ISSUEDATE" )
			aAdd( aReturn, "SERVICEORDERITEM" )
			aAdd( aReturn, "REQUISITIONSEQUENCE" )
			aAdd( aReturn, "TECHNICIANCODE" )
			aAdd( aReturn, "PETITIONER" )
								
	
EndCase
						
Return aReturn