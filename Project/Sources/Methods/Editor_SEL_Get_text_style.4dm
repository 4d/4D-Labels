//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_Get_text_style
  // Database: 4D Labels
  // ID[D9A60862DC3644EEAD4A8F56AEA493BE]
  // Created #19-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_image;$Boo_text)
C_LONGINT:C283($Lon_i;$Lon_parameters)
C_TEXT:C284($Dom_label;$Dom_object;$Txt_buffer;$Txt_ID;$Txt_style)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_TEXT:C284(Editor_SEL_Get_text_style ;$0)
	C_TEXT:C284(Editor_SEL_Get_text_style ;$1)
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
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected))
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	
	$Dom_object:=Editor_OB_Get_type ($Dom_label;$Txt_ID;->$Boo_text;->$Boo_image)
	
	If ($Boo_text)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"style";$Txt_buffer)
		
		If (Length:C16($Txt_style)=0)
			
			  //first one
			$Txt_style:=$Txt_buffer
			
		Else 
			
			If ($Txt_buffer#$Txt_style)
				
				$Txt_style:=""  //mixed
				$Lon_i:=MAXLONG:K35:2-1  //stop
				
			End if 
		End if 
	End if 
End for 

  // ----------------------------------------------------
  // Return
$0:=$Txt_style

  // ----------------------------------------------------
  // End