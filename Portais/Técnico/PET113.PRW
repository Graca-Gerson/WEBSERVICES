User Function PET113()

Local cParam 	:= PARAMIXB[1]
Local aReturn 	:= {}         

Do Case
    Case cParam == 1    
   		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴� 
			aAdd( aReturn, { "D", "ISSUEDATE" } )
			aAdd( aReturn, { "D", "BUDGETTIME" } )
			aAdd( aReturn, { "CUSTOMERCODE", "N", { "BRWCUSTOMER", ;
																{ "CCUSTOMERCODE", "CCODE" }, ;
																{ "CCUSTOMERUNIT", "CUNIT" } ;
															}, ;
															{ "CCODE", "CUNIT", "CDESCRIPTION" } } )
			aAdd( aReturn, "CUSTOMERUNIT" )
			aAdd( aReturn, "ATTENDANT" )
			aAdd( aReturn, { "PAYMENTPLANCODE", "N", { "BRWPAYMENTPLAN", ;
																{ "CPAYMENTPLANCODE", "CPAYMENTPLANCODE" } ;
															}, ;
															{ "CPAYMENTPLANCODE", "CDESCRIPTIONPAYMENTPLAN" } } )
			aAdd( aReturn, "PRICELISTCODE" )
			aAdd( aReturn, "DISCOUNT1" )
			aAdd( aReturn, "DISCOUNT2" )
			aAdd( aReturn, "DISCOUNT3" )
			aAdd( aReturn, "CURRENCY" )
    
	Case cParam == 2
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Campos a serem mostrados             									�
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			aAdd( aReturn, { "D", "ISSUEDATE" } )
			aAdd( aReturn, { "D", "BUDGETTIME" } )
			aAdd( aReturn, { "CUSTOMERCODE", "N", { "BRWCUSTOMER", ;
																{ "CCUSTOMERCODE", "CCODE" }, ;
																{ "CCUSTOMERUNIT", "CUNIT" } ;
															}, ;
															{ "CCODE", "CUNIT", "CDESCRIPTION" } } )
			aAdd( aReturn, "CUSTOMERUNIT" )
			aAdd( aReturn, "ATTENDANT" )
			aAdd( aReturn, { "PAYMENTPLANCODE", "N", { "BRWPAYMENTPLAN", ;
																{ "CPAYMENTPLANCODE", "CPAYMENTPLANCODE" } ;
															}, ;
															{ "CPAYMENTPLANCODE", "CDESCRIPTIONPAYMENTPLAN" } } )
			aAdd( aReturn, "PRICELISTCODE" )
			aAdd( aReturn, "DISCOUNT1" )
			aAdd( aReturn, "DISCOUNT2" )
			aAdd( aReturn, "DISCOUNT3" )
			aAdd( aReturn, "CURRENCY" )
								

    
EndCase
						
Return aReturn