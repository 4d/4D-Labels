//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_GET_CLICK
  // Database: 4D Labels
  // ID[46D9F354295F4677B99AD6C3B9441C67]
  // Created #2-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_POINTER:C301($1)
C_POINTER:C301($2)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_x;$Ptr_y)
C_OBJECT:C1216($Obj_dialog)

If (False:C215)
	C_POINTER:C301(Editor_GET_CLICK ;$1)
	C_POINTER:C301(Editor_GET_CLICK ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Ptr_x:=$1
		$Ptr_y:=$2
		
	End if 
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Ptr_x->:=OB Get:C1224($Obj_dialog;"clic-x";Is longint:K8:6)
$Ptr_y->:=OB Get:C1224($Obj_dialog;"clic-y";Is longint:K8:6)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End