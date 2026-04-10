//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Obj_SET_ENABLED
// Database: 4D Report
// ID[A690FCAE07CF4785B5F1C914E30ECF8E]
// Created #23-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Boolean
var $2 : Text
C_TEXT:C284(${3})

var $Boo_enabled : Boolean
var $Lon_i; $Lon_parameters : Integer
var $Txt_object : Text

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Boo_enabled:=$1
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 2; $Lon_parameters; 1)
	
	$Txt_object:=${$Lon_i}
	OBJECT SET ENABLED:C1123(*; $Txt_object; $Boo_enabled)
	OBJECT SET RGB COLORS:C628(*; $Txt_object; Choose:C955($Boo_enabled; Foreground color:K23:1; Dark shadow color:K23:3); Background color none:K23:10)
	
End for 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End