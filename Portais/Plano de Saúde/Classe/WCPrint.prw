#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
//-------------------------------------------------------------------
/*/{Protheus.doc} WCPrint
Classe Print.

@author Alexander Santos
@since 14/02/2012
@version P11
/*/
//-------------------------------------------------------------------
CLASS WCPrint

DATA cTitle	 	AS STRING
DATA cName	 	AS STRING
DATA cWidth		AS STRING
DATA cLabel		AS STRING
DATA cFileName	AS STRING
DATA cFuncJs		AS STRING
DATA cMsgPlug		AS STRING

METHOD New() Constructor

ENDCLASS
//-------------------------------------------------------------------
/*/{Protheus.doc} New
Construtor da Class

@author Alexander Santos
@since 16/02/2011
@version P11
/*/
//-------------------------------------------------------------------
METHOD New(cTitle,cLabel,cName,cFileName,cFuncJs,cWidth, cMsgPlug) CLASS WCPrint
DEFAULT cTitle 		:= ""
DEFAULT cName 		:= ""
DEFAULT cLabel		:= ""
DEFAULT cFileName	:= ""
DEFAULT cFuncJs		:= ""
DEFAULT cWidth		:= ""
DEFAULT cMsgPlug		:= ""

::cTitle	:= cTitle
::cLabel	:= cLabel
::cName		:= cName
::cFileName	:= cFileName
::cFuncJs	:= cFuncJs
::cWidth	:= cWidth
::cMsgPlug := cMsgPlug
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
//쿑im do Methodo
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
Return Self   
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽굇
굇쿑uncao    �__WCPrint � Autor � Totvs				    � Data � 30/03/10 낢굇
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙굇
굇쿏escricao � Somente para compilar a class							  낢굇
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽
/*/
Function __WCPrint
Return