User Function TForca()

Local aItens	:= ListaProdutos()

Private cImprime:= ""

nQuantidade := Len(aItens)
nItens := 0

While nItens < nQuantidade
  nItens++	
  If aItens [nItens,03] == "1"
	LOOP	
 EndIf
  IMPRIME(AllTrim(aItens [nItens,01]) + " - " + AllTrim(aItens [nItens,02]) )
EndDo

MSGINFO("Produtos: " + cImprime)

Return


Static Function ListaProdutos()

Local aArea			:= GetArea()
Local cQuery  		:= ""
Local aItens		:= {}
Local cAliasQry 	:= GetNextAlias( )

If (Select(cAliasQry) <> 0)
	dbSelectArea(cAliasQry)
	(cAliasQry)->(dbCloseArea())
EndIf

cQuery :=	"SELECT B1_COD,											"+;
			"		B1_DESC,										"+;
			"		B1_MSBLQL 										"+;
			"FROM " + RetSqlName("SB1") + "  						"+;
			"WHERE 	D_E_L_E_T_ <> '*'								"+;
			"		AND B1_FILIAL = '"+xFilial("SB1")+"'	 		"
			
cQuery := ChangeQuery( cQuery )

DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAliasQry,.F., .T.)

While (cAliasQry)->(!Eof())

	Aadd(aItens,{	(cAliasQry)->B1_COD,(cAliasQry)->B1_DESC,(cAliasQry)->B1_MSBLQL})
	
	(cAliasQry)->(DbSkip())
EndDo

RestArea(aArea)

Return aItens


Static Function IMPRIME(cPrd)

cImprime += cPrd + ", "
	
Return 