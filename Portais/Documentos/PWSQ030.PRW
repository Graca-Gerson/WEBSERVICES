#INCLUDE "APWEBEX.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "SIGAWIN.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PWSQ030   �Autor  �Telso Carneiro      � Data �  22/02/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Pagina iframe inicial de item Documentos                   ���
���          � Resultado do filtro                                        ���
�������������������������������������������������������������������������͹��
���Uso       � Portal QDO                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Web Function PWSQ030()

Local cHtml 	:= ""
Local aColsAux 	:= AClone(httpSession->WSQDO20ACOLSCOMP)
Local aCols     := {}
Local cTipo     := Alltrim(HttpGet->filtro)   


WEB EXTENDED INIT cHtml
     
	IF cTipo=="Todos"                                          
   		aCols:=Aclone(aColsAux)
    Else
  		aEval(aColsAux,{|x| IF(Alltrim(x[2])==cTipo,Aadd(aCols,x),"")})
   	Endif	
    	
	HttpSession->WSQDO30ACOLSFILT:= Aclone(aCols)
	IF Len(HttpSession->WSQDO30ACOLSFILT) >0 
		cHtml += ExecInPage( "PWSQ030" )
	Endif

WEB EXTENDED END

Return cHtml
