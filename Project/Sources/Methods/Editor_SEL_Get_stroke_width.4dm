//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SEL_Get_stroke_width
// Database: 4D Labels
// ID[58877801FF0D45A1B3AA284C976BA8BE]
// Created #18-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Integer
var $1 : Text

var $Boo_image; $Boo_text : Boolean
var $Lon_i; $Lon_parameters; $Lon_strokeWidth; $Lon_value : Integer
var $Dom_label; $Dom_object; $Txt_ID : Text

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
	
	$Lon_strokeWidth:=-1  //missing
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 1; Editor_SEL_Get_count($Dom_label; ->$tDom_selected); 1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i}; "object-id"; $Txt_ID)
	
	$Dom_object:=Editor_OB_Get_type($Dom_label; $Txt_ID; ->$Boo_text; ->$Boo_image)
	
	If (Not:C34($Boo_image))
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "stroke-width"; $Lon_value)
		
		If ($Lon_strokeWidth=-1)
			
			//first one
			$Lon_strokeWidth:=$Lon_value
			
		Else 
			
			If ($Lon_value#$Lon_strokeWidth)
				
				$Lon_strokeWidth:=8858  //mixed
				$Lon_i:=MAXLONG:K35:2-1  //STOP
				
			End if 
		End if 
	End if 
End for 

If ($Lon_strokeWidth<0)
	
	$Lon_strokeWidth:=Editor_Get_default_stroke_width
	
End if 

// ----------------------------------------------------
// Return
$0:=$Lon_strokeWidth

// ----------------------------------------------------
// End