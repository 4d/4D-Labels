//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_REDRAW
  // Database: 4D Labels
  // ID[C3CA8F260D9C47A4A1F48619EA23F7B8]
  // Created #12-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_canvas)

If (False:C215)
	C_TEXT:C284(Editor_REDRAW ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Dom_canvas:=$1
		
	End if 
	
	If (Length:C16($Dom_canvas)=0)
		
		$Dom_canvas:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"canvas";Is text:K8:3)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
SVG EXPORT TO PICTURE:C1017($Dom_canvas;(OBJECT Get pointer:C1124(Object named:K67:5;"Image"))->;Copy XML data source:K45:17)

ASSERT:C1129(DEBUG_Update ("redraw"))

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End