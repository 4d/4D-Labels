//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SET_CLICK
// Database: 4D Labels
// ID[D80F069C26434FECA81AD9CB1C005BEE]
// Created #2-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Integer
var $2 : Integer

var $Lon_mouseX; $Lon_mouseY; $Lon_parameters : Integer
var $Obj_dialog : Object

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_mouseX:=$1
		$Lon_mouseY:=$2
		
	End if 
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
OB SET:C1220($Obj_dialog; \
"clic-x"; $Lon_mouseX; \
"clic-y"; $Lon_mouseY)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End