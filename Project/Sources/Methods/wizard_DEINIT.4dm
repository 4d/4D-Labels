//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : lbw_DEINIT
// Database: 4D Labels
// ID[37B10F7C08C049D6AE2DB3BB3363627D]
// Created #17-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $Lon_parameters : Integer
var $Dom_canvas : Text
var $Obj_parameters : Object

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//close the xml structures
DOM CLOSE XML:C722(OB Get:C1224((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->; "dom"; Is text:K8:3))

$Obj_parameters:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"; "editor"))->

If (OB Is defined:C1231($Obj_parameters; "canvas"))
	
	$Dom_canvas:=OB Get:C1224($Obj_parameters; "canvas"; Is text:K8:3)
	
	If (xml_IsValidReference($Dom_canvas))
		
		DOM CLOSE XML:C722($Dom_canvas)
		
	End if 
End if 

//clear objects
CLEAR VARIABLE:C89((OBJECT Get pointer:C1124(Object named:K67:5; "layout"))->)
CLEAR VARIABLE:C89((OBJECT Get pointer:C1124(Object named:K67:5; "object"))->)
CLEAR VARIABLE:C89((OBJECT Get pointer:C1124(Object named:K67:5; "object"; "editor"))->)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End