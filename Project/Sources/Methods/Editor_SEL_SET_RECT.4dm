//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_SET_RECT
  // Database: 4D Labels
  // ID[03AAF6F1A27A4EBD9EDDDCA62697ACF5]
  // Created #5-10-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($Boo_redraw)
C_LONGINT:C283($Lon_i;$Lon_parameters)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_object;$Txt_buffer;$Txt_ID;$Txt_target)
C_TEXT:C284($Txt_type)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_SET_RECT ;$1)
	C_TEXT:C284(Editor_SEL_SET_RECT ;$2)
	C_TEXT:C284(Editor_SEL_SET_RECT ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  // Required parameters
	$Txt_type:=$1  // Rect | round-rect
	
	  // Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$2
		
		If ($Lon_parameters>=3)
			
			$Dom_canvas:=$3
			
		End if 
	End if 
	
	$Txt_target:=Choose:C955($Txt_type="rect";"round-rect";"rect")
	
	If (Length:C16($Dom_label)=0)
		
		$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
		
	End if 
	
	If (Length:C16($Dom_canvas)=0)
		
		$Dom_canvas:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"canvas";Is text:K8:3)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	
	$Dom_object:=DOM Find XML element by ID:C1010($Dom_label;$Txt_ID)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"type";$Txt_buffer)
	
	If ($Txt_buffer=$Txt_target)
		
		$Boo_redraw:=True:C214
		
		DOM SET XML ATTRIBUTE:C866($Dom_object;\
			"type";$Txt_type)
		
		  // #ACI0100054 {
		If ($Txt_type="round-rect")
			
			DOM SET XML ATTRIBUTE:C866($Dom_object;\
				"rx";Num:C11(<>label_params.defaultRoundRect);\
				"ry";Num:C11(<>label_params.defaultRoundRect))
			
		Else 
			
			DOM SET XML ATTRIBUTE:C866($Dom_object;\
				"rx";0;\
				"ry";0)
			
		End if   //}
	End if 
End for 

If ($Boo_redraw)
	
	Editor_ON_RESIZE 
	Editor_UPDATE 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End