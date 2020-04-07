//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_Get_font_color
  // Database: 4D Labels
  // ID[87FD1DB0C6E742278165AE9281CB8E40]
  // Created #25-8-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_image;$Boo_text)
C_LONGINT:C283($Lon_color;$Lon_i;$Lon_parameters;$Lon_value)
C_TEXT:C284($Dom_label;$Dom_object;$Txt_buffer;$Txt_ID;$Txt_target)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_LONGINT:C283(Editor_SEL_Get_font_color ;$0)
	C_TEXT:C284(Editor_SEL_Get_font_color ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //Required parameters
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$1
		
	Else 
		
		Editor_Get_grips (->$Dom_label)
		
	End if 
	
	$Lon_color:=-1  //missing
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	
	$Dom_object:=Editor_OB_Get_type ($Dom_label;$Txt_ID;->$Boo_text;->$Boo_image)
	
	If ($Boo_text)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-color";$Txt_buffer)
		
		$Lon_value:=Color_to_long ($Txt_buffer)
		
		If ($Lon_color=-1)
			
			  //first one
			$Lon_color:=$Lon_value
			
		Else 
			
			If ($Lon_value#$Lon_color)
				
				$Lon_color:=8858  //mixed
				$Lon_i:=MAXLONG:K35:2-1  //STOP
				
			End if 
		End if 
	End if 
End for 

If ($Lon_color=-1)  //No selection
	
	$Lon_color:=Editor_Get_color ($Txt_target)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Lon_color

  // ----------------------------------------------------
  // End