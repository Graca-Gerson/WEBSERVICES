User Function TCASE()

Local nMes     := Month(Date())
Local cPeriodo := ""
 
DO CASE
  Case nMes <= 3
   cPeriodo := "Primeiro Trimestre"
  Case nMes >= 4 .And. nMes <= 6
   cPeriodo := "Segundo Trimestre"
  Case nMes >= 7 .And. nMes <= 9
   cPeriodo := "Terceiro Trimestre"
OtherWise
  cPeriodo  := "Quarto Trimestre"
EndCase

MsgAlert(cPeriodo)

Return