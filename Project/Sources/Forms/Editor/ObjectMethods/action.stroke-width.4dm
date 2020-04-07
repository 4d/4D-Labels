C_LONGINT:C283($Lon_current;$Lon_width)
C_TEXT:C284($Mnu_pop;$Txt_choice)

  //get current color
$Lon_current:=Editor_Get_default_stroke_width 

  //display menu
$Mnu_pop:=Editor_MENU_STROKE_WIDTH 
$Txt_choice:=Dynamic pop up menu:C1006($Mnu_pop;String:C10($Lon_current))
RELEASE MENU:C978($Mnu_pop)

If (Length:C16($Txt_choice)>0)
	
	  //update selected objects if any
	$Lon_width:=Num:C11(Replace string:C233($Txt_choice;"stroke-width-";"";*))
	
	If ($Lon_width#$Lon_current)
		
		Editor_SEL_SET_STROKE_WIDTH ($Lon_width)
		
		  //update UI
		Editor_SET_STROKE_WIDTH ($Lon_width)
		
	End if 
End if 