#include "PROTHEUS.CH"
#INCLUDE "APWEBEX.CH"
#define MATRIPLS "@R !!!!.!!!!.!!!!!!.!!-!"
#define GUIAPLS "@R !!!!.!!!!.!!.!!!!!!!!"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PLGERAPROT ³ Autor ³ Totvs		         ³ Data ³ 28.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Gera Protocolo com a Guias do Periodo informado.              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function PLGERAPROT(cRda, dDtDe, dDtAte, cUserCode)

Local aRet 		:= {.T.,"",0}
Local nX, nBD5	:= 0
Local cSQL 		:= ""
Local aAlias	:= {"BD5BE4->(TRB_ORIGEM)","'BD6'","'BD7'"}
Local cCodInt	:= PlsIntPad()
Local cNewProt 	:= GetSXENum("BXX","BXX_SEQNFS")

cSQL += "  SELECT "
cSQL += "  BD5_FILIAL AS TRB_FILIAL, "
cSQL += "  BD5_CODOPE AS TRB_CODOPE, "
cSQL += "  BD5_CODLDP AS TRB_CODLDP, "
cSQL += "  BD5_CODPEG AS TRB_CODPEG, "
cSQL += "  BD5_NUMERO AS TRB_NUMERO, "
cSQL += "  'BD5' AS TRB_ORIGEM  "
cSQL += "  FROM " + RetSQLName("BD5")
cSQL += " WHERE BD5_FILIAL = '" + xFilial("BD5") +"' "
cSQL += "   AND BD5_CODOPE = '" + cCodInt + "' "
cSQL += "   AND BD5_CODRDA = '" + cRda + "' "
cSQL += "   AND BD5_DATPRO BETWEEN '" + DTOS(dDtDe) + "' AND '"+ DTOS(dDtAte) +"' "
cSQL += "   AND BD5_SITUAC = '1' "
cSQL += "   AND BD5_FASE IN (" + GetNewPar("MV_PROTFASE","1,2,3,4") + ") "
cSQL += "   AND BD5_SEQNFS = '' "
cSQL += "   AND D_E_L_E_T_ <> '*' "

cSQL += "  UNION "

cSQL += "  SELECT "
cSQL += "  BE4_FILIAL AS TRB_FILIAL, "
cSQL += "  BE4_CODOPE AS TRB_CODOPE, "
cSQL += "  BE4_CODLDP AS TRB_CODLDP, "
cSQL += "  BE4_CODPEG AS TRB_CODPEG, "
cSQL += "  BE4_NUMERO AS TRB_NUMERO, "
cSQL += "  'BE4' AS TRB_ORIGEM  "
cSQL += "  FROM " + RetSQLName("BE4")
cSQL += " WHERE BE4_FILIAL = '" + xFilial("BE4") +"' "
cSQL += "   AND BE4_CODOPE = '" + cCodInt + "' "
cSQL += "   AND BE4_CODRDA = '" + cRda + "' "
cSQL += "   AND BE4_DATPRO BETWEEN '" + DTOS(dDtDe) + "' AND '"+ DTOS(dDtAte) +"' "
cSQL += "   AND BE4_SITUAC = '1' "
cSQL += "   AND BE4_FASE IN (" + GetNewPar("MV_PROTFASE","1,2,3,4") + ") "
cSQL += "   AND BE4_SEQNFS = '' "
cSQL += "   AND D_E_L_E_T_ <> '*' "


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa query														   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := ChangeQuery(cSQL)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"BD5BE4",.F.,.T.)

If ! BD5BE4->(Eof())

	BXX->( RecLock("BXX",.T.) )
		BXX->BXX_FILIAL := xFilial("BXX")
		BXX->BXX_DATMOV := dDataBase
		BXX->BXX_CODINT := cCodInt
		BXX->BXX_CODUSR := cUserCode
		BXX->BXX_ARQIN  := "m_" + cNewProt
		BXX->BXX_ARQOUT := ""
		BXX->BXX_SITUAC := "1" //Ativa
		BXX->BXX_FASE	:= "1" //Em Digitação
		BXX->BXX_STATUS := "4" //Manual aberto
		BXX->BXX_CODRDA := cRda
		BXX->BXX_SEQNFS := cNewProt
	BXX->( MsUnLock() )   

	BXX->(ConfirmSX8())
	aRet := {.T.,cNewProt,0}
Else
	aRet := {.F.,"Não há guias sem protocolo nesse período!",0}
	BXX->(RollBackSX8())
EndIf

While ! BD5BE4->(Eof())

	nBD5++

	For nX := 1 To Len(aAlias)
		cSQL := " UPDATE " + RetSQLName(&(aAlias[nX]))
		cSQL += " SET "   + &(aAlias[nX]) + "_SEQNFS = '" + cNewProt + "' "
		cSQL += " WHERE " + &(aAlias[nX]) + "_FILIAL = '" + BD5BE4->(TRB_FILIAL) + "' "
		cSQL += "   AND " + &(aAlias[nX]) + "_CODOPE = '" + BD5BE4->(TRB_CODOPE) + "' "
		cSQL += "   AND " + &(aAlias[nX]) + "_CODLDP = '" + BD5BE4->(TRB_CODLDP) + "' "
		cSQL += "   AND " + &(aAlias[nX]) + "_CODPEG = '" + BD5BE4->(TRB_CODPEG) + "' "
		cSQL += "   AND " + &(aAlias[nX]) + "_NUMERO = '" + BD5BE4->(TRB_NUMERO) + "' "
	    cSQL += "   AND " + &(aAlias[nX]) + "_SEQNFS = ' ' "
		cSQL += "   AND D_E_L_E_T_ <> '*' "
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Executa query														   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		TcSqlExec(cSql)
		If AllTrim( TCGetDB() ) == "ORACLE"        
			TCSQLExec("COMMIT")
		Endif
	Next nX
	
	BD5BE4->(DbSkip())
	
EndDo

BD5BE4->(DbCloseArea())

If aRet[1]
	aRet[3] := nBD5
EndIf

Return aRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PLGETGUIAS ³ Autor ³ Totvs		         ³ Data ³ 28.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna as Guias do Protocolo informado.              		 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function PLGETGUIAS(cProtocolo)

Local aCpos		:= {{"TRB_CODOPE||TRB_CODLDP||TRB_CODPEG||TRB_NUMERO","CHAVE"},{"TRB_SITUAC","TRB_SITUAC"},{"TRB_TIPGUI","TRB_TIPGUI"},{"TRB_DATPRO","TRB_DATPRO"},{"TRB_CODOPE||TRB_CODEMP||TRB_MATRIC||TRB_TIPREG||TRB_DIGITO","MATRIC"},{"TRB_NOMUSR","TRB_NOMUSR"}}
Local aRet 		:= {}
Local cSQL 		:= ""

cSQL := "SELECT "

AEval(aCpos, {|x| cSQL += StrTran(x[1],"TRB","BD5")+" AS " + x[2] + ", "})
cSQL := SubStr(cSQL, 1, Len(cSQL) - 2) //Retira a virgula final                                

cSQL += "  FROM " + RetSQLName("BD5")
cSQL += " WHERE BD5_SEQNFS = '" + cProtocolo + "' "
cSQL += "   AND D_E_L_E_T_ <> '*' "

cSQL += "UNION "

cSQL += "(SELECT "

AEval(aCpos, {|x| cSQL += StrTran(x[1],"TRB","BE4")+" AS " + x[2] + ", "})
cSQL := SubStr(cSQL, 1, Len(cSQL) - 2) //Retira a virgula final

cSQL += "  FROM " + RetSQLName("BE4")
cSQL += " WHERE BE4_SEQNFS = '" + cProtocolo + "' "
cSQL += "   AND D_E_L_E_T_ <> '*') "

cSQL += " ORDER BY TRB_DATPRO"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa query														   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := ChangeQuery(cSQL)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"BD5BE4",.F.,.T.)

If ! BD5BE4->(Eof())
	aRet := {.T.,aRet}
	AAdd(aRet[2],{})
	AAdd(aRet[2][1],"Número Guia")
	AAdd(aRet[2][1],"Situação")
	AAdd(aRet[2][1],"Tipo Guia")
	AAdd(aRet[2][1],"Dt. Evento")
	AAdd(aRet[2][1],"Matríc. Usr.")
	AAdd(aRet[2][1],"Nome Usr.")
Else
	aRet := {.F.,"N&atilde;o h&aacute; guias no protocolo " + cProtocolo + "!"}
EndIf

While ! BD5BE4->(Eof())

	AAdd(aRet[2], {})
	AEval(aCpos, {|x| AAdd(aRet[2][Len(aRet[2])], TratCpo(x[1],&("BD5BE4->(" + x[2] + ")")) ) } )
	BD5BE4->(DbSkip())
	
EndDo

BD5BE4->(DbCloseArea())

Return aRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PLGETPTABT ³ Autor ³ Totvs		         ³ Data ³ 28.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna os Protocolos em aberto.			              		 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function PLGETPTABT(cCodRDA)

Local aRet 		:= {}
Local cSQL := "SELECT BXX_SEQNFS"

cSQL += "  FROM " + RetSQLName("BXX")
cSQL += " WHERE BXX_SEQNFS <> '' "
cSQL += "   AND BXX_STATUS  = '4' "
cSQL += "   AND BXX_CODRDA  = '" + cCodRDA + "' "
cSQL += "   AND BXX_DATMOV >= '" + DToS(dDataBase-(GetNewPar("MV_PLDIXML",30))) + "' "
cSQL += "   AND D_E_L_E_T_ <> '*' "
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa query														   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := ChangeQuery(cSQL)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TRBBXX",.F.,.T.)

If ! TRBBXX->(Eof())
	aRet := {.T.,aRet}
Else
	aRet := {.F.,"N&atilde;o h&aacute; Protocolos em aberto!"}
EndIf

While ! TRBBXX->(Eof())

	AAdd(aRet[2], TRBBXX->(BXX_SEQNFS))
	TRBBXX->(DbSkip())
	
EndDo

TRBBXX->(DbCloseArea())

Return aRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PLIEGUIAPT ³ Autor ³ Totvs		         ³ Data ³ 28.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Inclui ou Exclui uma Guia de um Protocolo.		             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function PLIEGUIAPT(cGuia, cProt, cOper, cRDA)

Local aRet 		:= {.T.,""}
Local cSQL 		:= ""
Local nX 		:= 0
Local aAlias	:= {"BD5","BD6","BD7","BE4"}
Local lInc		:= cOper == "1"
Local cSeqNfs	:= ""
Local cSituac	:= ""


BEA->(DbSetOrder(1))

If ! BEA->(DbSeek(xFilial("BEA")+cGuia))

	Return {.F., "Guia n&atilde;o encontrada(" + cGuia + ")."}

Else

	If BEA->BEA_CODRDA <> cRDA
	
		Return {.F., "A Guia " + cGuia + " n&atilde;o pertence &agrave; RDA logada(" + cRDA + ")."}
		
	EndIf


	If BEA->BEA_TIPGUI == "03"
		BE4->(DbSetOrder(1))
		If BE4->(DbSeek(xFilial("BE4")+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI)))
			cAlias	:= "BE4"
			cSeqNfs	:= BE4->BE4_SEQNFS
			cSituac	:= BE4->BE4_SITUAC
		Else
			Return {.F., "Guia de internação relacionada n&atilde;o encontrada(" + cGuia + ")."}
		EndIf
	Else
		BD5->(DbSetOrder(1))
		If BD5->(DbSeek(xFilial("BD5")+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI)))
			cAlias	:= "BD5"
			cSeqNfs	:= BD5->BD5_SEQNFS
			cSituac	:= BD5->BD5_SITUAC
		Else
			Return {.F., "Guia relacionada n&atilde;o encontrada(" + cGuia + ")."}
		EndIf
	EndIf
	
	If cSituac <> "1" .And. lInc
		Return {.F., "A Guia informada n&atilde;o pode ser inclu&iacute;da pois encontra-se " + IIf(cSituac=="2","Bloqueada.","Cancelada.")}
	EndIf

	If lInc .And. !Empty(cSeqNfs)

		Return {.F., "A Guia informada pertence ao Protocolo " + cSeqNfs + ". Realize a exclus&atilde;o primeiro."}

	ElseIf (!lInc) .And. cSeqNfs <> cProt

		If ! Empty(cSeqNfs)
			Return {.F., "A Guia informada n&atilde;o pertence ao Protocolo " +cProt + ", e sim ao " + cSeqNfs + "."}
		Else
			Return {.F., "A Guia informada n&atilde;o possui nenhum Protocolo cadastrado."}
		EndIf

	EndIf

EndIf
	
For nX := 1 To Len(aAlias)

	cSQL := " UPDATE " + RetSQLName(aAlias[nX])
	cSQL += " SET "   + aAlias[nX] + "_SEQNFS = '" + IIf(lInc,cProt," ")+ "' "
	cSQL += " WHERE " + aAlias[nX] + "_FILIAL = '" + &(cAlias+"->("+cAlias+"_FILIAL)") + "' "
	cSQL += "   AND " + aAlias[nX] + "_CODOPE = '" + &(cAlias+"->("+cAlias+"_CODOPE)") + "' "
	cSQL += "   AND " + aAlias[nX] + "_CODLDP = '" + &(cAlias+"->("+cAlias+"_CODLDP)") + "' "
	cSQL += "   AND " + aAlias[nX] + "_CODPEG = '" + &(cAlias+"->("+cAlias+"_CODPEG)") + "' "
	cSQL += "   AND " + aAlias[nX] + "_NUMERO = '" + &(cAlias+"->("+cAlias+"_NUMERO)") + "' "
    cSQL += "   AND " + aAlias[nX] + "_SEQNFS = '" + IIf(!lInc,cProt," ")+ "' "
	cSQL += "   AND D_E_L_E_T_ <> '*' "
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa query														   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TcSqlExec(cSql)
	If AllTrim( TCGetDB() ) == "ORACLE"        
		TCSQLExec("COMMIT")
	Endif	
Next nX

aRet[2] := "A Guia " + cGuia + " foi " + IIf(lInc,"inclu&iacute;da no ","exclu&iacute;da do ") + "Protocolo " + cProt + "!"

Return aRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PLENCRPROT ³ Autor ³ Totvs		         ³ Data ³ 28.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Encerra um Protocolo.					              		 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function PLENCRPROT(cProtocolo)

Local aRet 		:= {}
Local cSQL 		:= ""

cSQL := "SELECT BXX_CODUSR, R_E_C_N_O_ "
cSQL += "  FROM " + RetSQLName("BXX")
cSQL += " WHERE BXX_SEQNFS = '" + cProtocolo + "' "
cSQL += "   AND D_E_L_E_T_ <> '*' "
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa query														   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := ChangeQuery(cSQL)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TRBBXX",.F.,.T.)

If TRBBXX->(RecCount()) > 1
	aRet := {.F.,"Protocolo duplicado. N&atilde;o ser&aacute; poss&iacute;vel encerr&aacute;-lo!"}
EndIf

If ! TRBBXX->(Eof())

	aRet := {.T.,{}}
	
	BXX->(DbSetOrder(1))
	BXX->(DbGoTo(TRBBXX->(R_E_C_N_O_)))
	If BXX->BXX_STATUS == "4" //Manual Aberto
		BXX->( RecLock("BXX",.F.) )
			BXX->BXX_STATUS := "5" //Encerrado
		BXX->( MsUnLock() )
    EndIf

	AAdd(aRet[2],PlsIntPad())
	AAdd(aRet[2],BXX->BXX_ARQIN)
	AAdd(aRet[2],BXX->BXX_DATMOV)
    
	cSQL := "SELECT Count(BD5_SEQNFS) QTDTOT, "
	cSQL += "	Count(Case When BD5_FASE = '1' Then BD5_SEQNFS END) QTDF1, "
	cSQL += "	Count(Case When BD5_FASE = '2' Then BD5_SEQNFS END) QTDF2, "
	cSQL += "	Count(Case When BD5_FASE = '3' Then BD5_SEQNFS END) QTDF3, "
	cSQL += "	Sum(BD5_VLRBPR) VALINF, "
	cSQL += "	Sum(BD5_VLRGLO) VALGLO, "
	cSQL += "	Sum(BD5_VLRPAG) VALTOT, "
	cSQL += "	Sum(Case When BD5_FASE = '3' Then BD5_VLRPAG END) VALF3 "
	cSQL += "		FROM " + RetSQLName("BD5")
	cSQL += "		WHERE BD5_SEQNFS = '" + cProtocolo + "' "
	cSQL += "		AND D_E_L_E_T_ <> '*' "
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa query BD5													   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSQL := ChangeQuery(cSQL)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TRBBD5",.F.,.T.)

	cSQL := "SELECT Count(BE4_SEQNFS) QTDTOT, "
	cSQL += "	Count(Case When BE4_FASE = '1' Then BE4_SEQNFS END) QTDF1, "
	cSQL += "	Count(Case When BE4_FASE = '2' Then BE4_SEQNFS END) QTDF2, "
	cSQL += "	Count(Case When BE4_FASE = '3' Then BE4_SEQNFS END) QTDF3, "
	cSQL += "	Sum(BE4_VLRBPR) VALINF, "
	cSQL += "	Sum(BE4_VLRGLO) VALGLO, "
	cSQL += "	Sum(BE4_VLRPAG) VALTOT, "
	cSQL += "	Sum(Case When BE4_FASE = '3' Then BE4_VLRPAG END) VALF3 "
	cSQL += "		FROM " + RetSQLName("BE4")
	cSQL += "		WHERE BE4_SEQNFS = '" + cProtocolo + "' "
	cSQL += "		AND D_E_L_E_T_ <> '*' "
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa query BE4													   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSQL := ChangeQuery(cSQL)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TRBBE4",.F.,.T.)

	If ! TRBBD5->(Eof())
		AAdd(aRet[2],TRBBD5->(QTDTOT))      //QtdAmbul
		AAdd(aRet[2],0)      				//QtdInter
		AAdd(aRet[2],TRBBD5->(VALINF))      //VlrInfor
		AAdd(aRet[2],TRBBD5->(VALGLO))      //VlrGlosa
		AAdd(aRet[2],TRBBD5->(QTDTOT))      //QtdGuias
		AAdd(aRet[2],TRBBD5->(QTDF3) )      //QtdG_Pro
		AAdd(aRet[2],TRBBD5->(QTDF2) )      //QtdG_Cnf
		AAdd(aRet[2],TRBBD5->(QTDF1) )      //QtdG_Dig
		AAdd(aRet[2],TRBBD5->(VALTOT))      //VlrGuias
		AAdd(aRet[2],TRBBD5->(VALF3) )		//VlrG_Pro
		AAdd(aRet[2],TRBBXX->BXX_CODUSR)	//Resp
	EndIf
	
	TRBBD5->(DbCloseArea())

	If ! TRBBE4->(Eof())
		aRet[2][5] := TRBBE4->(QTDTOT)      //QtdInter
		aRet[2][6] += TRBBE4->(VALINF)      //VlrInfor
		aRet[2][7] += TRBBE4->(VALGLO)      //VlrGlosa
		aRet[2][8] += TRBBE4->(QTDTOT)      //QtdGuias
		aRet[2][9] += TRBBE4->(QTDF3)       //QtdG_Pro
		aRet[2][10]+= TRBBE4->(QTDF2)       //QtdG_Cnf
		aRet[2][11]+= TRBBE4->(QTDF1)       //QtdG_Dig
		aRet[2][12]+= TRBBE4->(VALTOT)      //VlrGuias
		aRet[2][13]+= TRBBE4->(VALF3) 		//VlrG_Pro
	EndIf
	
	TRBBE4->(DbCloseArea())
	
Else
	aRet := {.F.,"Protocolo n&atilde;o encontrado(" + cProtocolo + ")!"}
EndIf

TRBBXX->(DbCloseArea())

Return aRet 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TratCpo	  ³ Autor ³ Totvs		         ³ Data ³ 12.07.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Tratamentos especificos para exibicao de campos         		 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function TratCpo(cTit, xCont)

Local xRet

Do Case

	Case cTit == "TRB_CODOPE||TRB_CODLDP||TRB_CODPEG||TRB_NUMERO"
		BEA->(DbSetOrder(12))//BEA_FILIAL+BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI+BEA_ORIMOV
		If BEA->(DbSeek(xFilial("BEA")+xCont))
			xRet := Transform(BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT),GUIAPLS)
		Else
			xRet := "*Guia digitada pela Operadora."
		EndIf
	Case cTit == "TRB_DATPRO"
		xRet := DToC(SToD(xCont))
	Case cTit == "TRB_SITUAC"
		Do Case
			Case xCont == "1"
				xRet := "Ativa"
			Case xCont == "2"
				xRet := "Cancelada"
			Case xCont == "3"
				xRet := "Bloqueada"
			OtherWise
    			xRet := xCont	
		EndCase
	Case cTit == "TRB_TIPGUI"
		Do Case
			Case xCont == "01"
				xRet := "Consulta"
			Case xCont == "02"
				xRet := "Serviço"
			Case xCont == "03"
				xRet := "Internação"
			Case xCont == "04"
				xRet := "Reembolso"
			OtherWise
    			xRet := xCont	
		EndCase
	Case cTit == "TRB_CODOPE||TRB_CODEMP||TRB_MATRIC||TRB_TIPREG||TRB_DIGITO"
		xRet := Transform(xCont,MATRIPLS)
	OtherWise
    	xRet := xCont
EndCase

Return xRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PLGETBENEF ³ Autor ³ Totvs		         ³ Data ³ 19.07.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Busca beneficiario de uma Guia.			              		 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function PLGETBENEF(cGuia)

Local aRet := {.F.,""}

BEA->(DbSetOrder(1))

If BEA->(DbSeek(xFilial("BEA")+cGuia))
	aRet := {.T.,BEA->BEA_NOMUSR}
Else
	aRet[2] := "Guia nao encontrada(" + cGuia + ")."
EndIf	

Return aRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PPLMNTPT   ³ Autor ³ Totvs			     ³ Data ³ 27.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Manutencao de Protocolos										 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Web Function PPLMNTPT()

LOCAL cHtml	:= ""

WEB EXTENDED INIT cHtml START "InSite"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chama o formulario													   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Do Case

	Case HttpGet->cF == "1" //Criar Protocolo
		cHtml += ExecInPage( "PPLPTCRI" )
	Case HttpGet->cF == "2" //Conferir Guias
		cHtml += ExecInPage( "PPLPTLST" )
	Case HttpGet->cF == "3" //Incluir/Excluir Guia
		cHtml += ExecInPage( "PPLPTMNT" )
	Case HttpGet->cF == "4" //Encerrar Protocolo
		cHtml += ExecInPage( "PPLPTFIM" )
	Case HttpGet->cF == "5" //Encerrar Protocolo
		cHtml += ExecInPage( "PPLPROREL" )		

EndCase

WEB EXTENDED END
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Fim da rotina														   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return cHtml

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PPLPTGRV	  ³ Autor ³ Totvs				 ³ Data ³ 27.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Gera e grava o novo Protocolo								 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Web Function PPLPTGRV()

LOCAL oObj
LOCAL cHtml		:= ""
LOCAL cTitulo	:= ""
LOCAL cTexto	:= ""
LOCAL lRet		:= .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WEB EXTENDED INIT cHtml START "InSite"

If Len(HttpSession->RDAVIEW) > 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Web Service															   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oObj := WSPLSPROT():New() 
	WsChgURL( @oObj, "PLSPROT.APW" )    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Obj																	   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oObj:cUSERCODE 	:= "MSALPHA"                 
	oObj:cRDA 		:= HttpSession->RDAVIEW[1]:CCODE
	oObj:dDtDe		:= CToD(HttpGet->cDtDe)
	oObj:dDtAte		:= CToD(HttpGet->cDtAte)
	oObj:cUsrPortal	:= HttpSession->USR_INFO[1]:CUSERCODE
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa metodo														   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lRet := oObj:CRIAPROT()

	If lRet
		cTexto := oObj:cCRIAPROTRESULT
	Else
		cTexto := PWSGetWSError( "" )
	EndIf
	
Else

	lRet	:= .F.
	cTexto	:= "O Operador logado nao possui RDA cadastrada."

EndIf

If lRet
	cTitulo := "Sucesso"
	cTexto	:= "Protocolo gerado: " + cTexto
Else
	cTitulo := "Atenção"
EndIf

HttpSession->cTit := cTitulo
HttpSession->cTex := cTexto
HttpSession->cVlt := "W_PPLMNTPT.APW?cF=1"
	
WEB EXTENDED END

Return cHtml

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PPLPTCFR	  ³ Autor ³ Totvs				 ³ Data ³ 27.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Confere Guias												 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Web Function PPLPTCFR()

LOCAL oObj
LOCAL cHtml		:= ""
LOCAL cTitulo	:= ""
LOCAL cTexto	:= ""
LOCAL aGuias	:= {}
LOCAL lRet		:= .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WEB EXTENDED INIT cHtml START "InSite"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web Service															   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oObj := WSPLSPROT():New() 
WsChgURL( @oObj, "PLSPROT.APW" )    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Obj																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oObj:cUSERCODE 	:= "MSALPHA"                 
oObj:cCodProt	:= HttpGet->cPt
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa metodo														   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lRet := oObj:LSTGUIAS()

If lRet
	aGuias 	:= AClone(oObj:OWSLSTGUIASRESULT:OWSSCPOGUIA)
	cTitulo := "Protocolo " + HttpGet->cPt + " - " + HttpSession->RDAVIEW[1]:CNAME + "(" + HttpSession->RDAVIEW[1]:CCODE + ")"
	cTexto	:= ParseGuias(aGuias)
Else
	cTitulo := "Atenção"
	cTexto := PWSGetWSError( "" )
EndIf

HttpSession->cTit := cTitulo
HttpSession->cTex := cTexto
HttpSession->cVlt := "W_PPLMNTPT.APW?cF=2"

WEB EXTENDED END

Return cHtml

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PPLPTIEG	  ³ Autor ³ Totvs				 ³ Data ³ 27.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Inclui ou Exclui Guias										 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Web Function PPLPTIEG()

LOCAL oObj
LOCAL cHtml		:= ""
LOCAL cTitulo	:= ""
LOCAL cTexto	:= ""
LOCAL lRet		:= .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WEB EXTENDED INIT cHtml START "InSite"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web Service															   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oObj := WSPLSPROT():New() 
WsChgURL( @oObj, "PLSPROT.APW" )    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Obj																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oObj:cUSERCODE 	:= "MSALPHA"                 
oObj:cCodGuia	:= HttpGet->cGuia
oObj:cCodProt	:= HttpGet->cPt
oObj:cTpOper	:= HttpGet->cTp
oObj:cRda		:= HttpSession->RDAVIEW[1]:CCODE
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa metodo														   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lRet := oObj:INEXGUIPT()

If lRet
	cTexto := oObj:CINEXGUIPTRESULT
Else
	cTexto := PWSGetWSError( "" )
EndIf

If lRet
	cTitulo := "Sucesso"
Else
	cTitulo := IIf(HttpGet->cTp=="1","Inclus&atilde;o n&atilde;o efetuada!","Exclus&atilde;o n&atilde;o efetuada!")
EndIf

HttpSession->cTit := cTitulo
HttpSession->cTex := cTexto
HttpSession->cVlt := "W_PPLMNTPT.APW?cF=3"
	
WEB EXTENDED END

Return cHtml

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PPLPTEND	  ³ Autor ³ Totvs				 ³ Data ³ 27.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Encerra Protocolo								 			 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Web Function PPLPTEND()

LOCAL oObj
LOCAL cHtml		:= ""
LOCAL cTitulo	:= ""
LOCAL cTexto	:= ""
LOCAL aRelat	:= {}
LOCAL lRet		:= .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WEB EXTENDED INIT cHtml START "InSite"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web Service															   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oObj := WSPLSPROT():New() 
WsChgURL( @oObj, "PLSPROT.APW" )    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Obj																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oObj:cUSERCODE 	:= "MSALPHA"                 
oObj:cCodProt	:= HttpGet->cProt
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa metodo				  										   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lRet := oObj:ENCRPROT()

If lRet
	aRelat 	:= {}
	AAdd(aRelat,HttpSession->RDAVIEW[1]:CNAME)
	AAdd(aRelat,HttpSession->RDAVIEW[1]:CCODE)
	AAdd(aRelat,oObj:OWSENCRPROTRESULT:COperadora)
	AAdd(aRelat,oObj:OWSENCRPROTRESULT:CNomeArq)
	AAdd(aRelat,DToC(oObj:OWSENCRPROTRESULT:DDtEnvio))
	AAdd(aRelat,CValToChar(oObj:OWSENCRPROTRESULT:NQtdAmbul))
	AAdd(aRelat,CValToChar(oObj:OWSENCRPROTRESULT:NQtdInter))
	AAdd(aRelat,oObj:OWSENCRPROTRESULT:NVlrInfo)
	AAdd(aRelat,oObj:OWSENCRPROTRESULT:NVlrGlosa)
	AAdd(aRelat,{"Mensagem","Total"})
	AAdd(aRelat,{"Contas Apresentadas",oObj:OWSENCRPROTRESULT:NQTDGUIAS})
	AAdd(aRelat,{"Qtd. Guias Prontas",oObj:OWSENCRPROTRESULT:NQTDG_PRO})
	AAdd(aRelat,{"Qtd. Guias em Digita&ccedil;&atilde;o",oObj:OWSENCRPROTRESULT:NQTDG_DIG})
	AAdd(aRelat,{"Qtd. Guias em Confer&ecirc;ncia",oObj:OWSENCRPROTRESULT:NQTDG_CNF})
	AAdd(aRelat,{"Valor Total",oObj:OWSENCRPROTRESULT:NVLRGUIAS})
	AAdd(aRelat,{"Valor Total de Guias Prontas",oObj:OWSENCRPROTRESULT:NVLRG_PRO})
	AAdd(aRelat,{"Respons&aacute;vel",oObj:OWSENCRPROTRESULT:CRESP})
	cTitulo := '<table border="0" width="620">'
	cTitulo += '<td align="left" width="30%">Protocolo [' + HttpGet->cProt + ']</td>'
	cTitulo += '<td align="right" width="70%"><img src="' + "Http://" + GetEnvHost() + "/" + GetPrtSkin() + "/logo_capa_lote.jpg" + '"></td>'
	cTitulo += '</table>'
	cTexto	:= ParseLote(aRelat)
Else
	cTitulo := "Atenção"
	cTexto := PWSGetWSError( "" )
EndIf

HttpSession->cTit := cTitulo
HttpSession->cTex := cTexto
HttpSession->cVlt := "W_PPLMNTPT.APW?cF=4"

cHtml += "true"

WEB EXTENDED END

Return cHtml

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ParseGuias  ³ Autor ³ Totvs				 ³ Data ³ 27.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Gera uma Tabela em HTML a partir do Objeto de guias		 	 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ParseGuias(aGuias)

Local cHtml		:= ""
Local nX, nY	:= 0

If Len(aGuias) <= 1
	Return ""
Else
	cHtml += '<table width="754" border="0px" cellpadding="0" cellspacing="0">' + Chr(13) + Chr(10)
EndIf

For nX := 1 To Len(aGuias)

	If nX == 1
		cHtml += '  <tr height="20" class="Cabecalho">' + Chr(13) + Chr(10)
	Else
		cHtml += '  <tr height="20" class="Cabecalho">' + Chr(13) + Chr(10)
	EndIf

    For nY := 1 To Len(aGuias[nX]:OWSSTRUGUIA:CSTRING)
    
    	If nX == 1
			cHtml += '<th class="Linha"><span>&nbsp;</span></th>' + Chr(13) + Chr(10)
			cHtml += '<th align="left" class="Linha"><span>' + aGuias[nX]:OWSSTRUGUIA:CSTRING[nY] + '</span></th>' + Chr(13) + Chr(10)
    	Else
			cHtml += '<th class="Linha"><span>&nbsp;</span></th>' + Chr(13) + Chr(10)
	    	cHtml += '<TD align="left" class="Cabecalho">' + aGuias[nX]:OWSSTRUGUIA:CSTRING[nY] + '</TD>' + Chr(13) + Chr(10)
	    EndIf
    Next nY

	cHtml += "</TR>" + Chr(13) + Chr(10)

Next nX

cHtml += '</table>' + Chr(13) + Chr(10)

Return cHtml

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ParseLote   ³ Autor ³ Totvs				 ³ Data ³ 27.06.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Gera uma Tabela em HTML a partir do Array de Capa de Lote 	 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ParseLote(aCpLote)

Local cHtml		:= ""
Local nX	:= 0

If Len(aCpLote) < 1
	Return ""
EndIf

cHtml += '<table border ="0" width=400 cellspacing="5">' + Chr(13) + Chr(10)
cHtml += '<tr>' + Chr(13) + Chr(10)
cHtml += '<td>Raz&atildeo Social:</td>' + Chr(13) + Chr(10)
cHtml += '<td colspan="5" style="border-collapse: collapse; border-bottom: 1px solid #000000">'
cHtml += aCpLote[1]
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '</tr>' + Chr(13) + Chr(10)
cHtml += '<tr>' + Chr(13) + Chr(10)
cHtml += '<td height=50 valign="bottom">Prestador:</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 valign="bottom" style="border-collapse: collapse; border-bottom: 1px solid #000000">'
cHtml += aCpLote[2]
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '<td>' + Chr(13) + Chr(10)
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 valign="bottom">Operadora:</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 colspan="2" valign="bottom" style="border-collapse: collapse; border-bottom: 1px solid #000000">'
cHtml += aCpLote[3]
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '</tr>' + Chr(13) + Chr(10)
cHtml += '<tr>' + Chr(13) + Chr(10)
cHtml += '<td height=50 valign="bottom">Nome Arquivo:</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50  colspan="2" valign="bottom" style="border-collapse: collapse; border-bottom: 1px solid #000000">'
cHtml += aCpLote[4]
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 valign="bottom" colspan="2">Dt de Envio:</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 valign="bottom" style="border-collapse: collapse; border-bottom: 1px solid #000000">'
cHtml += aCpLote[5]
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '</tr>' + Chr(13) + Chr(10)
cHtml += '<tr>' + Chr(13) + Chr(10)
cHtml += '<td height=50 colspan="2" valign="bottom">Qtde. Ambulatorio:</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 align="center" valign="bottom" style="border-collapse: collapse; border-bottom: 1px solid #000000">'
cHtml += aCpLote[6]
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 colspan="2" valign="bottom">Qtde. Internado:</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 align="center" valign="bottom" style="border-collapse: collapse; border-bottom: 1px solid #000000">'
cHtml += aCpLote[7]
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '</tr>' + Chr(13) + Chr(10)
cHtml += '<tr>' + Chr(13) + Chr(10)
cHtml += '<td height=50 colspan="2" valign="bottom">Valor Informado:</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 valign="bottom" style="border-collapse: collapse; border-bottom: 1px solid #000000">'
cHtml += 'R$' + AllTrim(Transform(IIf(aCpLote[8]==0,0.00,aCpLote[8]),"@E 999,999,999.99"))
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 colspan="2" valign="bottom">Valor Glosado:</td>' + Chr(13) + Chr(10)
cHtml += '<td height=50 align="center" valign="bottom" style="border-collapse: collapse; border-bottom: 1px solid #000000">'
cHtml += 'R$' + AllTrim(Transform(IIf(aCpLote[9]==0,0.00,aCpLote[8]),"@E 999,999,999.99"))
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '</td>' + Chr(13) + Chr(10)
cHtml += '</tr>' + Chr(13) + Chr(10)
cHtml += '</table><br>' + Chr(13) + Chr(10)

cHtml += '<table border ="1" width=600>' + Chr(13) + Chr(10)

cHtml += '<TD align="center" width=80%>' + IIf(Type("aCpLote[11][1]")<>"C",CValToCHar(aCpLote[10][1]),aCpLote[11][1]) + '</TD>' + Chr(13) + Chr(10)
cHtml += '<TD align="center" width=20%>' + IIf(Type("aCpLote[11][2]")<>"C",CValToCHar(aCpLote[10][2]),aCpLote[11][2]) + '</TD>' + Chr(13) + Chr(10)

For nX := 11 To Len(aCpLote)

	cHtml += '<tr>' + Chr(13) + Chr(10)
   	cHtml += '<TD align="left" width=80%>' + IIf(Type("aCpLote[nX][1]")<>"C",CValToCHar(aCpLote[nX][1]),aCpLote[nX][1]) + '</TD>' + Chr(13) + Chr(10)
   	cHtml += '<TD align="right" width=20%>' + AllTrim(IIf(Type("aCpLote[nX][2]")<>"C",IIf("Val" $ aCpLote[nX][1],"R$" + AllTrim(Transform(aCpLote[nX][2],"@E 999,999,999.99")),CValToCHar(aCpLote[nX][2])),aCpLote[nX][2])) + '</TD>' + Chr(13) + Chr(10)
	cHtml += '</tr>' + Chr(13) + Chr(10)

Next nX

cHtml += '</table>' + Chr(13) + Chr(10)

cHtml += '<BR><BR><BR>' + Chr(13) + Chr(10)

cHtml += '<table border="0" width="600">'
cHtml += '<tr>'
cHtml += '<td align="center" width="40%">___/___/______</td>'
cHtml += '<td align="center" width="60%">______________________________</td>'
cHtml += '</tr>'
cHtml += '<tr>'
cHtml += '<td align="center" width="40%">Data</td>'
cHtml += '<td align="center" width="60%">Assinatura</td>'
cHtml += '</tr>'
cHtml += '</table>'

cHtml += '<BR><BR><BR>' + Chr(13) + Chr(10)

cHtml += '<input type="button" name="button1" value="imprimir" class="Botoes" onClick="javaScript:window.print()">'

Return cHtml

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PPLPTEXB	  ³ Autor ³ Totvs				 ³ Data ³ 10.07.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exibe pagina simples								 			 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Web Function PPLPTEXB()

LOCAL cHtml	:= ""
LOCAL cTitulo	:= ""
LOCAL cTexto	:= ""
LOCAL cVolta	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WEB EXTENDED INIT cHtml START "InSite"

 cTitulo	:= HttpSession->cTit
 cTexto	:= HttpSession->cTex
 cVolta	:= HttpSession->cVlt

cHtml += PPLSALERT( "", cTitulo, cTexto, cVolta )

WEB EXTENDED END

Return cHtml
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PPLEXE673   ³ Autor ³ Alexander Santos     ³ Data ³ 07.03.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Executa o relatorio 673 extrato da rda						 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Web Function PPLPROT673()
LOCAL oObj
LOCAL cHtml := ""     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WEB EXTENDED INIT cHtml START "InSite"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria variavel de sessao												   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ValType(HttpPost->cRda) <> 'U'
	HttpSession->cRDARel := SubStr( HttpPost->cRda,1,At('|',HttpPost->cRda)-1 )
	HttpSession->cCodLoc := SubStr( HttpPost->cRda,At('|',HttpPost->cRda)+1 )
	HttpSession->cProtRel:= Iif(VaLType(HttpPost->cProt) <> "U",PadL(HttpPost->cProt,10,"0"),"")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web Service															   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oObj := WSPLSRELT():New() 
WsChgURL( @oObj, "PLSRELT.APW" )    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Obj																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oObj:cUSERCODE 	:= "MSALPHA"                 
oObj:cRDA 		:= HttpSession->cRdaRel
oObj:cCodLoc    := HttpSession->cCodLoc
oObj:cAno		:= ""
oObj:cMes 		:= ""
oObj:cProt 		:= HttpSession->cProtRel
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa metodo														   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If oObj:REL673S()
	FT_FUse( oObj:cREL673SRESULT )
	FT_FGotop()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Todas as linhas														   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	    
	HttpSession->aMatRel := {}
	While ( !FT_FEof() )       
	    cRelato := FT_FREADLN()
	    If At("RPC",cRelato) == 0
			AaDd( HttpSession->aMatRel, StrTran(cRelato ," ","&nbsp;") + CRLF  )
		EndIf	
		FT_FSkip()
	EndDo                                                                       
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fecha o arquivo														   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	    
	FT_FUse()
Else
	Return PPLSALERT( "", "Atenção", "", "W_PPLS673PA.APW" )
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define rotina														   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
HttpSession->cRotRel := "W_PPLEXE673.APW"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chama o formulario													   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cHtml += ExecInPage( "PPLMOSREL" )

WEB EXTENDED END
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Fim da rotina														   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return cHtml

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PPLGTBEN	  ³ Autor ³ Totvs				 ³ Data ³ 18.07.2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna nome do Benefeciario de determinada Guia	 			 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Web Function PPLGTBEN

LOCAL oObj
LOCAL cRet := ""
LOCAL cHtml := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WEB EXTENDED INIT cHtml START "InSite"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Web Service															   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oObj := WSPLSPROT():New() 
WsChgURL( @oObj, "PLSPROT.APW" )    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Obj																	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oObj:cCodGuia	:= HttpGet->cGuia
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa metodo				  										   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If oObj:GETBENEF()

	cRet +=  "true|"
	cRet +=  IIf(HttpGet->cTp == "1","inclus&atilde;o|","exclus&atilde;o|")
	cRet +=  AllTrim(HttpGet->cGuia) + "|"
	cRet +=  AllTrim(oObj:cGETBENEFRESULT)

Else

	cRet +=  "false|"
	cRet +=  PWSGetWSError( "" )

EndIf

WEB EXTENDED END

Return cRet