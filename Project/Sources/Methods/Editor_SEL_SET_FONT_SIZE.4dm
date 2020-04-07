//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_SET_FONT_SIZE
  // Database: 4D Labels
  // ID[B819745363314838BC61A8EFAF463A07]
  // Created #19-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($Boo_image;$Boo_redraw;$Boo_text)
C_LONGINT:C283($Lon_buffer;$Lon_fontSize;$Lon_i;$Lon_parameters;$Lon_value)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_object;$Dom_style;$Txt_;$Txt_class)
C_TEXT:C284($Txt_data;$Txt_object_id)

ARRAY LONGINT:C221($tLon_length;0)
ARRAY LONGINT:C221($tLon_position;0)
ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_LONGINT:C283(Editor_SEL_SET_FONT_SIZE ;$1)
	C_TEXT:C284(Editor_SEL_SET_FONT_SIZE ;$2)
	C_TEXT:C284(Editor_SEL_SET_FONT_SIZE ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Lon_fontSize:=$1
	
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
	
	$Txt_class:=OB Get:C1224(<>label_params;"classPrefix";Is text:K8:3)+$Txt_object_id+"-textArea"
	
	If ($Boo_text)
		
		$Dom_style:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_class)
		
		If (OK=1)  //is an object with style
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-size";$Lon_buffer)
			
			If ($Lon_buffer#$Lon_fontSize)
				
				DOM GET XML ELEMENT VALUE:C731($Dom_style;$Txt_;$Txt_data)  //CDATA
				
				If (Match regex:C1019("(?m)(.*font-size:)([^;]+)(;.*)";$Txt_data;1;$tLon_position;$tLon_length))
					
					$Lon_value:=Num:C11(Substring:C12($Txt_data;$tLon_position{2};$tLon_length{2}))
					
					If ($Lon_value#$Lon_fontSize)
						
						$Txt_data:=Substring:C12($Txt_data;$tLon_position{1};$tLon_length{1})+String:C10($Lon_fontSize)+Substring:C12($Txt_data;$tLon_position{3};$tLon_length{3})
						
						DOM SET XML ELEMENT VALUE:C868($Dom_style;$Txt_data;*)
						
						DOM SET XML ATTRIBUTE:C866($Dom_object;\
							"font-size";$Lon_fontSize)
						
						$Boo_redraw:=True:C214
						
					End if 
				End if 
			End if 
		End if 
	End if 
End for 

If ($Boo_redraw)
	
	OBJECT SET FONT SIZE:C165(*;"picker";$Lon_fontSize)
	
	Editor_UPDATE 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End