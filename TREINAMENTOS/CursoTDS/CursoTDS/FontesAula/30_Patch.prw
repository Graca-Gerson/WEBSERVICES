#Include 'Protheus.ch'

// #########################################################################################
// Projeto: Curso Totvs Developer Studio
// Modulo : Treinamento Presencial
// Fonte  : 20_Debug.prw
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor  CT-TOTVS  marqui | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 25/09/12 |								 Cria��o e Aplica��o de Patchs
// ---------+-------------------+-----------------------------------------------------------

User Function 30_Patch()

Local cMensg:="Gera��o e Aplica��o de Patchs"
Local dData := nil

//convers�o para o padr�o Britanico
SET DATE BRITISH  
dData := DATE()
MsgAlert(cMensg + " criado no dia: " + DTOC(dData))
	
Return



	
