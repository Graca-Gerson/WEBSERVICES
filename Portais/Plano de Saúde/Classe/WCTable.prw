#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "AP5MAIL.CH"  
//-------------------------------------------------------------------
/*/{Protheus.doc} WCTable
Classe Tabela.

@author Alexander Santos
@since 14/02/2012
@version P11
/*/
//-------------------------------------------------------------------
CLASS WCTable

DATA cName	 	AS STRING
DATA cTitFolder	AS STRING
DATA aLines		AS ARRAY HIDDEN
DATA aTables			AS ARRAY HIDDEN
DATA lFolder			AS BOOLEAN HIDDEN

METHOD New() Constructor

METHOD setAddLine()
METHOD getListLine()

METHOD setTitFolder()
METHOD getTitFolder()

METHOD setIsFolder()
METHOD getIsFolder()

METHOD setAddTables()
METHOD getListTables()

ENDCLASS
//-------------------------------------------------------------------
/*/{Protheus.doc} New
Construtor da Class

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD New(cName) CLASS WCTable
DEFAULT cName := ""

::cName   	:= cName
::cTitFolder:= ""
::aLines	:= {}
::aTables		:= {}
//����������������������������������������������������������������������������
//�Fim do Methodo
//����������������������������������������������������������������������������
Return Self                
//-------------------------------------------------------------------
/*/{Protheus.doc} WCTable
Seta a lista de linhas da tabela

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD setAddLine(oObj) CLASS WCTable
	AaDd(::aLines,oObj)
Return              
//-------------------------------------------------------------------
/*/{Protheus.doc} WCTable
Seta a lista de linhas da tabela

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD getListLine() CLASS WCTable
Return(::aLines)
//-------------------------------------------------------------------
/*/{Protheus.doc} WCTable
Seta o titulo do folder

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD setTitFolder(cTitFolder) CLASS WCTable
::cTitFolder := cTitFolder
return
//-------------------------------------------------------------------
/*/{Protheus.doc} WCTable
Retorna o titulo do folder

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD getTitFolder() CLASS WCTable
return(::cTitFolder)
//-------------------------------------------------------------------
/*/{Protheus.doc} WCForm
Seta que as tabelas do form seram colocadas em folders

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD setIsFolder() CLASS WCTable
::lFolder := .t.
return()
//-------------------------------------------------------------------
/*/{Protheus.doc} WCForm
Retorna se as tabelas do form seram colocadas em folder

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD getIsFolder() CLASS WCTable
return(::lFolder)
//-------------------------------------------------------------------
/*/{Protheus.doc} WCForm
Seta a lista de tabelas do formulario

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD setAddTables(oObj) CLASS WCTable
aadd(::aTables,oObj)
return            
//-------------------------------------------------------------------
/*/{Protheus.doc} WCForm
Retorna a lista de tabelas do formulario

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD getListTables() CLASS WCTable
Return(::aTables)
//-------------------------------------------------------------------
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    �__WCTable � Autor � Totvs				    � Data � 30/03/10 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Somente para compilar a class							  ����
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Function __WCTable
Return