#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBEX.CH"  
#INCLUDE "PWSA150.CH"

/*/
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������Ŀ��
���Descri��o � Web Functions respons�veis pela solicita��o de novas contra- ���
���          � ta��es e substitui��es.                                      ���
���������������������������������������������������������������������������Ĵ��
���Uso       � RH/Portais                                                   ���
���������������������������������������������������������������������������Ĵ��
��� Atualizacoes sofridas desde a Construcao Inicial.                       ���
���������������������������������������������������������������������������Ĵ��
��� Programador  � Data   � FNC            �  Motivo da Alteracao           ��� 
���Tatiane Matias|20/12/10|00000023758/2010|Jun��o dos fontes para solicita-���
���              |        |                |��o de novos postos/aumento de  ���
���              |        |                |quadro e novas contrata��es /   ���
���              |        |                |substitui��es, com isso as web  ���
���              |        |                |functions deste fonte foram re- ���
���              |        |                |tiradas e passou a usar as web  ���
���              |        |                |functions do fonte PWSA110.PRW  ���
����������������������������������������������������������������������������ٱ�
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
/*/

/*******************************************************************
* Funcao: PWSA150
* Autor: Flavio S. Correa
* Data: 26/11/09
* Lista de Departamentos - Contratacao
********************************************************************/
Web Function PWSA150()
	Local cHtml   	:= ""
	
	WEB EXTENDED INIT cHtml START "InSite"
		HttpGet->titulo           := STR0005 //"Novas Contrata��es e Substitui��es"
		HttpSession->cTypeRequest := "5"
		cHtml := ExecInPage( "PWSA110" )	
	WEB EXTENDED END

Return cHtml