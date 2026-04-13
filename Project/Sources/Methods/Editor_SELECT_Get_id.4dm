//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SELECT_Get_id
// Database: 4D Labels
// ID[9D34E1CD4A624224AD22AEBA8E6BEAB5]
// Created #17-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Text
var $1 : Text
var $2 : Integer

var $Lon_index; $Lon_parameters : Integer
var $Dom_label; $Dom_object; $Dom_selects; $Txt_buffer; $Txt_ID : Text
// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Dom_label:=$1
	$Lon_index:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Dom_selects:=DOM Find XML element by ID:C1010($Dom_label; "selects")
$Dom_object:=DOM Get XML element:C725($Dom_selects; "select"; $Lon_index; $Txt_buffer)
DOM GET XML ATTRIBUTE BY NAME:C728($Dom_object; "object-id"; $Txt_ID)

// ----------------------------------------------------
// Return
$0:=$Txt_ID

// ----------------------------------------------------
// End