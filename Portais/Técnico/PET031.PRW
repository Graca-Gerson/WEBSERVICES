User Function PET031()

Local cParam 	:= PARAMIXB[1]
Local aReturn 	:= {}         

Do Case
	Case cParam == 1
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	
			aAdd( aReturn, { "CUSTOMERCODE", "N", { "BRWCUSTOMER", ;
																{ "CCUSTOMERCODE", "CCODE" }, ;
																{ "CUNITCUSTOMERCODE", "CUNIT" } ;
															}, ;
															{ "CCODE", "CUNIT", "CDESCRIPTION" } } )
			aAdd( aReturn, "UNITCUSTOMERCODE" ) 

	Case cParam == 2
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aAdd( aReturn, { "PRODUCTCODE", "N", { "GETCATALOG", ;
																{ "CPRODUCTCODE", "CPRODUCTCODE" };
															}, ;
															{ "CPRODUCTCODE", "CDESCRIPTION" } } )
															
	Case cParam == 3
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aAdd( aReturn, "CUSTOMERCODE" )
			aAdd( aReturn, "UNITCUSTOMERCODE" )
			aAdd( aReturn, "PRODUCTCODE" )
			aAdd( aReturn, "SERIALNUMBER" )
			aAdd( aReturn, "MANUFACTURERCODE" )
			aAdd( aReturn, "UNITMANUFACTURERCODE" )
		
EndCase
						
Return aReturn