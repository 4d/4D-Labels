//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SEL_SET_FONT
// Database: 4D Labels
// ID[1669C5ECF9D845458FA086A7F32CB7C2]
// Created #18-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($Boo_image; $Boo_redraw; $Boo_text)
C_LONGINT:C283($Lon_i; $Lon_parameters)
C_TEXT:C284($Dom_canvas; $Dom_label; $Dom_object; $Dom_style; $Txt_; $Txt_buffer)
C_TEXT:C284($Txt_class; $Txt_data; $Txt_font; $Txt_fontFamily; $Txt_object_id)

ARRAY LONGINT:C221($tLon_length; 0)
ARRAY LONGINT:C221($tLon_position; 0)
ARRAY TEXT:C222($selects; 0)
ARRAY TEXT:C222($tDom_selected; 0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_SET_FONT; $1)
	C_TEXT:C284(Editor_SEL_SET_FONT; $2)
	C_TEXT:C284(Editor_SEL_SET_FONT; $3)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_font:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$2
		
		If ($Lon_parameters>=3)
			
			$Dom_canvas:=$3
			
		End if 
	End if 
	
	Editor_Get_grips(->$Dom_label; ->$Dom_canvas)
	
	If ($Txt_font=Get localized string:C991("Menus_systemFont"))
		
		$Txt_font:=OBJECT Get font:C1069(*; "AutoFont")
		
	End if 
	
	$Txt_fontFamily:="'"+$Txt_font+"'"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 1; Editor_SEL_Get_count($Dom_label; ->$tDom_selected); 1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i}; "object-id"; $Txt_object_id)
	
	$Dom_object:=Editor_OB_Get_type($Dom_label; $Txt_object_id; ->$Boo_text; ->$Boo_image)
	
	$Txt_class:=OB Get:C1224(<>label_params; "classPrefix"; Is text:K8:3)+$Txt_object_id+"-textArea"
	
	If ($Boo_text)
		
		$Dom_style:=DOM Find XML element by ID:C1010($Dom_canvas; $Txt_class)
		
		If (OK=1)  //is an object with style
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "font-name"; $Txt_buffer)
			
			If ($Txt_buffer#$Txt_fontFamily)
				
				DOM GET XML ELEMENT VALUE:C731($Dom_style; $Txt_; $Txt_data)  //CDATA
				
				If (Match regex:C1019("(?m)(.*font-family:)([^;}]+)(;*.*)"; $Txt_data; 1; $tLon_position; $tLon_length))
					
					$Txt_data:=Substring:C12($Txt_data; $tLon_position{1}; $tLon_length{1})+$Txt_fontFamily+Substring:C12($Txt_data; $tLon_position{3}; $tLon_length{3})
					
					DOM SET XML ELEMENT VALUE:C868($Dom_style; $Txt_data; *)
					
				End if 
				
				//#ACI0100864
				DOM SET XML ATTRIBUTE:C866($Dom_object; \
					"font-name"; str_Single_quote($Txt_font))
				
				$Boo_redraw:=True:C214
				
			End if 
		End if 
	End if 
End for 

If ($Boo_redraw)
	
	OBJECT SET FONT:C164(*; "picker"; $Txt_font)
	
	Editor_UPDATE
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End