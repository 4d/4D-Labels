//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SELECT_Clear
  // Database: 4D Labels
  // ID[2F19BFFFD0A24021AE628398290770C3]
  // Created #13-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_update)
C_LONGINT:C283($Lon_i;$Lon_parameters)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_object;$Txt_ID)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_BOOLEAN:C305(Editor_SELECT_Clear ;$0)
	C_TEXT:C284(Editor_SELECT_Clear ;$1)
	C_TEXT:C284(Editor_SELECT_Clear ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$1
		$Dom_canvas:=$2
		
	Else 
		
		Editor_Get_grips (->$Dom_label;->$Dom_canvas)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	
	$Dom_object:=DOM Find XML element by ID:C1010($Dom_canvas;OB Get:C1224(<>label_params;"select-prefix";Is text:K8:3)+$Txt_ID)
	
	If (xml_IsValidReference ($Dom_object))
		
		DOM REMOVE XML ELEMENT:C869($Dom_object)
		$Boo_update:=True:C214
		
	Else 
		
		  //some objects were selected when the document was saved
		
	End if 
	
	DOM REMOVE XML ELEMENT:C869($tDom_selected{$Lon_i})
	
End for 

Editor_TOOL_SET_ENABLED (False:C215)

  // ----------------------------------------------------
  // Return
$0:=$Boo_update

  // ----------------------------------------------------
  // End