#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBEX.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � StartWebEx � Autor � Alexander           � Data � 09.08.06 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Funcao para iniciar do ambiente na web (Tiss - ONLINE)	  ���
���			 � deve estar definido sa sessao a chave SIGAWEB=MAK		  ���
�������������������������������������������������������������������������Ĵ��
��� Atencao  � Nunca altere este rdmake									  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
USER Function StartWebEx()
LOCAL cEnv := GetEnvServer()
LOCAL cEmp := AllTrim(GETPVPROFSTRING(cEnv,"JEMP","",GetADV97()))
LOCAL cFil := AllTrim(GETPVPROFSTRING(cEnv,"JFIL","",GetADV97()))

If !Empty(cEmp) .And. !Empty(cFil) 
	RpcSetEnv( cEmp,cFil,,,"PLS",,)        
Else          
    cRet := "A ENVIRONMENT ["+cEnv+" ] n�o tem declarada as variaveis cEmp e cFil"
	LogOnl(cRet)
EndIf
//��������������������������������������������������������������������������Ŀ
//� Fim da Funcao															 �
//����������������������������������������������������������������������������
Return .T.