//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SET_POINTS
// Database: 4D Labels
// ID[EE40B406B042443DA59D4D1CD54DA1C4]
// Created #2-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Real
var $2 : Real

var $Lon_parameters : Integer
var $Ptr_object : Pointer
var $Num_x; $Num_y : Real

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Num_x:=$1
		$Num_y:=$2
		
	End if 
	
	$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5; "object")
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
OB SET:C1220($Ptr_object->; \
"point-x"; $Num_x; \
"point-y"; $Num_y)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End