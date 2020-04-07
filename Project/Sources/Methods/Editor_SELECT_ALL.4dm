//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_ALL
  // Database: 4D Labels
  // ID[9D41A817C4CB4FC1B3321B6CA127F05D]
  // Created #13-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_update)
C_LONGINT:C283($Lon_i;$Lon_parameters)
C_POINTER:C301($Ptr_container)
C_TEXT:C284($Dom_buffer;$Dom_canvas;$Txt_ID)
C_OBJECT:C1216($Obj_parameters)

ARRAY TEXT:C222($tDom_objects;0)
ARRAY TEXT:C222($tTxt_selected;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)
	
	$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->
	$Dom_canvas:=OB Get:C1224($Obj_parameters;"canvas";Is text:K8:3)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Editor_SELECT_GET_LIST ($Ptr_container->;->$tTxt_selected;True:C214)

$Dom_buffer:=DOM Find XML element by ID:C1010($Ptr_container->;"objects")
$tDom_objects{0}:=DOM Find XML element:C864($Dom_buffer;"objects/object";$tDom_objects)

For ($Lon_i;1;Size of array:C274($tDom_objects);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_objects{$Lon_i};"id";$Txt_ID)
	
	If ($Txt_ID#"select@")
		
		If (Editor_Is_object ($Txt_ID))
			
			Editor_SELECT_Add ($Txt_ID;True:C214)
			$Boo_update:=$Boo_update | (Find in array:C230($tTxt_selected;$Txt_ID)=-1)
			
		End if 
	End if 
End for 

If ($Boo_update)
	
	Editor_UPDATE_UI 
	
	Editor_REDRAW 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End