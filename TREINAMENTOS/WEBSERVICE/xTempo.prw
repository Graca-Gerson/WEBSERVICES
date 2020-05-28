#include "Protheus.ch"

User function Xtempo()

Local oBj := nil

oBj:=WSSERVERTIME():new()

If !Empty(oBj)  
	oBj:GETSERVERTIME(' ')
	msgInfo( oBj:cGETSERVERTIMERESULT )
Else  
  cSvcError   := GetWSCError()  // Resumo do erro
  cSoapFCode  := GetWSCError(2) // Soap Fault Code
  cSoapFDescr := GetWSCError(3) // Soap Fault Description  
  If ! empty(cSoapFCode)
    // Caso a ocorr�ncia de erro esteja com o fault_code preenchido ,
    // a mesma teve rela��o com a chamada do servi�o .
    MsgStop(cSoapFDescr,cSoapFCode)
  Else
    // Caso a ocorr�ncia n�o tenha o soap_code preenchido
    // Ela est� relacionada a uma outra falha ,
    // provavelmente local ou interna.
    MsgStop(cSvcError,'FALHA INTERNA DE EXECUCAO DO SERVI�O')
  Endif
Endif


Return()

