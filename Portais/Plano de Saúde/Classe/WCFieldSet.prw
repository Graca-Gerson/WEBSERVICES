#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "AP5MAIL.CH"  
//-------------------------------------------------------------------
/*/{Protheus.doc} WCFieldSet
Classe Linha.

@author Alexander Santos
@since 14/02/2012
@version P11
/*/
//-------------------------------------------------------------------
CLASS WCFieldSet

DATA cTitLegen		AS STRING 	//Titulo da legenda de grupo
DATA cWidth			AS STRING 	//Largura do fieldset
DATA cPx			AS STRING 	//Padding do fieldset
DATA cPxLeft		AS STRING 	//Padding-Left do FieldSet
DATA cFormatF		AS STRING 	//Formulario de campos ou nao FORMATADO na horizontal, vertical ou default
DATA aFSComp		AS ARRAY HIDDEN
DATA cIdLegend         AS STRING

METHOD New() Constructor

METHOD setAddCFS()
METHOD setInForm()

ENDCLASS
//-------------------------------------------------------------------
/*/{Protheus.doc} New
Construtor da Class

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD New(cTitLegen,cWidth,cPx,cPxLeft,cIdLegend) CLASS WCFieldSet
DEFAULT cTitLegen	:= ""
DEFAULT cWidth		:= ""
DEFAULT cPx			:= ""
DEFAULT cPxLeft		:= ""
DEFAULT cIdLegend          := ""

::cTitLegen	:= cTitLegen
::cWidth	:= cWidth
::cPx		:= cPx
::cPxLeft	:= cPxLeft    
::cFormatF	:= 'H'
::cIdLegend         := cIdLegend

::aFSComp := {}
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
//쿑im do Methodo
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
Return Self                
//-------------------------------------------------------------------
/*/{Protheus.doc} WCFieldSet
Seta componente ao FieldSet

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD setAddCFS(oObj) CLASS WCFieldSet
AaDd(::aFSComp,oObj)
Return           
//-------------------------------------------------------------------
/*/{Protheus.doc} WCFieldSet
Seta se o fieldset sera formatado para formulario de campos

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD setInForm(cFormatF) CLASS WCFieldSet
::cFormatF := cFormatF
Return   
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
굇旼컴컴컴컴컫컴컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽굇
굇쿑uncao    �__WCFieldSet� Autor � Totvs			    � Data � 30/03/10 낢굇
굇쳐컴컴컴컴컵컴컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙굇
굇쿏escricao � Somente para compilar a class							  낢굇
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽
/*/
Function __WCFieldSet
Return