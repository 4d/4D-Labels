//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SEL_Get_aspect_ratio
// Database: 4D Labels
// ID[B5B2204D16DE4301B526EE372D51D04B]
// Created #20-4-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Text
var $1 : Text

var $Boo_image; $Boo_preserve; $Boo_text; $Boo_undefined; $Boo_value : Boolean
var $Lon_i; $Lon_parameters : Integer
var $Dom_label; $Dom_object; $Txt_ID; $Txt_preserve : Text

ARRAY TEXT:C222($tDom_selected; 0)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Dom_label:=$1
		
	Else 
		
		Editor_Get_grips(->$Dom_label)
		
	End if 
	
	$Boo_undefined:=True:C214
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 1; Editor_SEL_Get_count($Dom_label; ->$tDom_selected))
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i}; "object-id"; $Txt_ID)
	
	$Dom_object:=Editor_OB_Get_type($Dom_label; $Txt_ID; ->$Boo_text; ->$Boo_image)
	
	If ($Boo_image)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "preserve-aspect-ratio"; $Boo_value)
		
		$Boo_preserve:=$Boo_preserve & $Boo_value
		
		If ($Boo_undefined)
			
			//first one
			$Boo_preserve:=$Boo_value
			$Boo_undefined:=False:C215
			
		Else 
			
			If ($Boo_value#$Boo_preserve)
				
				$Boo_undefined:=True:C214  //mixed
				$Lon_i:=MAXLONG:K35:2-1  //stop
				
			End if 
		End if 
	End if 
End for 

If (Not:C34($Boo_undefined))
	
	If ($Boo_preserve)
		
		$Txt_preserve:="true"
		
	End if 
End if 

// ----------------------------------------------------
// Return
$0:=$Txt_preserve

// ----------------------------------------------------
// End