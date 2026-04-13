//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_Get_color
// Database: 4D Labels
// ID[5B283F20E90248778B8B7E49D8E2D507]
// Created #6-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $0 : Integer
var $1 : Text

var $Lon_color; $Lon_parameters : Integer
var $Txt_target : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_target:=$1  //fill | stroke
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Lon_color:=OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; $Txt_target; Is longint:K8:6)

// ----------------------------------------------------
// Return
$0:=$Lon_color

// ----------------------------------------------------
// End