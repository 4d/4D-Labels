//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : IFF_Get_short
// Database: 4D Labels
// ID[507874FFF4564F248D4A6F4999F55262]
// Created #18-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Integer
var $1 : Pointer
var $2 : Pointer
var $3 : Integer

var $Lon_byteOrder; $Lon_parameters; $Lon_short : Integer
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
	
	$Lon_byteOrder:=PC byte ordering:K22:3
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		$Lon_byteOrder:=$3  //{byte ordering} default PC byte ordering
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Lon_short:=BLOB to integer:C549($Ptr_source->; $Lon_byteOrder; $Ptr_offset->)

// ----------------------------------------------------
// Return
$0:=$Lon_short

// ----------------------------------------------------
// End