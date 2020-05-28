#include "Totvs.ch"
#include "Totvswebsrv.ch"

WsService TCliente description "Treinamento do WebService para a Criacao Cliente"

//Metodo para inclusão de Clientes
WSMETHOD GRAVACLIENTE DESCRIPTION "Clientes"

ENDWSSERVICE

WSMETHOD GRAVACLIENTE WSRECEIVE ACLIENTE,CCPF,_cEmp,_cFil  WSSEND CREGSA1 WSSERVICE TCliente

Local cEmp				:= _cEmp
Local cFil				:= _cFil
Local aTab				:= {"SA1"}
Local cPdCpf    		:= ""
Local aDat				:= {}
Local aSa1Stru			:= {}
Local aComplem			:= {}
Local cCodigo			:= ""
Local cLoja				:= ""
Local nOpc				:= 3
Local cCod
Local bQuery 			:= {|X| Iif(Select(X) > 0, (X)->(dbCloseArea()), Nil),;
								dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),X,.F.,.T.),;
								dbSelectArea(X),;
								(X)->(dbGoTop())}
Private lMsErroauto		:= .f.
Private lMsHelpAuto		:= .f.
Private lautoErrNoFile	:= .T.

//Podemos observer que definimos 4 variáveis que iremos receber do client 
//ACLIENTE – Estrutura criada dos dados necessaries para receber do cliente a informação para ser 
//gravada no Protheus
//CCPF – variavel do CPF do cliente para analise se ja existe na base de dados, caso exista será 
//atualizado com os dados novos
//_cEmp - Empresa que o cliente deve ser inserido
//_cFil – Filial da empresa que o cliente deve ser inserido

//Declaração
WSDATA ACLIENTE	AS CLIENTES  // ESTRUTURA DE DADOS RECEBIDOS DO CLIENTE
WsData _cEmp	As String
WsData _cFil	As String
WsData CREGSA1	As string 	// RETORNO DA MENSAGEM DO EXECAUTO
WSData CCPF		As string	// VARIAVEL PARA RECEBER O CPF DO CLIENTE 							// "CONFERENCIA SE JA EXISTE""

//Criação da estrutura
WsStruct CLIENTES
WsData	A1_COD	 	as	String
WsData	A1_LOJA	 	as	String
WsData	A1_NOME	 	as	String
WsData	A1_NREDUZ	as	String
WsData	A1_END	 	as	String
WsData	A1_MUN	 	as	String
WsData	A1_CGC	 	as	String
WsData	A1_INSCRM	as	String
WsData	A1_EMAIL	as	String
WsData	A1_PAIS	 	as	String
WsData	A1_CODPAIS	as	String
WsData	A1_PESSOA	as	String
WsData	A1_TIPO	 	as	String
WsData	A1_ESTADO	as	String
WsData	A1_EST	 	as	String
WsData	A1_COD_MUN 	as	String
WsData	A1_ENDNUM	as	String
WsData	A1_BAIRRO	as	String
WsData	A1_CEP  	as	String

EndWsStruct

RpcSetEnv(cEmp,cFil,,,'FIN','ListEmpresa',aTab) //abre a conexão com o banco e a empresa padrão

cPdCpf	:= tamsx3("A1_CGC")[1]

//--Cria estrutura de retorno
::ACLIENTE := WsClassNew( 'CLIENTES' )

DBSELECTAREA("SA1") 
SA1->(DBSETORDER(3))

If SA1->(DBSEEK(XFILIAL("SA1")+PADR(CCPF,cPdCpf)))
	nOpc	:= 4
	cCodigo	:= SA1->A1_COD
	cLoja	:= SA1->A1_LOJA
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³iniciando a gravação do cadastro do cliente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aSa1Stru,{'A1_COD',	"C",6,0})
AADD(aSa1Stru,{'A1_LOJA',	"C",2,0})
AADD(aSa1Stru,{'A1_NOME',	"C",50,0})
AADD(aSa1Stru,{'A1_NREDUZ',	"C",40,0})
AADD(aSa1Stru,{'A1_END',	"C",50,0})
AADD(aSa1Stru,{'A1_ESTADO',	"C",60,0})
AADD(aSa1Stru,{'A1_EST',	"C",60,0})
AADD(aSa1Stru,{'A1_MUN',	"C",10,0})
AADD(aSa1Stru,{'A1_COD_MUN',"C",10,0})
AADD(aSa1Stru,{'A1_PESSOA',	"C",10,0})
AADD(aSa1Stru,{'A1_CGC',	"C",20,0})
AADD(aSa1Stru,{'A1_INSCRM',	"C",30,0})
AADD(aSa1Stru,{'A1_EMAIL',	"C",50,0})
AADD(aSa1Stru,{'A1_ATIVO',	"C",50,0})
AADD(aSa1Stru,{'A1_CODPAIS',"C",50,0})
AADD(aSa1Stru,{'A1_PAIS',	"C",50,0})
AADD(aSa1Stru,{'A1_SISTORI',"C",60,0})
AADD(aSa1Stru,{'A1_TIPO',	"C",60,0})
AADD(aSa1Stru,{'A1_ENDNUM',	"C",60,0})
AADD(aSa1Stru,{'A1_BAIRRO',	"C",60,0})
AADD(aSa1Stru,{'A1_CEP',	"C",60,0})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Regra de identificação dos campos para adicionar informações proprias do Sistema³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nI := 1 to Len(aSa1Stru)
	If AllTrim(aSa1Stru[nI,01]) == "A1_COD" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_COD,Nil})
		cCod := aCliente:A1_COD
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_LOJA" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_LOJA,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_BAIRRO" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_BAIRRO,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_EST" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_EST,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_CEP" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_CEP,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_CGC" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_CGC,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_COD_MUN" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_COD_MUN,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_CODPAIS" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_CODPAIS,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_EMAIL" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_EMAIL,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_END" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_END,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_ENDNUM" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_ENDNUM,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_INSCRM" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_INSCRM,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_MUN" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_MUN,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_NOME" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_NOME,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_NREDUZ" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_NREDUZ,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_PAIS" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_PAIS,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_PESSOA" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_PESSOA,Nil})
	ElseIf AllTrim(aSa1Stru[nI,01]) == "A1_TIPO" 
		aAdd(aDat,{aSa1Stru[nI,01],aCliente:A1_TIPO,Nil})
	EndIf
Next

nA1COD 	:= aScan(adat,{|x| alltrim(x[1])== 'A1_COD'})
nA1LOJ 	:= aScan(adat,{|x| alltrim(x[1])== 'A1_LOJA'})
If nA1COD>0 
	IF nOpc ==3
		cCodigo := GETSXENUM("SA1","A1_COD")
		CONFIRMSX8()
		cLoja	:= "01"//CRIAVAR("A1_LOJA")
    ENDIF
	//ADAT[nA1COD][2] 	:= cCodigo
	//ADAT[nA1LOJ][2] 	:= cLoja
EndIf

nA1FILI := aScan(adat,{|x| alltrim(x[1])== 'A1_FILIAL'})
if nA1FILI>0
	ADAT[nA1FILI][2] 	:= XFILIAL('SA1')
ENDIF

nA1CGC := aScan(adat,{|x| alltrim(x[1])== 'A1_CGC'})
if nA1CGC>0
	ADAT[nA1CGC][2] 	:= CCPF
ENDIF

nA1EST		:= aScan(adat,{|x| alltrim(x[1])== 'A1_EST'})
nA1MUN		:= aScan(adat,{|x| alltrim(x[1])== 'A1_MUN'})
nA1CDMUN	:= aScan(adat,{|x| alltrim(x[1])== 'A1_COD_MUN'})

If nA1CDMUN>0

	cQuery := "SELECT A.CC2_CODMUN FROM "+RETSQLNAME("CC2")+" A WHERE A.CC2_FILIAL = '"+xFilial("CC2")+"' AND  A.CC2_EST = '"+alltrim(ADAT[nA1EST][2])+"' AND A.CC2_MUN = '"+alltrim(ADAT[nA1MUN][2])+"' and D_E_L_E_T_ = ' '"
	X := "TMP"
	CONOUT(cQuery)
	Eval(bQuery,"TMP")
   	ADAT[nA1CDMUN][2]:= TMP->CC2_CODMUN
//	A1_EST := alltrim(ADAT[nA1EST][2])
EndIf

SX3->(DBSETORDER(2))
For nFor := 1 to len(aDat)
	  If empty(aDat[nFor][2])
	  	SX3->(DBSEEK(aDat[nFor][1]))
	  	aDat[nFor][2] := &(SX3->X3_RELACAO)
	  EndIf
Next nFor

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Normalizando os Dados³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aDeletar := {}
DBSELECTAREA("SA1")
nQtdDel := 0

BeginTran()
//VARINFO('aDat',aDat)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ ¿
//³gravação de dados do Cliente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Ù
MSEXECAUTO( {|X,Y| MATA030(X,Y) },adat,nOpc)
If lMsErroauto
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ ¿
	//³disarma a transação³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Ù
	nPx := 0
	DisarmTransaction()
	aAutoErro	:= GETAUTOGRLOG()
	cMsg := ""
	If Len(aAutoErro)>=2
		cCpox := '- '+alltrim(substr(aAutoErro[1],at('_',aAutoErro[1])-2,10))
		nPx		:= aScan(aAutoErro,{|W| cCpox$W })
		If nPx<=0
			nPx		:= aScan(aAutoErro,{|W| '< -- '$W })
		EndIf
	EndIf
	nTotV := iif(len(aAutoErro)>20,20,len(aAutoErro))
	For nFor1 := 1 to nTotV
		If !empty(alltrim(STRTRAN(STRTRAN(aAutoErro[nFor1],"'",'"'),'---','')))
			cMsg		+= U_TIRACENTO(alltrim(STRTRAN(STRTRAN(aAutoErro[nFor1],"'",'"'),'---','')))+CRLF
		EndIf
	Next nfor1
	
	If nPx>0
		cMsg += U_TIRACENTO(alltrim(STRTRAN(STRTRAN(aAutoErro[nPx],"'",'"'),'---','')))+CRLF
	EndIf
	::CREGSA1:= "ERRO AO GRAVAR O CLIENTE:"+CRLF+cMsg
Else
	EndTran()
	::CREGSA1:= "SUCESSO CODIGO DO CLIENTE:"+cCod
EndIf

Return .T.