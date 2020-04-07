//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_SET_STROKE_WIDTH
  // Database: 4D Labels
  // ID[5049EAB63AB44640B484007602403C86]
  // Created #5-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($Boo_image;$Boo_redraw;$Boo_text)
C_LONGINT:C283($Lon_current;$Lon_i;$Lon_parameters;$Lon_width)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_object;$Dom_style;$Txt_;$Txt_class)
C_TEXT:C284($Txt_data;$Txt_object_id)

ARRAY LONGINT:C221($tLon_length;0)
ARRAY LONGINT:C221($tLon_position;0)
ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_LONGINT:C283(Editor_SEL_SET_STROKE_WIDTH ;$1)
	C_TEXT:C284(Editor_SEL_SET_STROKE_WIDTH ;$2)
	C_TEXT:C284(Editor_SEL_SET_STROKE_WIDTH ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Lon_width:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$2
		
		If ($Lon_parameters>=3)
			
			$Dom_canvas:=$3
			
		End if 
	End if 
	
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
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_object_id)
	
	$Dom_object:=Editor_OB_Get_type ($Dom_label;$Txt_object_id;->$Boo_text;->$Boo_image)
	
	If (Not:C34($Boo_image) & Not:C34($Boo_text))
		
		$Txt_class:=OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_object_id+Choose:C955($Boo_text;"-rect";"")
		
		$Dom_style:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_class)
		
		If (OK=1)  //is an object with style
			
			DOM GET XML ELEMENT VALUE:C731($Dom_style;$Txt_;$Txt_data)  //CDATA
			
			If (Match regex:C1019("(?m)(.*stroke-width:)([^;}]+)(;?.*)";$Txt_data;1;$tLon_position;$tLon_length))
				
				$Lon_current:=Num:C11(Substring:C12($Txt_data;$tLon_position{2};$tLon_length{2}))
				
				If ($Lon_current#$Lon_width)
					
					  //set the style
					$Txt_data:=Substring:C12($Txt_data;$tLon_position{1};$tLon_length{1})\
						+String:C10($Lon_width)\
						+Substring:C12($Txt_data;$tLon_position{3};$tLon_length{3})
					
				End if 
				
				DOM SET XML ELEMENT VALUE:C868($Dom_style;$Txt_data;*)
				
				  //set the object property
				DOM SET XML ATTRIBUTE:C866($Dom_object;\
					"stroke-width";$Lon_width)
				
				$Boo_redraw:=True:C214
				
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