User Function PET070()

Local cParam 	:= PARAMIXB[1]
Local aReturn 	:= {}         

Do Case
    Case cParam == 1    
   		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    
			aAdd( aReturn, "PRODUCTCODE" )
			aAdd( aReturn, "DESCRIPTION" )
			aAdd( aReturn, { "GROUPOFPRODUCT", "N", { "GETGROUPOFPRODUCT", ;
																{ "CGROUPOFPRODUCT", "CGROUPCODE" };
															}, ;
															{ "CGROUPCODE", "CDESCRIPTION" } } )
			aAdd( aReturn, { "TYPEOFPRODUCT", "N", { "GETTYPEOFPRODUCT", ;
																{ "CTYPEOFPRODUCT", "CCODE" };
															}, ;
															{ "CCODE", "CDESCRIPTION" } } )
    
	Case cParam == 2
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aAdd( aReturn, "CODE" )
			aAdd( aReturn, "DESCRIPTION" )

								
    Case cParam == 3
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aadd( aReturn, "PRODUCTCODE" )
			aadd( aReturn, "DESCRIPTION" )
	    
EndCase
						
Return aReturn