//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SET_STROKE_WIDTH
  // Database: 4D Labels
  // ID[7C2250E950484A8B85ED5CE8E1B367B1]
  // Created #26-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_;$Lon_parameters;$Lon_width)
C_TEXT:C284($Txt_name)

If (False:C215)
	C_LONGINT:C283(Editor_SET_STROKE_WIDTH ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_width:=$1
		
	Else 
		
		$Lon_width:=1
		
		  //bond the button to the dynamic image
		RESOLVE POINTER:C394(OBJECT Get pointer:C1124(Object named:K67:5;"stroke-width");$Txt_name;$Lon_;$Lon_)
		OBJECT SET FORMAT:C236(*;"action.stroke-width";";!"+$Txt_name)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //keep current value
OB SET:C1220((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;\
"stroke-width";$Lon_width)

  //update UI
Editor_UPDATE_TOOL ("stroke-width";$Lon_width)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End