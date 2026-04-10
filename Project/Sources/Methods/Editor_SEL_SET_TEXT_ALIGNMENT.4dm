//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SEL_SET_TEXT_ALIGNMENT
// Database: 4D Labels
// ID[926844D48CB84925B134A28D8F5CA508]
// Created #21-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Text
var $2 : Text
var $3 : Text

var $Boo_image; $Boo_redraw; $Boo_text : Boolean
var $Lon_i; $Lon_parameters : Integer
var $Dom_canvas; $Dom_label; $Dom_object; $Dom_style; $Txt_; $Txt_alignment : Text
var $Txt_buffer; $Txt_class; $Txt_data; $Txt_object_id : Text

ARRAY LONGINT:C221($tLon_length; 0)
ARRAY LONGINT:C221($tLon_position; 0)
ARRAY TEXT:C222($tDom_selected; 0)


// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_alignment:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$2
		
		If ($Lon_parameters>=3)
			
			$Dom_canvas:=$3
			
		End if 
	End if 
	
	Editor_Get_grips(->$Dom_label; ->$Dom_canvas)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 1; Editor_SEL_Get_count($Dom_label; ->$tDom_selected); 1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i}; "object-id"; $Txt_object_id)
	
	$Dom_object:=Editor_OB_Get_type($Dom_label; $Txt_object_id; ->$Boo_text; ->$Boo_image)
	
	If ($Boo_text)
		
		$Txt_class:=OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_object_id+"-textArea"
		
		$Dom_style:=DOM Find XML element by ID:C1010($Dom_canvas; $Txt_class)
		
		If (OK=1)  //is an object with style
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "alignment"; $Txt_buffer)
			
			If ($Txt_buffer#$Txt_alignment)
				
				//update canvas
				DOM GET XML ELEMENT VALUE:C731($Dom_style; $Txt_; $Txt_data)  //CDATA
				
				If (Match regex:C1019("(?m)(.*text-align:)([^;}]+)(;*.*)"; $Txt_data; 1; $tLon_position; $tLon_length))
					
					$Txt_data:=Substring:C12($Txt_data; $tLon_position{1}; $tLon_length{1})+$Txt_alignment+Substring:C12($Txt_data; $tLon_position{3}; $tLon_length{3})
					
					DOM SET XML ELEMENT VALUE:C868($Dom_style; $Txt_data; *)
					
				End if 
				
				//update label
				DOM SET XML ATTRIBUTE:C866($Dom_object; \
					"alignment"; $Txt_alignment)
				
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