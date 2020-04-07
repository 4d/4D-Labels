//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_ON_FOCUS
  // Database: 4D Labels
  // ID[15DBF99078C8415A9B2F289309DCD452]
  // Created #8-11-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_form;$Dom_label;$Txt_formName)
C_OBJECT:C1216($Obj_param)

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
$Obj_param:=(OBJECT Get pointer:C1124(Object named:K67:5;"object"))->

If (OB Is defined:C1231($Obj_param))
	
	$Dom_label:=OB Get:C1224($Obj_param;"currentDom";Is text:K8:3)
	
	If (xml_IsValidReference ($Dom_label))
		
		$Dom_form:=DOM Find XML element by ID:C1010($Dom_label;"form")
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_form;"name";$Txt_formName)
		
	End if 
End if 

Editor_SET_ENABLED (Length:C16($Txt_formName)=0)

GOTO OBJECT:C206(*;"picker")

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End