//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_Get_color
  // Database: 4D Labels
  // ID[3F6A53F01871480189DCDEF95B03639A]
  // Created #7-1-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_image;$Boo_text)
C_LONGINT:C283($Lon_color;$Lon_i;$Lon_parameters;$Lon_value)
C_TEXT:C284($Dom_label;$Dom_object;$Txt_buffer;$Txt_ID;$Txt_target)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_LONGINT:C283(Editor_SEL_Get_color ;$0)
	C_TEXT:C284(Editor_SEL_Get_color ;$1)
	C_TEXT:C284(Editor_SEL_Get_color ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_target:=$1  //fill | stroke
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Dom_label:=$2
		
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
	
	If (Not:C34($Boo_image))
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;Choose:C955($Txt_target="fill";"fill-color";"stroke-color");$Txt_buffer)
		
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