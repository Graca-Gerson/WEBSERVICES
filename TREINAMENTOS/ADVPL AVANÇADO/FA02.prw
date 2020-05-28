#include "protheus.ch"
#include "topconn.ch"
 

User Function FA02()

Local cAlias := GetNextAlias()
Local cSql   := ""

cSql :=	" Select A2_COD,    							"+;
		"        A2_LOJA,      							"+;
		"        A2_NREDUZ, 							"+;
		"        A2_EST,    							"+;
		"        A2_MSBLQL  							"+;
		"FROM " + RetSQLName("SA2")+"					"+;
		"WHERE A2_FILIAL = '" + xFilial('SA2') + "'		"+;
		"AND D_E_L_E_T_ <> '*'  						"

cSql := ChangeQuery(cSql)

TCQUERY ( cSql ) ALIAS ( cAlias ) NEW

MsgInfo((cAlias)->A2_NREDUZ)

Return