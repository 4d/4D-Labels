//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : IFF_PAD_CHUNK
// Database: 4D Labels
// ID[5978A162135E4650944C228B6F507AE5]
// Created #18-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Pointer

var $Lon_parameters : Integer
var $Ptr_offset : Pointer
// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	ASSERT:C1129(Not:C34(Is nil pointer:C315($1)))
	ASSERT:C1129(Type:C295($1->)=Is longint:K8:6)
	
	$Ptr_offset:=$1  //offset Ptr
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Ptr_offset->%2#0)
	
	$Ptr_offset->:=$Ptr_offset->+1
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End