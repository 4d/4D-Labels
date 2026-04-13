//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_GET_CLICK
// Database: 4D Labels
// ID[46D9F354295F4677B99AD6C3B9441C67]
// Created #2-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Pointer
var $2 : Pointer

var $Lon_parameters : Integer
var $Ptr_x; $Ptr_y : Pointer
var $Obj_dialog : Object

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
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Ptr_x->:=OB Get:C1224($Obj_dialog; "clic-x"; Is longint:K8:6)
$Ptr_y->:=OB Get:C1224($Obj_dialog; "clic-y"; Is longint:K8:6)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End