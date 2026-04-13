//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_GET_POINTS
// Database: 4D Labels
// ID[9C08E9C354064B1C96806C088B8250B0]
// Created #2-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Pointer
var $2 : Pointer

var $Lon_parameters : Integer
var $Ptr_object; $Ptr_x; $Ptr_y : Pointer

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Ptr_x:=$1
		$Ptr_y:=$2
		
	End if 
	
	$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5; "object")
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Ptr_x->:=OB Get:C1224($Ptr_object->; "point-x"; Is real:K8:4)
$Ptr_y->:=OB Get:C1224($Ptr_object->; "point-y"; Is real:K8:4)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End