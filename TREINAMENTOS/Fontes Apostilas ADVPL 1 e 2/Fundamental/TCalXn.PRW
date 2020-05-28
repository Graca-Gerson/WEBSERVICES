01 User Function TCalX()
02
03 Local xVariavel // Declara a variável inicialmente com valor nulo
04 
05 xVariavel := "Agora a variável é caractere..."
06 Alert("Valor do Texto: " + xVariavel)
07 
08 xVariavel := 22 // Agora a variável é numérica
09 Alert("Valor do Numero: " +AllTrim(Str(xVariavel)))
10
11 xVariavel := .T. // Agora a variável é lógica
12 If xVariavel
13    Alert("A variável tem valor verdadeiro...")
14 Else
15	Alert("A variável tem valor falso...")
16 EndIf
17
18 xVariavel := Date() // Agora a variável é data
19 Alert("Hoje é: " + DtoS(xVariavel))
20
21 xVariavel := nil // Nulo novamente
22 Alert(xVariavel)
23
24 Return