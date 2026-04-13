//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SELECT_Find
// Database: 4D Labels
// ID[4B713DC79AF6429DA26BFE1D7C37DECD]
// Created #20-4-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Boolean
var $1 : Text
var $2 : Text

var $Boo_selected : Boolean
var $Lon_i; $Lon_parameters : Integer
var $Dom_label; $Txt_buffer; $Txt_ID : Text

ARRAY TEXT:C222($tDom_selected; 0)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Dom_label:=$1
	$Txt_ID:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 1; Editor_SEL_Get_count($Dom_label; ->$tDom_selected); 1)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($tDom_selected{$Lon_i}; "object-id"; $Txt_buffer)
	
	If ($Txt_buffer=$Txt_ID)
		
		$Boo_selected:=True:C214
		$Lon_i:=MAXLONG:K35:2-1
		
	End if 
End for 

// ----------------------------------------------------
// Return
$0:=$Boo_selected

// ----------------------------------------------------
// End