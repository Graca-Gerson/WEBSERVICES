01 User Function TCalX()
02
03 Local xVariavel // Declara a vari�vel inicialmente com valor nulo
04 
05 xVariavel := "Agora a vari�vel � caractere..."
06 Alert("Valor do Texto: " + xVariavel)
07 
08 xVariavel := 22 // Agora a vari�vel � num�rica
09 Alert("Valor do Numero: " +AllTrim(Str(xVariavel)))
10
11 xVariavel := .T. // Agora a vari�vel � l�gica
12 If xVariavel
13    Alert("A vari�vel tem valor verdadeiro...")
14 Else
15	Alert("A vari�vel tem valor falso...")
16 EndIf
17
18 xVariavel := Date() // Agora a vari�vel � data
19 Alert("Hoje �: " + DtoS(xVariavel))
20
21 xVariavel := nil // Nulo novamente
22 Alert(xVariavel)
23
24 Return