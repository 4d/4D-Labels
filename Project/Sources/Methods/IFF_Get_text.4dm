//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : IFF_Get_text
// Database: 4D Labels
// ID[462938BC556E454AAD4C356D15A8E6C8]
// Created #18-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Text
var $1 : Pointer
var $2 : Pointer
var $3 : Integer

var $Lon_parameters; $Lon_textFormat : Integer
var $Ptr_offset; $Ptr_source : Pointer
var $Txt_text : Text

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
	
	$Lon_textFormat:=Mac text without length:K22:10
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		$Lon_textFormat:=$3
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Txt_text:=BLOB to text:C555($Ptr_source->; $Lon_textFormat; $Ptr_offset->; IFF_Get_long($Ptr_source; $Ptr_offset))

// ----------------------------------------------------
// Return
$0:=$Txt_text

// ----------------------------------------------------
// End