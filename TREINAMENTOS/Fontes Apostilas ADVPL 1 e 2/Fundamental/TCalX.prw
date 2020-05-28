User Function TCalX()

Local xVariavel // Declara a variável inicialmente com valor nulo

xVariavel := "Agora a variável é caractere..."
Alert("Valor do Texto: " + xVariavel)

xVariavel := 22 // Agora a variável é numérica
Alert("Valor do Numero: " +AllTrim(Str(xVariavel)))

xVariavel := .T. // Agora a variável é lógica
If xVariavel
    Alert("A variável tem valor verdadeiro...")
Else
	Alert("A variável tem valor falso...")
EndIf

xVariavel := Date() // Agora a variável é data
Alert("Hoje é: " + DtoS(xVariavel))

xVariavel := nil // Nulo novamente
Alert(xVariavel)

Return