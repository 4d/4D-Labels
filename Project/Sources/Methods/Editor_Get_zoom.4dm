//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_Get_zoom
// Database: 4D Labels
// ID[8CE001B69C3A4F0FA66C0B8D0D63F810]
// Created #2-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE() : Real

var $Lon_parameters : Integer
var $zoom : Real
var $Obj_dialog : Object



// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		//NONE
		
	End if 
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$zoom:=OB Get:C1224($Obj_dialog; "zoom"; Is real:K8:4)

// ----------------------------------------------------
// Return
return $zoom

// ----------------------------------------------------
// End