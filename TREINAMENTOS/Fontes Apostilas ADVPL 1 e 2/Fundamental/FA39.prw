User Function FA39()

Local cChave := "0100000101"
Local lConfirma := .F.

DbSelectArea("SA1")
DbSetOrder(1)
If DbSeek(cChave)
	lConfirma := .T.
EndIf

If Found()
	SoftLock() // Reserva o registro localizado

	IF lConfirma
		RecLock("SZ1",.F.)
	   		SZ1->Z1_STATUS = "1"
		MsUnLock() // Liberado o RecLock() e o SoftLock() do registro.
	Endif
Endif

Return