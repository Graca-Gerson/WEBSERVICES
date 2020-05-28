#Include 'Protheus.ch'

User Function MATACLI(xRotAuto,nOpcAuto)

Local oMBrowse
Local aCampos 		:= {}

Private lMsErroAuto := .F.

If xRotAuto == NIL
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias('SA1')
	oBrowse:SetDescription("Cadastro de Clientes")
	oBrowse:Activate()
Else
	aAdd( aCampos, { 'A1_COD'   , '000104' } )
	aAdd( aCampos, { 'A1_LOJA'  , '02' } )
	aAdd( aCampos, { 'A1_NOME'  , 'MVC EXEC' } )
	aAdd( aCampos, { 'A1_NREDUZ', 'Emilio Rosa' } )
	aAdd( aCampos, { 'A1_TIPO'  , 'F' } )
	aAdd( aCampos, { 'A1_EST'   , 'SP' } )
	aAdd( aCampos, { 'A1_MUN'   , 'SÃO PAULO' } )
	aAdd( aCampos, { 'A1_END'   , 'Av Braz Leme' } )
	
	aRotina := MenuDef()
	FWMVCRotAuto(ModelDef(),"SA1",nOpcAuto,{{"MATA030_SA1",aCampos}})
	
	If !lMsErroAuto
    	MsgInfo("Incluido com sucesso! ")
    Else
    	MsgInfo("Erro na inclusao!")
    EndIf
        
Endif

Return