//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_HISTORY_FORWARD
  // Database: 4D Labels
  // ID[B83C35A30B0F46D5AFEE20B71D4890ED]
  // Created #18-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_historySize;$Lon_parameters)
C_OBJECT:C1216($Obj_dialog)

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
If (OB Is defined:C1231($Obj_dialog;"history-index"))
	
	$Lon_historySize:=OB Get:C1224($Obj_dialog;"history-index";Is longint:K8:6)
	
End if 

If ($Lon_historySize>Size of array:C274((OBJECT Get pointer:C1124(Object named:K67:5;"history_array"))->))
	
	Editor_HISTORY_RESTORE ($Lon_historySize+1)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End