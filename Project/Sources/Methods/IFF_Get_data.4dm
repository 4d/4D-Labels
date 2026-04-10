//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : IFF_Get_data
// Database: 4D Labels
// ID[6E8485BE2A724C588C167EFD9FBCC3DF]
// Created #18-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Blob
var $1 : Pointer
var $2 : Pointer

var $Blb_data : Blob
var $Lon_length; $Lon_parameters : Integer
var $Ptr_offset; $Ptr_source : Pointer

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	ASSERT:C1129(Not:C34(Is nil pointer:C315($1)))
	ASSERT:C1129(Type:C295($1->)=Is BLOB:K8:12)
	
	$Ptr_source:=$1  //BLOB Ptr
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))
	ASSERT:C1129(Type:C295($2->)=Is longint:K8:6)
	
	$Ptr_offset:=$2  //offset Ptr
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Lon_length:=IFF_Get_long($Ptr_source; $Ptr_offset)
COPY BLOB:C558($Ptr_source->; $Blb_data; $Ptr_offset->; 0; $Lon_length)

$Ptr_offset->:=$Ptr_offset->+$Lon_length

// ----------------------------------------------------
// Return
$0:=$Blb_data

// ----------------------------------------------------
// End