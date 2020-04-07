//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_SET_ASPECT_RATIO
  // Database: 4D Labels
  // ID[40069BB08A824A929C3FCBEC33B64A0C]
  // Created #20-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($Boo_buffer;$Boo_preserve;$Boo_redraw)
C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_type)
C_TEXT:C284($Dom_canvas;$Dom_label;$Dom_object;$Txt_buffer;$Txt_ID;$Txt_preserve)
C_TEXT:C284($Txt_type)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_SET_ASPECT_RATIO ;$1)
	C_TEXT:C284(Editor_SEL_SET_ASPECT_RATIO ;$2)
	C_TEXT:C284(Editor_SEL_SET_ASPECT_RATIO ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_preserve:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$2
		
		If ($Lon_parameters>=3)
			
			$Dom_canvas:=$3
			
		End if 
	End if 
	
	Editor_Get_grips (->$Dom_label;->$Dom_canvas)
	
	$Boo_preserve:=($Txt_preserve="true")
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	
	$Dom_object:=DOM Find XML element by ID:C1010($Dom_label;$Txt_ID)
	DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"type";$Txt_type)
	
	Case of 
			
			  //________________________________________
		: ($Txt_type="image")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"preserve-aspect-ratio";$Txt_buffer)
			
			If ($Txt_preserve#$Txt_buffer)
				
				  //update label
				DOM SET XML ATTRIBUTE:C866($Dom_object;\
					"preserve-aspect-ratio";$Txt_preserve)
				
				  //update image
				$Dom_object:=DOM Find XML element by ID:C1010($Dom_canvas;$Txt_ID+"-image")
				DOM SET XML ATTRIBUTE:C866($Dom_object;\
					"preserveAspectRatio";Choose:C955($Boo_preserve;"xMidYMid";"none"))
				
				$Boo_redraw:=True:C214
				
			End if 
			
			  //________________________________________
		: ($Txt_type="variable")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"field-type";$Lon_type)
			
			If ($Lon_type=Is picture:K8:10)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"preserve-aspect-ratio";$Boo_buffer)
				
				If ($Boo_preserve#$Boo_buffer)
					
					  //update image
					DOM SET XML ATTRIBUTE:C866($Dom_object;\
						"preserve-aspect-ratio";$Boo_preserve)
					
					$Boo_redraw:=True:C214
					
				End if 
			End if 
			
			  //________________________________________
	End case 
End for 

If ($Boo_redraw)
	
	Editor_UPDATE 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End