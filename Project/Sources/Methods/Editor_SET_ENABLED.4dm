//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Editor_SET_ENABLED
// Database: 4D Labels
// ID[566243417CE24EE2AF7BA1ED6E6412E8]
// Created #2-7-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $1 : Boolean

var $Boo_enabled : Boolean
var $Lon_parameters : Integer


// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	$Boo_enabled:=True:C214  //default is enabled
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Boo_enabled:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//toolbar
OBJECT SET ENABLED:C1123(*; "tool.@"; $Boo_enabled)
OBJECT SET VISIBLE:C603(*; "action.@"; $Boo_enabled)

//shortcuts
OBJECT SET VISIBLE:C603(*; "shortcut.@"; $Boo_enabled)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End