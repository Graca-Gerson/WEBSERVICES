#Include 'Protheus.ch'

// #########################################################################################
// Projeto: Curso Totvs Developer Studio
// Modulo : Treinamento Presencial
// Fonte  : 20_Debug.prw
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor  CT-TOTVS  marqui | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 25/09/12 |								 Criação e Aplicação de Patchs
// ---------+-------------------+-----------------------------------------------------------

User Function 30_Patch()

Local cMensg:="Geração e Aplicação de Patchs"
Local dData := nil

//conversão para o padrão Britanico
SET DATE BRITISH  
dData := DATE()
MsgAlert(cMensg + " criado no dia: " + DTOC(dData))
	
Return



	
