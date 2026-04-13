//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : IFF_Is_group
// Database: 4D Labels
// ID[764BB91729F84F4CA99A5E5280823290]
// Created #18-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Boolean
var $1 : Text
var $2 : Pointer
var $3 : Pointer

var $Boo_isGroup : Boolean
var $Lon_parameters : Integer
var $Ptr_offset; $Ptr_source : Pointer
var $Txt_buffer; $Txt_type : Text
// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3; "Missing parameter"))
	
	//Required parameters
	ASSERT:C1129(Length:C16($1)=4)
	$Txt_type:=$1
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))
	ASSERT:C1129(Type:C295($2->)=Is BLOB:K8:12)
	
	$Ptr_source:=$2  //BLOB Ptr
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($3)))
	ASSERT:C1129(Type:C295($3->)=Is longint:K8:6)
	
	$Ptr_offset:=$3  //offset Ptr
	
	//Optional parameters
	If ($Lon_parameters>=4)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Txt_buffer:=BLOB to text:C555($Ptr_source->; Mac text without length:K22:10; $Ptr_offset->; 4)

$Boo_isGroup:=($Txt_buffer[[1]]=$Txt_type[[4]])\
 & ($Txt_buffer[[2]]=$Txt_type[[3]])\
 & ($Txt_buffer[[3]]=$Txt_type[[2]])\
 & ($Txt_buffer[[4]]=$Txt_type[[1]])

// ----------------------------------------------------
// Return
$0:=$Boo_isGroup

// ----------------------------------------------------
// End