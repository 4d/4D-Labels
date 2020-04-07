//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_MOVE
  // Database: 4D Labels
  // ID[16FDC62C28D84981BCD2F18B3766D5B2]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_redraw)
C_LONGINT:C283($Lon_i;$Lon_moveX;$Lon_moveY;$Lon_parameters)
C_TEXT:C284($Dom_canvas;$Dom_label;$Txt_ID)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_LONGINT:C283(Editor_SEL_MOVE ;$1)
	C_LONGINT:C283(Editor_SEL_MOVE ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Lon_moveX:=$1
	$Lon_moveY:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
	Editor_Get_grips (->$Dom_label;->$Dom_canvas)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	$Boo_redraw:=$Boo_redraw | Editor_SELECT_Move ($Txt_ID;$Lon_moveX;$Lon_moveY;True:C214)
	
End for 

If ($Boo_redraw)
	
	Editor_ON_RESIZE 
	
	Editor_UPDATE 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End