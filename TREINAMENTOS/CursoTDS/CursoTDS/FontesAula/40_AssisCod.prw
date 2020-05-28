// #########################################################################################
// Projeto: Curso Totvs Developer Studio 
// Modulo : 
// Fonte  : 40_AssisCod
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 09/10/12 | TOTVS Developer Studio | Gerado pelo Assistente de Código
// ---------+-------------------+-----------------------------------------------------------

#include "rwmake.ch"

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} novo
Permite a manutenção de dados armazenados em SA1.

@author    TOTVS Developer Studio - Gerado pelo Assistente de Código
@version   1.xx
@since     9/10/2012
/*/
//------------------------------------------------------------------------------------------
user function AXSA1()
//--< variáveis >---------------------------------------------------------------------------

//Indica a permissão ou não para a operação (pode-se utilizar 'ExecBlock')
	local cVldAlt := ".T." // Operação: ALTERAÇÃO
	local cVldExc := ".T." // Operação: EXCLUSÃO

//trabalho/apoio
	local cAlias

//--< procedimentos >-----------------------------------------------------------------------
	cAlias := "SA1"
	chkFile(cAlias)
	dbSelectArea(cAlias)
//indices
	dbSetOrder(1)
	axCadastro(cAlias, "Cadastro de . . .", cVldExc, cVldAlt)

	return
//--< fim de arquivo >----------------------------------------------------------------------
