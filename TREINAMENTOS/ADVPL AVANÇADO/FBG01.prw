User Function FBG01()
 
Local xAutoCab	:= {}

AADD(xAutoCab,{"A1_FILIAL"	,xFilial("SA1") 	, Nil})
AADD(xAutoCab,{"A1_COD"  	, "000002"       	, Nil})
AADD(xAutoCab,{"A1_LOJA" 	, "01"           	, Nil})
AADD(xAutoCab,{"A1_NOME" 	, "TESTE-000001" 	, Nil})  
AADD(xAutoCab,{"A1_NREDUZ" 	, "TESTE" 			, Nil})
AADD(xAutoCab,{"A1_END" 	, "RUA TESTE" 		, Nil})
AADD(xAutoCab,{"A1_TIPO" , "R" 					, Nil})
AADD(xAutoCab,{"A1_EST" , "MG" 					, Nil})
AADD(xAutoCab,{"A1_MUN" , "BELO HORIZONTE" 		, Nil})

BeginTran()  
lMsErroAuto := .F.   
MsExecAuto({|x,y| MATA030(x,y)}, xAutoCab, 3)

If lMsErroAuto      
  DisarmTransaction()   
  Alert("Ocorreu um Erro!!!")
Else
	MsgInfo("Atualizado com Sucesso!!")     
  EndTran()   
EndIf

MsUnlockAll()

Return