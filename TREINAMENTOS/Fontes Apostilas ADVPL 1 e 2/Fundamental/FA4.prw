#Include "Protheus.ch"



User Function FA4()

Local aArea			:= GetArea()
Local cQuery  		:= ""
Local aItens		:= {}
Local cAliasQry 	:= GetNextAlias( )
Local dDataIni		:= dDataBase
 
If (Select(cAliasQry) <> 0)
	dbSelectArea(cAliasQry)
	(cAliasQry)->(dbCloseArea())
EndIf

cQuery := 	"SELECT A1_COD,											"+; 
			"		A1_LOJA,										"+;
			"		A1_NREDUZ 										"+;
			"FROM " + RetSqlName("SA1") + " 						"+;
			"WHERE	A1_ULTCOM >='"+DTOS(dDataIni)+"'				"+;
			"		AND D_E_L_E_T_ <>'*'							"+;
			"		AND A1_FILIAL = '"+xFilial("SA1")+"'	 		"
			
cQuery := ChangeQuery( cQuery )

DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAliasQry,.F., .T.)

If Empty((cAliasQry)->A1_COD)
	MsgAlert("Cliente novo.")
Else
	MsgAlert("Cliente: " + AllTrim((cAliasQry)->A1_NREDUZ))
EndIf

RestArea(aArea)

Return