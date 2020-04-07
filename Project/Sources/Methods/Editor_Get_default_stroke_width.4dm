//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_Get_default_stroke_width
  // Database: 4D Labels
  // ID[ECCC36EE3033427BA0608AF16896E72F]
  // Created #26-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)

C_LONGINT:C283($Lon_parameters;$Lon_value)

If (False:C215)
	C_LONGINT:C283(Editor_Get_default_stroke_width ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_value:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"stroke-width";Is longint:K8:6)

  // ----------------------------------------------------
  // Return
$0:=$Lon_value

  // ----------------------------------------------------
  // End