//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_Get_font_size
  // Database: 4D Labels
  // ID[FE76B784355147EA9AE5478E5B7FA7E6]
  // Created #19-5-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_text)
C_LONGINT:C283($Lon_fontSize;$Lon_i;$Lon_parameters;$Lon_value)
C_TEXT:C284($Dom_label;$Dom_object;$Txt_ID)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_LONGINT:C283(Editor_SEL_Get_font_size ;$0)
	C_TEXT:C284(Editor_SEL_Get_font_size ;$1)
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
	
	$Lon_fontSize:=-1  //missing
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected))
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	
	$Dom_object:=Editor_OB_Get_type ($Dom_label;$Txt_ID;->$Boo_text)
	
	If ($Boo_text)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;"font-size";$Lon_value)
		
		If ($Lon_fontSize=-1)
			
			  //first one
			$Lon_fontSize:=$Lon_value
			
		Else 
			
			If ($Lon_fontSize#$Lon_value)
				
				$Lon_fontSize:=8858  //mixed
				$Lon_i:=MAXLONG:K35:2-1  //STOP
				
			End if 
		End if 
	End if 
End for 

  // ----------------------------------------------------
  // Return
$0:=$Lon_fontSize

  // ----------------------------------------------------
  // End