//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_Get_text_align
  // Database: 4D Labels
  // ID[4662CFAB755C4DBDA9D17FBA216B7574]
  // Created #21-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_image;$Boo_text)
C_LONGINT:C283($Lon_i;$Lon_parameters)
C_TEXT:C284($Dom_label;$Dom_object;$Txt_alignment;$Txt_ID;$Txt_value)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_Get_text_align ;$0)
	C_TEXT:C284(Editor_SEL_Get_text_align ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Dom_label:=$1
		
	Else 
		
		Editor_Get_grips (->$Dom_label)
		
	End if 
	
	$Txt_alignment:="-"  //missing
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected))
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	
	$Dom_object:=Editor_OB_Get_type ($Dom_label;$Txt_ID;->$Boo_text;->$Boo_image)
	
	If ($Boo_text)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"alignment";$Txt_value)
		
		If ($Txt_alignment="-")
			
			  //first one
			$Txt_alignment:=$Txt_value
			
		Else 
			
			If ($Txt_alignment#$Txt_value)
				
				$Txt_alignment:="-"  //mixed
				$Lon_i:=MAXLONG:K35:2-1  //stop
				
			End if 
		End if 
	End if 
End for 

  // ----------------------------------------------------
  // Return
$0:=$Txt_alignment

  // ----------------------------------------------------
  // End