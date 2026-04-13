//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_Get_handle
// Database: 4D Labels
// ID[55F016B5ED764C3EA1372098F986D7E6]
// Created #7-4-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Text

var $Lon_parameters : Integer
var $Txt_handleID : Text
var $Obj_dialog : Object

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		// <NONE>
		
	End if 
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Txt_handleID:=OB Get:C1224($Obj_dialog; "handle"; Is text:K8:3)

// ----------------------------------------------------
// Return
$0:=$Txt_handleID

// ----------------------------------------------------
// End