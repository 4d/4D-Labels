//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_SET_COLOR
  // Database: 4D Labels
  // ID[1AB3A10343204D628164071DB7B932B0]
  // Created #6-1-2015 by Vincent de Lachaux
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
C_LONGINT:C283($Lon_color;$Lon_i;$Lon_parameters)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_object;$Dom_style;$Txt_;$Txt_buffer)
C_TEXT:C284($Txt_class;$Txt_color;$Txt_current;$Txt_data;$Txt_keepTarget;$Txt_object_id)
C_TEXT:C284($Txt_opacity;$Txt_target)

ARRAY LONGINT:C221($tLon_length;0)
ARRAY LONGINT:C221($tLon_position;0)
ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_SET_COLOR ;$1)
	C_LONGINT:C283(Editor_SEL_SET_COLOR ;$2)
	C_TEXT:C284(Editor_SEL_SET_COLOR ;$3)
	C_TEXT:C284(Editor_SEL_SET_COLOR ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Txt_target:=$1  //fill | stroke
	$Lon_color:=$2
	
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
	
	$Txt_color:=Color_from_long ($Lon_color;$Txt_target)
	
	$Txt_keepTarget:=$Txt_target
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_object_id)
	
	$Dom_object:=Editor_OB_Get_type ($Dom_label;$Txt_object_id;->$Boo_text;->$Boo_image)
	
	If (Not:C34($Boo_image))\
		 & (Not:C34($Boo_text))
		
		$Txt_target:=$Txt_keepTarget
		
		If ($Txt_target="stroke")
			
			$Txt_class:=OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_object_id+Choose:C955($Boo_text;"-textArea";"")
			$Txt_target:=Choose:C955($Boo_text;"fill";"stroke")
			
		Else 
			
			$Txt_class:=OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_object_id+Choose:C955($Boo_text;"-rect";"")
			
		End if 
		
		$Dom_style:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_class)
		
		If (OK=1)  //is an object with style
			
			DOM GET XML ELEMENT VALUE:C731($Dom_style;$Txt_;$Txt_data)  //CDATA
			
			If (Match regex:C1019("(?m)(.*"+$Txt_target+":)([^;}]+)(;?.*)";$Txt_data;1;$tLon_position;$tLon_length))
				
				$Txt_current:=Substring:C12($Txt_data;$tLon_position{2};$tLon_length{2})
				
				If ($Txt_current#$Txt_color)
					
					$Txt_data:=Substring:C12($Txt_data;$tLon_position{1};$tLon_length{1})+$Txt_color+Substring:C12($Txt_data;$tLon_position{3};$tLon_length{3})
					
					  //set opacity to 100% if undefined
					If (Match regex:C1019("(?m)(.*"+$Txt_target+"-opacity:)([^;]+)(;?.*)";$Txt_data;1;$tLon_position;$tLon_length))
						
						$Txt_buffer:=Substring:C12($Txt_data;$tLon_position{2};$tLon_length{2})
						$Txt_opacity:=Choose:C955($Txt_buffer="";"1";$Txt_buffer)
						
						$Txt_data:=Substring:C12($Txt_data;$tLon_position{1};$tLon_length{1})+$Txt_opacity+Substring:C12($Txt_data;$tLon_position{3};$tLon_length{3})
						
					End if 
				End if 
				
				DOM SET XML ELEMENT VALUE:C868($Dom_style;$Txt_data;*)
				
				If ($Boo_text)
					
					$Txt_class:=OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_object_id+"-rect"
					
					$Dom_style:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_class)
					
					DOM GET XML ELEMENT VALUE:C731($Dom_style;$Txt_;$Txt_data)  //CDATA
					
					If (Match regex:C1019("(?m)(.*stroke:)([^;}]+)(;?.*)";$Txt_data;1;$tLon_position;$tLon_length))
						
						$Txt_data:=Substring:C12($Txt_data;$tLon_position{1};$tLon_length{1})+$Txt_color+Substring:C12($Txt_data;$tLon_position{3};$tLon_length{3})
						
						DOM SET XML ELEMENT VALUE:C868($Dom_style;$Txt_data;*)
						
					End if 
				End if 
				
				DOM SET XML ATTRIBUTE:C866($Dom_object;\
					$Txt_target+"-opacity";$Txt_opacity;\
					Choose:C955($Txt_keepTarget="stroke";"stroke-color";"fill-color");\
					$Txt_color)
				
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