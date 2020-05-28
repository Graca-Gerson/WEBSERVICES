#Include 'Protheus.ch'

// #########################################################################################
// Projeto: Curso Totvs Developer Studio
// Modulo : Treinamento Presencial
// Fonte  : 10_Edicao.prw
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor  CT-TOTVS   | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 25/09/12 | Edi��o de C�digos
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
//--------------------------Comandos de Atalhos para Edi��o ----------------------------------------------------------------

// Ctrl + Alt + Up    -> Duplica o bloco acima.
// Ctrl + Alt + Down -> Duplica o bloco abaixo.
// Ctrl + Back        -> Exclui palavra anterior.
// Ctrl + Del         -> Exclui pr�xima palavra.
// Alt + Up            -> Move a linha para cima.
// Alt + Down			->Move a linha para baixo.
// Ctrl + Shift + X	->Coloca bloco selecionado em mai�sculo.
// Ctrl + Shift + Y  ->Coloca bloco selecionado em min�sculo.
// Ctrl + I 			->Efetua a identa��o do arquivo-fonte ou do trecho selecionado.
// Insert				->Alterna entre modo de inser��o e sobrescrita.
// Ctrl + F9			->Inicia compila��o (requer servidor)
// Alt + /			->Completa as palavras sem mostrar a janela popup de op��es, pressione novamente para alternar as op��es dispon�veis.
// Ctrl + Espa�o		->Ativa janela popup de completar/autocompletar.
// Ctrl + D 			->Remove a linha atual
// Ctrl + M				->Alterna entre janela m�xima e m�nima da vis�o corrente.
// Ctrl + O 			->Abre a vis�o outline em uma janela popup.
// Ctrl + F10			->Abre um menu popup com algumas op��es.
// Ctrl + Shift + I  ->Efetua a identa��o do programa-fonte ou bloco selecionado

//---------------------------------------------------------------------------------------------------------------------------


