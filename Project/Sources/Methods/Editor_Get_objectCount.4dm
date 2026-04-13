//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_Get_objectCount
// Database: 4D Labels
// ID[A1CF37034F3F4C0197C7AE887BD88BC3]
// Created #18-5-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Integer
var $1 : Text

var $Lon_objectCount; $Lon_parameters : Integer
var $Dom_label : Text

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
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Lon_objectCount:=DOM Count XML elements:C726(DOM Find XML element by ID:C1010($Dom_label; "objects"); "object")

// ----------------------------------------------------
// Return
$0:=$Lon_objectCount

// ----------------------------------------------------
// End