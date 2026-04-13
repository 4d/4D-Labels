//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : IFF_Get_BOOL
// Database: 4D Labels
// ID[33DBA2E7D2E8484A9770AACC2AC5D897]
// Created #18-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Pointer
var $2 : Pointer
var $3 : Pointer
var $4 : Pointer

var $Lon_parameters; $Lon_value : Integer
var $Ptr_offset; $Ptr_source; $Ptr_value_1; $Ptr_value_2 : Pointer

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4; "Missing parameter"))
	
	//Required parameters
	ASSERT:C1129(Not:C34(Is nil pointer:C315($1)))
	ASSERT:C1129(Type:C295($1->)=Is BLOB:K8:12)
	
	$Ptr_source:=$1  //BLOB Ptr
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))
	ASSERT:C1129(Type:C295($2->)=Is boolean:K8:9)
	
	$Ptr_value_1:=$2  //boolean Ptr
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($3)))
	ASSERT:C1129(Type:C295($3->)=Is boolean:K8:9)
	
	$Ptr_value_2:=$3  //boolean Ptr
	
	ASSERT:C1129(Not:C34(Is nil pointer:C315($4)))
	ASSERT:C1129(Type:C295($4->)=Is longint:K8:6)
	
	$Ptr_offset:=$4  //offset Ptr
	
	//Optional parameters
	If ($Lon_parameters>=5)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Lon_value:=IFF_Get_short($Ptr_source; $Ptr_offset)

$Ptr_value_1->:=(1=$Lon_value)
$Ptr_value_2->:=(1=($Lon_value >> 8))

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End