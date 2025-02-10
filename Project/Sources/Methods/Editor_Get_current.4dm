//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_Get_current
// Database: 4D Labels
// ID[C5EF9D164FE94570AA8665624529EEB4]
// Created #2-2-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($clear : Boolean) : Text

//C_TEXT($0)
//C_BOOLEAN($1)

var $count_parameters : Integer
var $Dom_current : Text
var $Obj_dialog : Object

If (False:C215)
	C_TEXT:C284(Editor_Get_current; $0)
	C_BOOLEAN:C305(Editor_Get_current; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($count_parameters>=1)
		
		//$Boo_clear:=$1
		
	End if 
	
	$Obj_dialog:=(OBJECT Get pointer:C1124(Object named:K67:5; "object"))->
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Dom_current:=OB Get:C1224($Obj_dialog; "DomCurrent"; Is text:K8:3)

If ($clear)
	
	OB SET:C1220($Obj_dialog; \
		"DomCurrent"; "")
	
End if 

// ----------------------------------------------------
// Return
return $Dom_current

// ----------------------------------------------------
// End