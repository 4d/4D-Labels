//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : IFF_FILLER
// Database: 4D Labels
// ID[8C28B7B4F36C4F90BBDC995D29D1A2E8]
// Created #18-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Integer
var $2 : Pointer

var $Lon_padding; $Lon_parameters : Integer
var $Ptr_offset : Pointer

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Lon_padding:=$1
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))
	ASSERT:C1129(Type:C295($2->)=Is longint:K8:6)
	
	$Ptr_offset:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Ptr_offset->:=$Ptr_offset->+$Lon_padding

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End