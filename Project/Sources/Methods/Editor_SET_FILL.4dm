//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SET_FILL
  // Database: 4D Labels
  // ID[73AE19A6004048C3A9A2B01A652E5FC0]
  // Created #6-1-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_;$Lon_color;$Lon_parameters)
C_TEXT:C284($Txt_name)

If (False:C215)
	C_LONGINT:C283(Editor_SET_FILL ;$1)
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
		
		$Lon_color:=-1  //default is none
		
		  //bond the button to the dynamic image
		RESOLVE POINTER:C394(OBJECT Get pointer:C1124(Object named:K67:5;"fill");$Txt_name;$Lon_;$Lon_)
		OBJECT SET FORMAT:C236(*;"action.fill";";!"+$Txt_name)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //keep current value
OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;\
"fill";$Lon_color)

  //update UI
Editor_UPDATE_TOOL ("fill";$Lon_color)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End