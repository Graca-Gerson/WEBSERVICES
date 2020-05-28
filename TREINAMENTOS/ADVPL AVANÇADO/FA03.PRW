#include "protheus.ch"
#include "topconn.ch"
 

User Function FA03()

Local cAliasFor := GetNextAlias()
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

dbUseArea( .T.,"TOPCONN", TCGENQRY(,,cSql),(cAliasFor), .F., .T.)


MsgInfo((cAliasFor)->A2_NREDUZ)


Return