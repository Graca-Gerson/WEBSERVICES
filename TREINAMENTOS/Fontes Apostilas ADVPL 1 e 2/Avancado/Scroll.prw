#Include "Protheus.CH"

User Function Scroll()

Local oDlg 			:= NIL
Local oScroll 		:= NIL
Local oLbx1 		:= NIL
Local oLbx2 		:= NIL
Local bGet 			:= NIL
Local oGet	 		:= NIL
Local aAIIPM 		:= {}
Local aTitulo 		:= {}
Local nTop 			:= 5
Local nWidth 		:= 0
Local cGet 			:= ""
Local cPict 		:= ""
Local cVar 			:= ""
Local nI 			:= 0

Private cTitulo 	:= "Consulta Parcelamento"
Private aSay 		:= {}
Private cProcesso	:= "P00001"
Private cPrefixo	:= "UNI"
Private cTipo		:= "MAN"
Private cCliente	:= "000001"
Private cLoja		:= "01"
Private cNome		:= "JOSE DA SILVA SANTOS SOARES"
Private cCGC 		:= "00.000.000/0001-91"
Private dData		:= "26/03/18"
Private nTotal		:= 5922.00
Private nUFESP		:= 1000.00
Private cStatus		:= "Z"
Private cCond		:= "001"

// Vetor para os campos no Scrooll Box
//+-------------------------------------+
//| aSay[n][1] - Titulo           	   |
//| aSay[n][2] - Tipo             	   |
//| aSay[n][3] - Tamanho          	   |
//| aSay[n][4] - Decimal          	   |
//| aSay[n][5] - Conteúdo/Variável   |
//| aSay[n][6] - Formato          	   |
//+-------------------------------------+
AADD(aSay,{"Processo"    ,"C",06,0,"cProcesso" ,"@!"})
AADD(aSay,{"Prefixo"     ,"C",03,0,"cPrefixo"  ,"@!"})
AADD(aSay,{"Tipo"        ,"C",03,0,"cTipo"     ,"@!"})
AADD(aSay,{"Cliente"     ,"C",06,0,"cCliente"  ,"@!"})
AADD(aSay,{"Loja"        ,"C",02,0,"cLoja"     ,"@!"})
AADD(aSay,{"Nome"        ,"C",30,0,"cNome"     ,"@!"})
AADD(aSay,{"CNPJ/CPF"    ,"C",14,0,"cCGC"      ,"@!"})
AADD(aSay,{"Dt.Processo" ,"D",08,0,"dData"     ,"@!"})
AADD(aSay,{"Total R$"    ,"N",17,2,"nTotal"    ,"@!"})
AADD(aSay,{"Total UFESP" ,"N",17,2,"nUFESP"    ,"@!"})
AADD(aSay,{"Status"      ,"C",01,0,"cStatus"   ,"@!"})
AADD(aSay,{"Cond.Pagto"  ,"C",03,0,"cCond"     ,"@!"})

// Vetor para List Box
AADD(aAIIPM,{"1234","DCD9815","26/03/18"})
AADD(aAIIPM,{"1234","DCD9815","26/03/18"})
AADD(aAIIPM,{"1234","DCD9815","26/03/18"})

// Vetor para List Box
AADD(aTitulo,{"A","26/03/18","26/03/18","1.974,00","100,00"})
AADD(aTitulo,{"A","26/03/18","26/03/18","1.974,00","100,00"})
AADD(aTitulo,{"A","26/03/18","26/03/18","1.974,00","100,00"})

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 122,0 TO 432,600 OF oDlg PIXEL
   @ 013,002 TO 154,192 LABEL "Parcelamento"  OF oDlg PIXEL
   @ 013,195 TO 082,298 LABEL "Títulos"       OF oDlg PIXEL
   @ 083,195 TO 154,298 LABEL "AIIPM"         OF oDlg PIXEL
   
   //scrollbox
	@ 019,006 SCROLLBOX oScroll HORIZONTAL VERTICAL SIZE 131,182 OF oDlg 
   For nI:=1 TO Len(aSay)

      bGet := &("{|| '"+aSay[nI,01]+"'}")
      cVar := aSay[nI,05]
      cGet  := "{|u| IIF(PCount()>0,"+cVar+":=u,"+cVar+")}"
      cPict := aSay[nI,06]      
         
      TSay():New(nTop,5,bGet,oScroll,,,.F.,.F.,.F.,.T.,,,GetTextWidth(0,Trim(aSay[nI,01])),15,;
      .F.,.F.,.F.,.F.,.F.)
      oGet:=TGet():New(nTop-2,40,&cGet,oScroll,,7,cPict,,,,,.F.,,.T.,,.F.,,.F.,.F.,,.T.,.F.,,(cVar),,,,.T.)
      nTop+=11
	Next nI
   
   //listbox títulos
   @ 019,199 LISTBOX oLbx1 FIELDS HEADER ;
     "Parcela","Vencto","Vencto.Real","Valor R$","Qtd.UFESP";
     COLSIZES 21,24,33,63,100;
     SIZE 095,059 OF oDlg PIXEL
   oLbx1:SetArray( aTitulo )
   oLbx1:bLine := {||{aTitulo[oLbx1:nAt,1],aTitulo[oLbx1:nAt,2],;
   aTitulo[oLbx1:nAt,3],aTitulo[oLbx1:nAt,4],aTitulo[oLbx1:nAt,5]}}   
   
   //listbox aiipm
   @ 089,199 LISTBOX oLbx2 FIELDS HEADER "AIIPM","Placa","Data Multa" ;
   COLSIZES 24,21,30 SIZE 095,061 OF oDlg PIXEL
   oLbx2:SetArray( aAIIPM )
   oLbx2:bLine := {||{aAIIPM[oLbx2:nAt,1],aAIIPM[oLbx2:nAt,2],aAIIPM[oLbx2:nAt,3]}}   
   
ACTIVATE MSDIALOG oDlg CENTER ON INIT EnchoiceBar(oDlg,{||oDlg:End()},{||oDlg:End()})

Return