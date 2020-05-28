#define FUNCT_NOME   1
#define FUNCT_IDADE  2
#define FUNCT_CASADO 3



User Function TA1()

//E considere mais alguns arrays para representar mais pessoas:
Local aFunct1 := {"Pedro"  , 32, .T.}
Local aFunct2 := {"Maria"  , 22, .T.}
Local aFunct3 := {"Antônio", 42, .F.}

//Os nomes podem ser impressos assim:

MsgAlert(aFunct1[FUNCT_NOME])
MsgAlert(aFunct2[FUNCT_NOME])
MsgAlert(aFunct3[FUNCT_NOME])

Return