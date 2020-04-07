//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_SET_OPACITY
  // Database: 4D Labels
  // ID[B12D87253C78480B83BEFF4AE85BA8BA]
  // Created #4-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_BOOLEAN:C305($Boo_image;$Boo_redraw;$Boo_text)
C_LONGINT:C283($Lon_i;$Lon_parameters)
C_REAL:C285($Num_current;$Num_opacity)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_object;$Dom_style;$Txt_;$Txt_class)
C_TEXT:C284($Txt_object_id;$Txt_style;$Txt_target)

ARRAY LONGINT:C221($tLon_length;0)
ARRAY LONGINT:C221($tLon_position;0)
ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_SET_OPACITY ;$1)
	C_LONGINT:C283(Editor_SEL_SET_OPACITY ;$2)
	C_TEXT:C284(Editor_SEL_SET_OPACITY ;$3)
	C_TEXT:C284(Editor_SEL_SET_OPACITY ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Txt_target:=$1  //fill | stroke
	$Num_opacity:=$2  //0 to 100
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Dom_label:=$3
		
		If ($Lon_parameters>=4)
			
			$Dom_canvas:=$4
			
		End if 
	End if 
	
	If (Length:C16($Dom_label)=0)
		
		$Dom_label:=(OBJECT Get pointer:C1124(Object subform container:K67:4))->
		
	End if 
	
	If (Length:C16($Dom_canvas)=0)
		
		$Dom_canvas:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5;"object"))->;"canvas";Is text:K8:3)
		
	End if 
	
	$Num_opacity:=$Num_opacity/100
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_object_id)
	
	$Dom_object:=Editor_OB_Get_type ($Dom_label;$Txt_object_id;->$Boo_text;->$Boo_image)
	
	If (Not:C34($Boo_image))
		
		$Txt_class:=OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_object_id+Choose:C955($Boo_text;"-textArea";"")
		
		$Dom_style:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_class)
		
		If (OK=1)  //is an object with style
			
			DOM GET XML ELEMENT VALUE:C731($Dom_style;$Txt_;$Txt_style)  //CDATA
			
			If (Match regex:C1019("(?m)(.*"+Choose:C955($Boo_text;"fill";$Txt_target)+"-opacity:)([^;}]+)(;?.*)";$Txt_style;1;$tLon_position;$tLon_length))
				
				$Num_current:=Num:C11(Substring:C12($Txt_style;$tLon_position{2};$tLon_length{2}))
				
				If ($Num_opacity#$Num_current)
					
					  //set the style
					$Txt_style:=Substring:C12($Txt_style;$tLon_position{1};$tLon_length{1})\
						+String:C10($Num_opacity;"&xml")\
						+Substring:C12($Txt_style;$tLon_position{3};$tLon_length{3})
					
					DOM SET XML ELEMENT VALUE:C868($Dom_style;$Txt_style;*)
					
					  //set the object property
					DOM SET XML ATTRIBUTE:C866($Dom_object;\
						$Txt_target+"-opacity";$Num_opacity)
					
					$Boo_redraw:=True:C214
					
				End if 
			End if 
		End if 
	End if 
End for 

If ($Boo_redraw)
	
	Editor_UPDATE 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End