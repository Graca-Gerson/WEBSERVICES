#Include 'Protheus.ch'

// #########################################################################################
// Projeto: Curso Totvs Developer Studio
// Modulo : Treinamento Presencial
// Fonte  : 10_Edicao.prw
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor  CT-TOTVS   | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 25/09/12 | Edição de Códigos
// ---------+-------------------+-----------------------------------------------------------

User Function EdicaoTDS()
Local cRegiao := "NE"
Local nICMS

If cRegiao == "SE"
nICMS := 18
ElseIf cRegiao == "SU"
nICMS := 9
ElseIf cRegiao == "NE"
nICMS := 7
Else
nICMS := 12
EndIf

MsgAlert(nICMS)

Return Nil
//--------------------------Comandos de Atalhos para Edição ----------------------------------------------------------------

// Ctrl + Alt + Up    -> Duplica o bloco acima.
// Ctrl + Alt + Down -> Duplica o bloco abaixo.
// Ctrl + Back        -> Exclui palavra anterior.
// Ctrl + Del         -> Exclui próxima palavra.
// Alt + Up            -> Move a linha para cima.
// Alt + Down			->Move a linha para baixo.
// Ctrl + Shift + X	->Coloca bloco selecionado em maiúsculo.
// Ctrl + Shift + Y  ->Coloca bloco selecionado em minúsculo.
// Ctrl + I 			->Efetua a identação do arquivo-fonte ou do trecho selecionado.
// Insert				->Alterna entre modo de inserção e sobrescrita.
// Ctrl + F9			->Inicia compilação (requer servidor)
// Alt + /			->Completa as palavras sem mostrar a janela popup de opções, pressione novamente para alternar as opções disponíveis.
// Ctrl + Espaço		->Ativa janela popup de completar/autocompletar.
// Ctrl + D 			->Remove a linha atual
// Ctrl + M				->Alterna entre janela máxima e mínima da visão corrente.
// Ctrl + O 			->Abre a visão outline em uma janela popup.
// Ctrl + F10			->Abre um menu popup com algumas opções.
// Ctrl + Shift + I  ->Efetua a identação do programa-fonte ou bloco selecionado

//---------------------------------------------------------------------------------------------------------------------------


