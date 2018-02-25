; ### ARRAYS ###
Weekdays := ["Måndag", "Tisdag", "Onsdag", "Torsdag", "Fredag", "Lördag", "Söndag"]
Protein := ["Bullar", "Biffar", "Burgare", "Färs", "Soppa", "Gryta", "Bitar"]
Kolhydrat := ["Potatis", "Pasta", "Ris", "Quinoa", "Bröd", "Linser", "Bönor", "Rotfrukter"]
Tillbehor := ["Frukt", "Grönsallad", "Sås/Creme", "Tomat"]

; ### FUNCTIONS & SUBROUTINES ###
Slump(Var1, Var2, Var3)
{
	Random, Protein, 1, % Var1.MaxIndex()
	Random, Kolhydrat, 1, % Var2.MaxIndex()
	Random, Tillbehor, 1, % Var3.MaxIndex()
	return [Protein, Kolhydrat, Tillbehor]
}

RandColor()
{
loop, 6
	{
		Random, Randomnumber, 0, 9
		Color .= Randomnumber
	}
	return Color
}

MainGui(Matv)
{
	Gui, Matvecka: New
	Gui, Matvecka: Color, % RandColor()
	Gui, Matvecka: Font, s12 bold, Calibri
	Gui, Matvecka: Add, Text, cwhite, % "Veckoplanering: Mat (Vecka " SubStr(A_YWeek, 5) ", år " SubStr(A_YWeek, 1, 4) ")"
	Gui, Matvecka: Font, s12 normal, Calibri
	Gui, Matvecka: Add, Edit, w450 h210, % "---------------------------------------------`r`n" Matv
	Gui, Matvecka: Add, Button, section xm gPlaneraOm, Planera om
	Gui, Matvecka: Add, Button, ys gSpara, Spara
	Gui, Matvecka: Add, Button, ys gAvsluta, Avsluta
	Gui, Matvecka: Show, Autosize, Veckoplanering - Mat
	return
	
	PlaneraOm:
	Reload
	return
	
	Avsluta:
	MatveckaGuiClose:
	MatveckaGuiEscape:
	Exitapp
}

; ### APPLICATION ###
Loop, % Weekdays.MaxIndex()
{
	Test := Slump(Protein, Kolhydrat, Tillbehor)
	Matvecka .= Weekdays[A_Index] ": " Protein[Test[1]] " med " format("{:L}", Kolhydrat[Test[2]]) " samt " format("{:L}", Tillbehor[Test[3]]) "`r`n"
}
Matvecka .= "---------------------------------------------`r`n"
MainGui(Matvecka)
return

Spara:
Gui, Matvecka: Submit, NoHide
FileSelectFile, Sav, S, A_MyDocuments\Matvecka_%A_YWeek%.txt, "Spara veckoplanering", (Text *.txt)
FileAppend, % Matvecka, % Sav
return