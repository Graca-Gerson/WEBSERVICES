User Function PET024()

Local cParam 	:= PARAMIXB[1]
Local aReturn 	:= {}         

Do Case
	Case cParam == 1 

	Case cParam == 2     
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aAdd( aReturn, { "PRODUCTID", "N", { "GETCATALOG", ;
																{ "CPRODUCTID", "CPRODUCTCODE" } ;
															}, ;
															{ "CPRODUCTCODE", "CDESCRIPTION" } } )
			aAdd( aReturn, "SERVICEORDERSTATUS" )
			aAdd( aReturn, "SERIALNUMBER" )
			aAdd( aReturn, "FAILURECODE" )
			aAdd( aReturn, "SOLUTION" )

	Case cParam == 3 

	Case cParam == 4     
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		
			aAdd( aReturn, { "PRODUCTID", "N", { "GETCATALOG", ;
																{ "CPRODUCTID", "CPRODUCTCODE" } ;
															}, ;
															{ "CPRODUCTCODE", "CDESCRIPTION" } } )
			aAdd( aReturn, "SERVICEORDERSTATUS" )
			aAdd( aReturn, "SERIALNUMBER" )
			aAdd( aReturn, "FAILURECODE" )
			aAdd( aReturn, "SOLUTION" )
EndCase
						
Return aReturn