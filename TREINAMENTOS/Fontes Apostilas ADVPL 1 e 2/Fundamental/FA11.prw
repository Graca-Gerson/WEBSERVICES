User Function FA11()

Local nInt := 10 

bBloco := {|N| x:= 10, y:= x*N, z:= y/(x*N)}

nValor := EVAL(bBloco, nInt)

Return