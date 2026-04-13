//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : IFF_GET_RECT
// Database: 4D Labels
// ID[35EB7E44AC1C432EBE1B579318620D49]
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
var $5 : Pointer
var $6 : Pointer
var $7 : Integer

var $Lon_byteOrder; $Lon_parameters : Integer
var $Ptr_bottom; $Ptr_left; $Ptr_offset; $Ptr_right; $Ptr_source; $Ptr_top : Pointer

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=6; "Missing parameter"))
	
	//Required parameters
	$Ptr_source:=$1  //BLOB Ptr
	$Ptr_top:=$2
	$Ptr_left:=$3
	$Ptr_bottom:=$4
	$Ptr_right:=$5
	$Ptr_offset:=$6  //offset Ptr
	
	$Lon_byteOrder:=PC byte ordering:K22:3
	
	//Optional parameters
	If ($Lon_parameters>=7)
		
		$Lon_byteOrder:=$7  //{byte ordering} default PC byte ordering
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Ptr_top->:=BLOB to integer:C549($Ptr_source->; $Lon_byteOrder; $Ptr_offset->)
$Ptr_left->:=BLOB to integer:C549($Ptr_source->; $Lon_byteOrder; $Ptr_offset->)
$Ptr_bottom->:=BLOB to integer:C549($Ptr_source->; $Lon_byteOrder; $Ptr_offset->)
$Ptr_right->:=BLOB to integer:C549($Ptr_source->; $Lon_byteOrder; $Ptr_offset->)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End