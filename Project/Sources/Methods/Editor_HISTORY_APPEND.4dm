//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_HISTORY_APPEND
  // Database: 4D Labels
  // ID[DE86D8C8E43D4F67B473EEE4CDDE4496]
  // Created #22-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_historySize;$Lon_parameters)
C_POINTER:C301($Ptr_history)
C_TEXT:C284($Dom_label;$Txt_buffer)
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
	
	$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	
	If (OB Is defined:C1231($Obj_dialog;"history-index"))
		
		$Lon_historySize:=OB Get:C1224($Obj_dialog;"history-index";Is longint:K8:6)
		
	End if 
	
	$Ptr_history:=OBJECT Get pointer:C1124(Object named:K67:5;"history_array")
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
DOM EXPORT TO VAR:C863($Dom_label;$Txt_buffer)
APPEND TO ARRAY:C911($Ptr_history->;$Txt_buffer)

$Lon_historySize:=$Lon_historySize+1

LISTBOX SELECT ROW:C912(*;"Debug_HistoryList";$Lon_historySize;lk replace selection:K53:1)

OB SET:C1220($Obj_dialog;\
"history-index";$Lon_historySize)

ASSERT:C1129(DEBUG_Update ("history";$Lon_historySize))

CALL SUBFORM CONTAINER:C1086(-103)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End