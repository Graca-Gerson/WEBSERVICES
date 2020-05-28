User Function FA12()

Local aAlunos 	:= {"Márcio", "Denis", "Arnaldo", "Patrícia"}
Local bSeek 	:= {|x| x == "Denis"}
Local nPosAluno := aScan(aAlunos,bSeek) // retorno esperado ? 2

MsgAlert(AllTrim(Str(nPosAluno)))

Return