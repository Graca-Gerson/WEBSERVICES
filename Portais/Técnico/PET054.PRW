User Function PET054()

Local cParam 	:= PARAMIXB[1]
Local aReturn 	:= {}         

Do Case
	Case cParam == 1

	Case cParam == 2
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		aAdd( aReturn, { "PRODUCTID", "D" } )
		aAdd( aReturn, "QUANTITY" )
		aAdd( aReturn, { "MEASUREUNIT", "D" } )
		aAdd( aReturn, "SERVICECODE" )
		aAdd( aReturn, "SECONDMEASUREUNITQUANTITY" )
		aAdd( aReturn, "SECONDMEASUREUNIT" )
		aAdd( aReturn, "TECHNICIANCODE" )
		aAdd( aReturn, "SEQUENCE" )
	Case cParam == 3

	Case cParam == 4
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aAdd( aReturn, { "PRODUCTID", "N", { "GETCATALOG", ;
																	{ "CPRODUCTID", "CPRODUCTCODE" } ;
																}, ;
																{ "CPRODUCTCODE", "CDESCRIPTION" } } )
			aAdd( aReturn, "QUANTITY" )
			aAdd( aReturn, { "MEASUREUNIT", "D" } )
			aAdd( aReturn, "SERVICECODE" )
			aAdd( aReturn, "SECONDMEASUREUNITQUANTITY" )
			aAdd( aReturn, "SECONDMEASUREUNIT" )
			aAdd( aReturn, "TECHNICIANCODE" )
			aAdd( aReturn, "SEQUENCE" )        								
	
EndCase
						
Return aReturn