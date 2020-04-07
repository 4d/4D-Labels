//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_Get_zoom
  // Database: 4D Labels
  // ID[8CE001B69C3A4F0FA66C0B8D0D63F810]
  // Created #2-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_REAL:C285($0)

C_LONGINT:C283($Lon_parameters)
C_REAL:C285($Num_zoom)
C_OBJECT:C1216($Obj_dialog)

If (False:C215)
	C_REAL:C285(Editor_Get_zoom ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  //NONE
		
	End if 
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Num_zoom:=OB Get:C1224($Obj_dialog;"zoom";Is real:K8:4)

  // ----------------------------------------------------
  // Return
$0:=$Num_zoom

  // ----------------------------------------------------
  // End