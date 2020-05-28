#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'


User Function FSCADM01()

Local oBrowser := FWmBrowse():New()

oBrowser:SetAlias("SZ0")
oBrowser:SetDescription("Pedido")
oBrowser:Activate()

Return(Nil)


Static Function MenuDef()

Local aRotina := {}     

Add OPTION aRotina Title "Visualizar"	Action "VIEWDEF.FSCADM01"	OPERATION 2 ACCESS 0 
Add OPTION aRotina Title "Incluir"   	Action "VIEWDEF.FSCADM01"	OPERATION 3 ACCESS 0 
Add OPTION aRotina Title "Alterar"		Action "VIEWDEF.FSCADM01"	OPERATION 4 ACCESS 0 
Add OPTION aRotina Title "Excluir"    	Action "VIEWDEF.FSCADM01"	OPERATION 5 ACCESS 0 
Add OPTION aRotina Title "Imprimir" 	Action "VIEWDEF.FSCADM01"	OPERATION 8 ACCESS 0
Add OPTION aRotina Title "Copiar" 		Action "VIEWDEF.FSCADM01"	OPERATION 9 ACCESS 0

Return(aRotina)


Static Function ModelDef()

Local oModel	:= MPFormModel():New("CADM01FS")
Local oStr1 	:= FWFormStruct(1,"SZ0")
Local oStr2 	:= FWFormStruct(1,"SZ1")

oModel:AddFields('MASTER',,oStr1,,,)
oModel:SetPrimaryKey({'Z0_FILIAL','Z0_NUM'})

oModel:AddGrid('DETAIL','MASTER',oStr2,,{|oGrid| PLSC03LOK(oGrid)})
oModel:SetRelation('DETAIL',{{'Z1_FILIAL','xFilial("SZ1")'},{'Z1_NUM','Z0_NUM'}},SZ1->(IndexKey(1)))

oModel:GetModel('DETAIL'):SetUniqueLine({'Z1_ITEM'})

Return(oModel)


Static Function ViewDef()

Local oView		:= FWFormView():New()
Local oModel 	:= FWLoadModel("FSCADM01")
Local oStr1 	:= FWFormStruct(2,"SZ0")
Local oStr2 	:= FWFormStruct(2,"SZ1")

oStr2:RemoveField('Z1_NUM')

oView:SetModel(oModel)

oView:AddField('VWMASTER',oStr1,'MASTER')
oView:AddGrid('VWDETAIL',oStr2,'DETAIL')  

oView:CreateHorizontalBox('CABEC',20)
oView:CreateHorizontalBox('ITENS',80)

oView:EnableTitleView('VWMASTER')
oView:EnableTitleView('VWDETAIL')

oView:AddIncrementField('VWDETAIL','Z1_ITEM')
   
oView:SetOwnerView('VWMASTER','CABEC')
oView:SetOwnerView('VWDETAIL','ITENS')

Return(oView)

Static Function PLSC03LOK(oGrid)

Local nOpcao	:= oGrid:GetOperation()
Local nLin		:= oGrid:GetLine()
Local lRet		:= .T.
Local lValor 	:= (oGrid:GetValue("Z1_QTD",nLin) <> 0 .Or. oGrid:GetValue("Z1_VALOR",nLin) <> 0 .Or. oGrid:GetValue("Z1_TOTAL",nLin) <> 0)
Local nX		:= 0

If lRet .And. Empty(oGrid:GetValue("Z1_COD",nLin))
	lRet := .F.
	Help(,,"Obrigatório!",,"É obrigatório o preenchimento do codigo do produto!",1,0)
EndIf	

/*If lRet .And. oGrid:GetValue("Z1_QTD",nLin) <> 0 
	lRet := .F.
	Help(,,"Inválido!",,"Não é permitido quantidade do produto zerado!",1,0)
EndIf	
 
If lRet .And. oGrid:GetValue("Z1_VALOR",nLin) <> 0 
	lRet := .F.
	Help(,,"Inválido!",,"Não é permitido valor unitario do produto zerado!",1,0)
EndIf

If lRet .And. oGrid:GetValue("Z1_TOTAL",nLin) <> 0 
	lRet := .F.
	Help(,,"Inválido!",,"Não é permitido valor unitario do produto zerado!",1,0)
EndIf*/
	
Return(lRet)