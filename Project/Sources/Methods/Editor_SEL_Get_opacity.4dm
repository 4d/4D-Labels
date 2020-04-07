//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Editor_SEL_Get_opacity
  // Database: 4D Labels
  // ID[24BAA1E686514D0EA474B84A8C32CC21]
  // Created #20-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_REAL:C285($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_image;$Boo_text)
C_LONGINT:C283($Lon_i;$Lon_parameters)
C_REAL:C285($Num_buffer;$Num_opacity)
C_TEXT:C284($Dom_label;$Dom_object;$Txt_ID;$Txt_target)

ARRAY TEXT:C222($tDom_selected;0)

If (False:C215)
	C_REAL:C285(Editor_SEL_Get_opacity ;$0)
	C_TEXT:C284(Editor_SEL_Get_opacity ;$1)
	C_TEXT:C284(Editor_SEL_Get_opacity ;$2)
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
	
	$Num_opacity:=-1  //missing
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

For ($Lon_i;1;Editor_SEL_Get_count ($Dom_label;->$tDom_selected);1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i};"object-id";$Txt_ID)
	
	$Dom_object:=Editor_OB_Get_type ($Dom_label;$Txt_ID;->$Boo_text;->$Boo_image)
	
	If (Not:C34($Boo_image))
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object;$Txt_target+"-opacity";$Num_buffer)
		
		If ($Num_opacity=-1)
			
			  //first one
			$Num_opacity:=$Num_buffer
			
		Else 
			
			If ($Num_buffer#$Num_opacity)
				
				$Num_opacity:=8858  //mixed
				$Lon_i:=MAXLONG:K35:2-1  //STOP
				
			End if 
		End if 
	End if 
End for 

$Num_opacity:=Choose:C955($Num_opacity<0;1;$Num_opacity)  //1 if missing

  // ----------------------------------------------------
  // Return
$0:=$Num_opacity

  // ----------------------------------------------------
  // End