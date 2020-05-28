#define FUNCT_NOME   1
#define FUNCT_IDADE  2
#define FUNCT_CASADO 3



User Function TA2()

Local nCount	:= 0
Local aFuncts 	:= { 	{"Pedro"  , 32, .T.}, ;
      	    		 	{"Maria"  , 22, .T.}, ;
        	   			{"Antônio", 42, .F.} }

For nCount := 1 To Len(aFuncts)
	MsgInfo(aFuncts[nCount, FUNCT_NOME])
Next

Return