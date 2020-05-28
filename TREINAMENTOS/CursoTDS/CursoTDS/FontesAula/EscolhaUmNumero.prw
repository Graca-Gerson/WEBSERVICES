#Include 'Protheus.ch'

user function escolheNum()

	local n, cResp, cMsg := ""
	local aOpcoes := {}

	for n := 1 to 5
		aAdd(aOpcoes, strZero(n,1,0))
	next

	while !(cResp == "*")
		cResp := tela(aOpcoes)

		if cResp == "1"
			cMsg := "Voc� escolheu o numero 1"
		elseif cResp == "2"
			cMsg := "Voc� escolheu o numero 2"
		elseif cResp == "3"
			cMsg := "Voc� escolheu o numero 3"
		elseif cResp == "4"
			cMsg := "Voc� escolheu o numero 4"
		elseif cResp == "5"
			cMsg := "Voc� escolheu o numero 5"
		else
			cMsg := "Nenhum n�mero escolhido"
		endif

		if !empty(cResp)
			if cResp == "2" .or. cResp == "4"
				cMsg += " e � PAR"
			else
				cMsg += " e � IMPAR"
			endif
		endif

		if !(cResp == "*")
			msgAlert(cMsg)
		endif

	enddo

return

static function tela(aaOpcoes)
	Local oDlg,oSay1,oBtn

	private cOpcao := ""

	if !(valType(aaOpcoes) == "A")
		msgAlerta("Parametro aaOpcoes n�o � uma lista (array)")
		return cOpcao
	endif

	oDlg := MSDIALOG():Create()
	oDlg:cName := "oDlg"
	oDlg:cCaption := "Escolha um numero"
	oDlg:nLeft := 0
	oDlg:nTop := 0
	oDlg:nWidth := 400
	oDlg:nHeight := 250
	oDlg:lCentered := .T.

	oSay1 := TSAY():Create(oDlg)
	oSay1:cName := "oSay1"
	oSay1:cCaption := "Escolha um n�mero acionando um dos bot�es abaixo."
	oSay1:nLeft := 10
	oSay1:nTop := 28
	oSay1:nWidth := 250
	oSay1:nHeight := 17
	oSay1:lTransparent := .T.

	oBtn := TButton():Create(oDlg)
	oBtn:cCaption := "<nenhum>"
	oBtn:blClicked := {|| cOpcao := "", oDlg:end() }
	oBtn:nWidth := 90
	oBtn:nTop := 90
	oBtn:nLeft := 10

	oBtn := TButton():Create(oDlg)
	oBtn:cCaption := "<encerrar>"
	oBtn:blClicked := {|| cOpcao := "*", oDlg:end() }
	oBtn:nWidth := 90
	oBtn:nTop := 90
	oBtn:nLeft := 110

	aEval(aaOpcoes, { |x,i| ;
		oBtn := TButton():Create(oDlg),;
		oBtn:cCaption := x,;
		oBtn:blClicked := &("{|| cOpcao := '"+x+"', oDlg:end() }"),;
		oBtn:nWidth := 30,;
		oBtn:nTop := 60,;
		oBtn:nLeft := (10 * i) + (oBtn:nWidth*(i-1));
		})

	oDlg:Activate()

Return cOpcao

