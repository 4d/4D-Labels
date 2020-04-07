//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SET_FONT_COLOR
  // Database: 4D Labels
  // ID[25E3C56EF76942FBAE2DE9BF0FFC8ED6]
  // Created #27-8-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_;$Lon_color;$Lon_parameters)
C_TEXT:C284($Txt_name)

If (False:C215)
	C_LONGINT:C283(Editor_SET_FONT_COLOR ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_color:=$1
		
	Else 
		
		$Lon_color:=1  //default is black
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //keep current value
OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;\
"font-color";$Lon_color)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End