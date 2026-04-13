//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_OB_Get_count
// Database: 4D Labels
// ID[60E874B2DEC248AE8F28BADEA958A1FA]
// Created #17-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Integer
var $1 : Text
var $2 : Pointer

var $Lon_count; $Lon_parameters : Integer
var $Ptr_array : Pointer
var $Dom_label : Text

ARRAY TEXT:C222($tDom_buffer; 0)


// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Dom_label:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		$Ptr_array:=$2  //populated with the DOM references if passed
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$tDom_buffer{0}:=DOM Find XML element:C864(DOM Find XML element by ID:C1010($Dom_label; "objects"); "objects/object"; $tDom_buffer)

$Lon_count:=Size of array:C274($tDom_buffer)

// ----------------------------------------------------
// Return
$0:=$Lon_count

If ($Lon_parameters>=2)
	
	//%W-518.1
	COPY ARRAY:C226($tDom_buffer; $Ptr_array->)
	//%W+518.1
	
End if 

// ----------------------------------------------------
// End