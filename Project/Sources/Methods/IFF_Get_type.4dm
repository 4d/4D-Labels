//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : IFF_Get_type
// Database: 4D Labels
// ID[DA9C6935676C49E089961728442C64D5]
// Created #18-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Text
var $1 : Pointer
var $2 : Pointer

var $Lon_parameters : Integer
var $Ptr_offset; $Ptr_source : Pointer
var $Txt_type : Text

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
$Txt_type:=BLOB to text:C555($Ptr_source->; Mac text without length:K22:10; $Ptr_offset->; 4)

//Byte-swapping
$Txt_type:=$Txt_type[[4]]+$Txt_type[[3]]+$Txt_type[[2]]+$Txt_type[[1]]

// ----------------------------------------------------
// Return
$0:=$Txt_type

// ----------------------------------------------------
// End