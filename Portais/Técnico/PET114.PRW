User Function PET114()

Local cParam 	:= PARAMIXB[1]
Local aReturn 	:= {}         

Do Case
	Case cParam == 1
	
    Case cParam == 2    
   		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴� 
			aAdd( aReturn, "SERVICESTATUS" )
			aAdd( aReturn, { "PRODUCTID", "N", { "GETCATALOG", ;
															{ "CPRODUCTID", "CPRODUCTCODE" } ;
														}, ;
														{ "CPRODUCTCODE", "CDESCRIPTION" } } )
			aAdd( aReturn, "SERIALNUMBER" )
			aAdd( aReturn, "FAILURE" )
			aAdd( aReturn, "NOTES" )
			aAdd( aReturn, "SERVICEORDERID" )
			aAdd( aReturn, "SERVICECALLID" )
    
	Case cParam == 3
	Case cParam == 4
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aAdd( aReturn, "SERVICESTATUS" )
			aAdd( aReturn, { "PRODUCTID", "N", { "GETCATALOG", ;
															{ "CPRODUCTID", "CPRODUCTCODE" } ;
														}, ;
														{ "CPRODUCTCODE", "CDESCRIPTION" } } )
			aAdd( aReturn, "SERIALNUMBER" )
			aAdd( aReturn, "FAILURE" )
			aAdd( aReturn, "NOTES" )
			aAdd( aReturn, "SERVICEORDERID" )
			aAdd( aReturn, "SERVICECALLID" )
								

    
EndCase
						
Return aReturn