#Include "Protheus.ch"

User Function GetAnswer(lDefault)

Local lOk
lOk := GetOk(lDefault)
If lOk
   Alert (lOk)
   Return .T.
Else
	Alert (lOk)
   Return .F.
EndIf

Return


Static Function GetOk(lVer)

Local lRet := .T.

Return lRet