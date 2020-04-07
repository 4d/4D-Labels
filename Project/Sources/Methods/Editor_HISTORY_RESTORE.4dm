//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_HISTORY_RESTORE
  // Database: 4D Labels
  // ID[3973EFB55CD44BB58D3A4C68B34010E1]
  // Created #18-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_count;$Lon_historySize;$Lon_i;$Lon_parameters;$Lon_restoreIndex)
C_POINTER:C301($Ptr_history)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_object;$Txt_buffer;$Txt_ID;$Txt_type)
C_OBJECT:C1216($Obj_dialog)

ARRAY TEXT:C222($tTxt_selected;0)

If (False:C215)
	C_LONGINT:C283(Editor_HISTORY_RESTORE ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Lon_restoreIndex:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	$Dom_canvas:=OB Get:C1224($Obj_dialog;"canvas";Is text:K8:3)
	
	If (OB Is defined:C1231($Obj_dialog;"history-index"))
		
		$Lon_historySize:=OB Get:C1224($Obj_dialog;"history-index";Is longint:K8:6)
		
	End if 
	
	$Ptr_history:=OBJECT Get pointer:C1124(Object named:K67:5;"history_array")
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_restoreIndex>0)\
 & ($Lon_restoreIndex<=$Lon_historySize)\
 & ($Lon_restoreIndex#$Lon_historySize)
	
	OB SET:C1220($Obj_dialog;\
		"history-index";$Lon_restoreIndex)
	
	ASSERT:C1129(DEBUG_Update ("history";$Lon_restoreIndex))
	
	LISTBOX SELECT ROW:C912(*;"Debug_HistoryList";$Lon_restoreIndex;lk replace selection:K53:1)
	
	  //%W-533.3
	$Txt_buffer:=$Ptr_history->{$Lon_restoreIndex}
	  //%W+533.3
	
	$Dom_label:=DOM Parse XML variable:C720($Txt_buffer)
	
	Editor_ON_DATA_CHANGE (True:C214)
	
	$Lon_count:=Editor_SEL_Get_count ($Dom_label;->$tTxt_selected)
	
	For ($Lon_i;1;$Lon_count;1)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($tTxt_selected{$Lon_i};"object-id";$Txt_ID)
		DOM REMOVE XML ELEMENT:C869($tTxt_selected{$Lon_i})
		
		$tTxt_selected{$Lon_i}:=$Txt_ID
		
	End for 
	
	For ($Lon_i;1;$Lon_count;1)
		
		$Dom_object:=DOM Find XML element by ID:C1010($Dom_canvas;$tTxt_selected{$Lon_i})
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"editor:object-type";$Txt_type)
		
		Editor_SELECT_OBJECT ($Dom_object;$tTxt_selected{$Lon_i})
		
	End for 
	
	Editor_UPDATE_UI 
	
	Editor_REDRAW 
	
	CALL SUBFORM CONTAINER:C1086(-103)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End