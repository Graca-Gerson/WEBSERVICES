#Include 'Protheus.ch'

User Function TempoX()

Local oWsdl
Local lOk
Local aOps := {}
Local aComplex := {}
Local aSimple := {}
   
  // Cria o objeto da classe TWsdlManager
  oWsdl := TWsdlManager():New()

  // Faz o parse de uma URL
lOk := oWsdl:ParseURL( "http://localhost:8070/ws/SERVERTIME.apw?WSDL" )
  if !lOk
	 MsgStop( oWsdl:cError , "ParseURL() ERROR")
    Return
  endif

  // Lista os Metodos do servi�o 
  aOps := oWsdl:ListOperations()

// Seta a opera��o a ser utilizada listada pelo ListOperations nome do m�todo 
//que ira executar.

	lOk := oWsdl:SetOperation( "GETSERVERTIME" )
	
if !lOk
 MsgStop( oWsdl:cError , "SetOperation(ConversionRate) ERROR")
 Return
Endif
	
// Verifica o tipo de parametro que vai ser usado pelo m�todo, //retornando quais 
// s�o os campos que ir�o receber valor
	
aComplex := oWsdl:NextComplex()
	aSimple := oWsdl:SimpleInput()
	 
	
// Passando os valores para o parametro do m�todo
     xRet := oWsdl:SetValue( 0, "000" )
	 
// Exibe a mensagem que ser� enviada
   conout( oWsdl:GetSoapMsg() )
	 
	 // Faz a requisi��o ao WebService 
	lOk := oWsdl:SendSoapMsg()
	if !lOk
	 MsgStop( oWsdl:cError , "SendSoapMsg() ERROR")
	 Return
	endif
	
// Recupera os elementos de retorno, j� parseados
cResp := oWsdl:GetParsedResponse()
	
// Monta um array com a resposta transformada, considerando
// as quebras de linha ( LF == Chr(10) ) 

     aElem := StrTokArr(cResp,chr(10))
     MsgInfo( SubStr(aElem[2], AT(":",aElem[2] )+1))	

Return( NIL )