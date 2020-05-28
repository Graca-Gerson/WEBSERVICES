#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
#INCLUDE "TOPCONN.CH"

WSRESTFUL VALIDA_TELEFONE DESCRIPTION "Consulta ao cadastro de Clientes REST"

WSDATA R_STATUS     	AS STRING
WSDATA R_VENDEDOR     	AS STRING
WSDATA R_GRUPO    	 	AS STRING
WSDATA R_RAMAL   	  	AS STRING
WSDATA R_CPFCNPJ     	AS STRING
WSDATA R_RAZAO			AS STRING
WSDATA R_MUNIC			AS STRING
WSDATA R_UF				AS STRING
// Passagem dos parâmetros de entrada
WSDATA E_NA         	AS string
WSDATA E_CPFCNPJ    	AS string


WSMETHOD GET DESCRIPTION "RETORNO DE DADOS DO CADASTRO DE CLIENTE A PARTIR DOS PARAMETROS INFORMADOS" WSSYNTAX "/VALIDA_TELEFONE || /VALIDA TELEFONE/{id}"

END WSRESTFUL

WSMETHOD GET WSRECEIVE E_NA,E_CPFCNPJ  WSSERVICE VALIDA_TELEFONE

Local i
Local aParam	:= ::aURLParms
Local cEmp := '99'
Local cFil := '01'
Local aRetFuncao := {}
Local WInd := 0
	
	//--------------------------------------------------------------
	// Abre o ambiente
	//--------------------------------------------------------------
	RpcClearEnv()
	RpcSetType(3)
	RpcSetEnv(cEmp,cFil)
	
	// define o tipo de retorno do metodo
	::SetContentType("application/xml")
	//::SetContentType("application/json")
	
	// verifica se recebeu parametro pela URL
	// exemplo: http://localhost:8080/CONSULTACLI/011/40030015
	
	// as propriedades da classe receberÃ£o os valores enviados por querystring
	// exemplo: http://localhost:10004/VALIDA_TELEFONE?E_NA=01140030015
	// exemplo: http://localhost:10004/VALIDA_TELEFONE?E_CPFCNPJ=04860597000103
	// exemplo: http://localhost:10004/VALIDA_TELEFONE?E_NA=01140030015&E_CPFCNPJ=04860597000103
	
	
	
	//BUSCA OS DADOS A PARTIR DO QUE FOI PASSADO PELA URL
	aRetFuncao     := u_XMATRTCL(::E_NA,::E_CPFCNPJ)
	
	//SETA O CABEÇALHO DO XML QUE SER�O GERADO
	
	::SetResponse('<!--?xml version="1.0"encoding="utf-8"?-->')
	
	
	IF len(aRetFuncao) == 0
		::SetResponse('<resultado>')
		::SetResponse('<R_STATUS>'  + '2' +	'</R_STATUS>' )
		::SetResponse('<R_VENDEDOR></R_VENDEDOR>' )
		::SetResponse('<R_GRUPO></R_GRUPO>' )
		::SetResponse('<R_RAMAL></R_RAMAL>' )
		::SetResponse('<R_CPFCNPJ></R_CPFCNPJ>' )
		::SetResponse('<R_RAZAO></R_RAZAO>' )
		::SetResponse('<R_MUNIC></R_MUNIC>' )
		::SetResponse('<R_UF></R_UF>' )
		::SetResponse('</resultado>')
	ELSE
		::SetResponse('<resultado>')
		for WInd := 1 to len(aRetFuncao)
	//::SetResponse('<resultado'+alltrim(STR(WIND))+'>')
		//	::SetResponse('<R_ID' + alltrim(STR(WIND)) + '>')
			
				::SetResponse('<R_STATUS>' 		+ '1' +	'</R_STATUS>' )
				::SetResponse('<R_VENDEDOR>' 	+ aRetFuncao[WInd][2] +	'</R_VENDEDOR>' )
				::SetResponse('<R_GRUPO>' 		+ aRetFuncao[WInd][3] +	'</R_GRUPO>' )
				::SetResponse('<R_RAMAL>' 		+ aRetFuncao[WInd][4] +	'</R_RAMAL>' )
				::SetResponse('<R_CPFCNPJ>' 	+ aRetFuncao[WInd][5] +	'</R_CPFCNPJ>' )
				::SetResponse('<R_RAZAO>' 		+ aRetFuncao[WInd][6] +	'</R_RAZAO>' )
				::SetResponse('<R_MUNIC>'		+ aRetFuncao[WInd][7] +	'</R_MUNIC>' )
				::SetResponse('<R_UF>' 			+ aRetFuncao[WInd][8] +	'</R_UF>' )

		//	::SetResponse('</R_ID>' )
	//::SetResponse('</resultado'+alltrim(STR(WIND))+'>')
		Next WInd       
		::SetResponse('</resultado>')
		
	ENDIF
	
Return .T.


/*************************************************************
** Retorna os dados do cliente
**************************************************************/
User Function XMATRTCL(cTelefone, cCPFCNPJ)
	Local aDadoCl         := {}
	
	Local aTables    := { "SM0" }
	
	Conout(dtoc( Date() )+" "+Time()+ " == Abrindo ambiente TOP CONNECT =======")
	//RPCSetType( 3 )
	//RpcSetEnv ( "01", "01", Nil, Nil, "FAT", Nil, aTables )
	
	IF Alltrim(cTelefone) <> '' .OR. Alltrim(cCPFCNPJ) <> '' //VERIFICA SE ALGUM PARAMETRO EST�O PREENCHIDO
		
		cQuery := " SELECT DISTINCT A1_COD, A1_NOME, A1_MUN,A1_EST,A1_VEND,A1_XVDSUBS,A1_XGRPVEN,A1_CGC,A3_XRAMAL"
		cQuery += "  FROM "+RETSQLNAME("SA1")+" A1 "
		cQuery += " LEFT JOIN "+RETSQLNAME("AC8")+" AC8 ON AC8_FILIAL = '" + XFILIAL("AC8") + "' AND AC8.D_E_L_E_T_ = '' AND AC8_ENTIDA = 'SA1' AND AC8_CODENT = A1_COD+A1_LOJA "
		cQuery += " LEFT JOIN "+RETSQLNAME("SU5")+" SU5 ON  U5_FILIAL = '" + XFILIAL("SU5") + "' AND SU5.D_E_L_E_T_ = '' AND U5_CODCONT = AC8_CODCON "
		
		cQuery += " JOIN " + RETSQLNAME("SA3") + " A3 ON A3_FILIAL = '" + XFILIAL("SA3") + "' AND A1_VEND = A3_COD AND A3.D_E_L_E_T_ <> '*' "
		cQuery += " WHERE A1_FILIAL = '" + XFILIAL("SA1") + "' AND A1.D_E_L_E_T_ <> '*' "
		
		IF Alltrim(cTelefone)<>'' .AND. ALLTRIM(cCPFCNPJ) == '' // PESQUISA POR NUMERO DE TELEFONE
			CDDD := SUBSTR(Alltrim(cTelefone),1,2)
			CFONE := SUBSTR(Alltrim(cTelefone),3)
			
			cQuery += " AND U5_DDD LIKE '%" + CDDD + "%' AND U5_FCOM2 = '" + CFONE + "' "
		ENDIF
		
		IF Alltrim(cCPFCNPJ) <> '' .AND. Alltrim(cTelefone)=='' // INCLUI CLAUSULA DE CNPJ CONSULTA SOMENTE PELO CNPJ
			cQuery += " AND A1_CGC = '" + ALLTRIM(cCPFCNPJ) + "' "
		ENDIF
		
		IF Alltrim(cTelefone)<>'' .AND. Alltrim(cCPFCNPJ)<>'' // CONSULTA POR CNPJ E TELEFONE
			CDDD := SUBSTR(Alltrim(cTelefone),1,2)
			CFONE := SUBSTR(Alltrim(cTelefone),3)
			
			cQuery += " AND U5_DDD LIKE '%" + CDDD + "%' AND U5_FCOM2 = '" + CFONE + "' "
			cQuery += " AND A1_CGC = '" + ALLTRIM(cCPFCNPJ) + "' "
		ENDIF
		
         
		
		IF SELECT("TRBX")<>0
			DBSELECTAREA("TRBX")
			TRBX->(DBCLOSEAREA())
		ENDIF
		
		MEMOWRIT("URA.SQL", cQuery )
				
		TCQUERY cQuery NEW ALIAS TRBX

		DBSELECTAREA("TRBX")
		TRBX->(DBGOTOP())
		
		IF TRBX->(EOF()) //SE NÃO HOUVER NADA A RETORNAR
			aAdd(aDadoCl ,{"2",{Nil},{Nil},{Nil},{Nil},{Nil},{Nil},{Nil}})
			
		ELSE
			// montagem de retorno de uma lista de objetos JSON
			WHILE !TRBX->(EOF())
				Wrk_Vend  := TRBX->A1_VEND
				Wrk_Ramal := TRBX->A3_XRAMAL
				
				IF !EMPTY(TRBX->A1_XVDSUBS)
					Wrk_Vend := TRBX->A1_XVDSUBS
					Wrk_Ramal := POSICIONE("SA3",1,XFILIAL("SA3")+TRBX->A1_VEND,"A3_XRAMAL")
				ENDIF
				
				aAdd(aDadoCl,{"1",TRBX->A1_VEND,TRBX->A1_XGRPVEN,Wrk_Ramal,TRBX->A1_CGC,TRBX->A1_NOME,TRBX->A1_MUN,TRBX->A1_EST})
				
				TRBX->(DBSKIP())
			END
		ENDIF
	Endif
	
Return aDadoCl
