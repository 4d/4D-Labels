//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_HISTORY_CLEAR
  // Database: 4D Labels
  // ID[9F4A17818DE24E13BD837CBA9329F6D9]
  // Created #18-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_history)
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
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Ptr_history:=OBJECT Get pointer:C1124(Object named:K67:5;"history_array")
CLEAR VARIABLE:C89($Ptr_history->)

OB SET:C1220($Obj_dialog;\
"history-index";0)

ASSERT:C1129(DEBUG_Update ("history";0))

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End