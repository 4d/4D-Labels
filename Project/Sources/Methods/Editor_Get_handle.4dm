//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_Get_handle
  // Database: 4D Labels
  // ID[55F016B5ED764C3EA1372098F986D7E6]
  // Created #7-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_handleID)
C_OBJECT:C1216($Obj_dialog)

If (False:C215)
	C_TEXT:C284(Editor_Get_handle ;$0)
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
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Txt_handleID:=OB Get:C1224($Obj_dialog;"handle";Is text:K8:3)

  // ----------------------------------------------------
  // Return
$0:=$Txt_handleID

  // ----------------------------------------------------
  // End