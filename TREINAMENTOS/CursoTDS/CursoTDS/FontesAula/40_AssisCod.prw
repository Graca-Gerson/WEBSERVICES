// #########################################################################################
// Projeto: Curso Totvs Developer Studio 
// Modulo : 
// Fonte  : 40_AssisCod
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 09/10/12 | TOTVS Developer Studio | Gerado pelo Assistente de C�digo
// ---------+-------------------+-----------------------------------------------------------

#include "rwmake.ch"

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} novo
Permite a manuten��o de dados armazenados em SA1.

@author    TOTVS Developer Studio - Gerado pelo Assistente de C�digo
@version   1.xx
@since     9/10/2012
/*/
//------------------------------------------------------------------------------------------
user function AXSA1()
//--< vari�veis >---------------------------------------------------------------------------

//Indica a permiss�o ou n�o para a opera��o (pode-se utilizar 'ExecBlock')
	local cVldAlt := ".T." // Opera��o: ALTERA��O
	local cVldExc := ".T." // Opera��o: EXCLUS�O

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
